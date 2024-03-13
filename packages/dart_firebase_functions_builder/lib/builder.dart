import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';

import 'src/constants.dart';

Builder dartFirebaseFunctionsBuilder([BuilderOptions? options]) =>
    const _DartFirebaseFunctionsBuilder();

class _DartFirebaseFunctionsBuilder implements Builder {
  const _DartFirebaseFunctionsBuilder();

  @override
  Map<String, List<String>> get buildExtensions => const {
        'lib/functions.dart': ['bin/server.dart'],
      };

  @override
  Future<void> build(BuildStep buildStep) async {
    final entries = <String, _FactoryData>{};
    final input = buildStep.inputId;
    final libraryElement = await buildStep.resolver.libraryFor(input);
    print('a');

    for (final annotatedElement in _fromLibrary(libraryElement)) {
      final element = annotatedElement.element;
      if (element is! FunctionElement || element.isPrivate) {
        throw InvalidGenerationSourceError(
          'Only top-level, public functions are supported.',
          element: element,
        );
      }

      final targetName = element.name;
      if (entries.containsKey(targetName)) {
        throw InvalidGenerationSourceError(
          'A function has already been annotated with target "$targetName".',
          element: element,
        );
      }

      entries[targetName] = _FactoryData(element.metadata.first);
    }

    final cases = [
      for (final key in entries.keys)
        """
'$key' => FunctionTarget.cloudEvent(
  (event) {
    const pathPattern = '${entries[key]!.pathPattern}';
    final documentIds = FirestorePathParser(pathPattern).parse(event.subject!);
    final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
    return function_library.$key((${entries[key]!.documentIds.map(
              (documentId) => "$documentId: documentIds['$documentId']!",
            ).join(',')}), ${switch (entries[key]!.firestoreDocumentEventType) {
          FirestoreDocumentEventType.v1Created => 'data.snapshot',
          FirestoreDocumentEventType.v1Updated => 'data.change.toRecord()',
          FirestoreDocumentEventType.v1Deleted => 'data.snapshot',
          FirestoreDocumentEventType.v1Written =>
            'data.optionalChange.toRecord()',
        }},);
  }),
""",
    ];

    final importDirectives = [
      "'package:dart_firebase_functions/dart_firebase_functions.dart'",
      "'package:functions_framework/serve.dart'",
      "'${input.uri}' as $functionsLibraryPrefix",
    ]..sort();

    var output = '''
// GENERATED CODE - DO NOT MODIFY BY HAND

${importDirectives.map((e) => 'import $e;').join('\n')}

Future<void> main(List<String> args) async {
  final app = function_library.initializeAdminApp();
  FirebaseFunctions.initialize(app);
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) =>
  switch (name) {
${cases.join('\n')}
  _ => null
  };
''';

    try {
      output = DartFormatter().format(output);
    } on FormatterException catch (e, stack) {
      log.warning('Could not format output.', e, stack);
    }

    await buildStep.writeAsString(
      AssetId(
        buildStep.inputId.package,
        path.join('bin', 'server.dart'),
      ),
      output,
    );
  }
}

class _FactoryData {
  const _FactoryData(this.annotation);

  final ElementAnnotation annotation;

  FirestoreDocumentEventType get firestoreDocumentEventType {
    final dartType = annotation.computeConstantValue()!.type!;
    if (const TypeChecker.fromRuntime(OnDocumentCreated)
        .isExactlyType(dartType)) {
      return FirestoreDocumentEventType.v1Created;
    } else if (const TypeChecker.fromRuntime(OnDocumentUpdated)
        .isExactlyType(dartType)) {
      return FirestoreDocumentEventType.v1Updated;
    } else if (const TypeChecker.fromRuntime(OnDocumentDeleted)
        .isExactlyType(dartType)) {
      return FirestoreDocumentEventType.v1Deleted;
    } else if (const TypeChecker.fromRuntime(OnDocumentWritten)
        .isExactlyType(dartType)) {
      return FirestoreDocumentEventType.v1Written;
    } else {
      throw Exception('Annotation format is not valid.');
    }
  }

  String get pathPattern {
    final source = annotation.toSource();
    final regex = RegExp("'(.*?)'");
    final match = regex.firstMatch(source);
    if (match == null) {
      throw Exception('Annotation format is not valid.');
    }
    return match.group(1)!;
  }

  List<String> get documentIds {
    final regex = RegExp(r'\{(\w+)\}');
    final matches = regex.allMatches(pathPattern);
    return matches.map((match) => match.group(1) ?? '').toList();
  }
}

Iterable<AnnotatedElement> _fromLibrary(LibraryElement library) sync* {
  final mergedElements = {
    ...library.topLevelElements,
    ...library.exportNamespace.definedNames.values,
  };

  for (final element in mergedElements) {
    const checker = TypeChecker.fromRuntime(FirestoreTriggeredAnnotation);
    final annotations = checker.annotationsOf(element).toList();

    if (annotations.isEmpty) {
      continue;
    }
    if (annotations.length > 1) {
      throw InvalidGenerationSourceError(
        'Cannot be annotated with `OnDocumentCreated` more than once.',
        element: element,
      );
    }
    yield AnnotatedElement(ConstantReader(annotations.single), element);
  }
}
