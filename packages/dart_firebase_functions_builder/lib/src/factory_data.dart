import 'package:analyzer/dart/element/element.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:source_gen/source_gen.dart';

sealed class FactoryData {
  const FactoryData(this.functionName);

  factory FactoryData.fromFunctionElement(FunctionElement functionElement) {
    final elementAnnotation = functionElement.metadata.single;
    final annotationType = elementAnnotation.computeConstantValue()!.type!;
    final parameter = functionElement.parameters.last;
    final parameterType = parameter.type;

    final isHTTPFunction = const TypeChecker.fromRuntime(HTTPFunction)
        .isExactlyType(annotationType);
    final isFirestoreTriggeredFunction =
        const TypeChecker.fromRuntime(FirestoreTriggeredAnnotation)
            .isAssignableFromType(annotationType);

    if (isHTTPFunction) {
      return HTTPFunctionFactoryData._(
        functionElement.name,
        hasRequestLoggerParameter: const TypeChecker.fromRuntime(RequestLogger)
            .isExactlyType(parameterType),
      );
    } else if (isFirestoreTriggeredFunction) {
      return FirestoreTriggerFactoryData._(
        functionElement.name,
        annotation: elementAnnotation,
        hasRequestContextParameter:
            const TypeChecker.fromRuntime(RequestContext)
                .isExactlyType(parameterType),
      );
    }
    throw InvalidGenerationSourceError(
      'Annotation format is not valid.',
      element: functionElement,
    );
  }

  final String functionName;
}

class HTTPFunctionFactoryData extends FactoryData {
  const HTTPFunctionFactoryData._(
    super.functionName, {
    required this.hasRequestLoggerParameter,
  });

  final bool hasRequestLoggerParameter;
}

class FirestoreTriggerFactoryData extends FactoryData {
  const FirestoreTriggerFactoryData._(
    super.functionName, {
    required ElementAnnotation annotation,
    required this.hasRequestContextParameter,
  }) : _annotation = annotation;

  final ElementAnnotation _annotation;

  final bool hasRequestContextParameter;

  FirestoreDocumentEventType get firestoreDocumentEventType {
    final dartType = _annotation.computeConstantValue()!.type!;
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
      throw InvalidGenerationSourceError(
        'Annotation format is not valid.',
        element: _annotation.element,
      );
    }
  }

  String get pathPattern {
    final source = _annotation.toSource();
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
