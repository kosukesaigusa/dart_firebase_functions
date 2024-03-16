import 'package:analyzer/dart/element/element.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:source_gen/source_gen.dart';

Iterable<AnnotatedElement> extractAnnotatedElementFromLibrary(
  LibraryElement libraryElement,
) sync* {
  final mergedElements = {
    ...libraryElement.topLevelElements,
    ...libraryElement.exportNamespace.definedNames.values,
  };

  for (final element in mergedElements) {
    const typeCheckers = [
      TypeChecker.fromRuntime(FirestoreTriggeredAnnotation),
      TypeChecker.fromRuntime(HTTPFunction),
    ];
    final annotations = typeCheckers
        .map((checker) => checker.annotationsOf(element))
        .expand((e) => e)
        .toList();
    if (annotations.isEmpty) {
      continue;
    }
    if (annotations.length > 1) {
      throw InvalidGenerationSourceError(
        'Annotation cannot be applied more than once.',
        element: element,
      );
    }
    yield AnnotatedElement(ConstantReader(annotations.single), element);
  }
}
