import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as path;
import 'package:source_gen/source_gen.dart';

import 'src/constants.dart';
import 'src/factory_data.dart';
import 'src/parser.dart';
import 'src/templates/case_template.dart';

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
    final entries = <String, FactoryData>{};
    final input = buildStep.inputId;
    final libraryElement = await buildStep.resolver.libraryFor(input);
    final annotatedElements =
        extractAnnotatedElementFromLibrary(libraryElement);

    for (final annotatedElement in annotatedElements) {
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

      entries[targetName] = FactoryData.fromFunctionElement(element);
    }

    final cases = [
      for (final factoryData in entries.values)
        CaseTemplate(factoryData).toString(),
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
