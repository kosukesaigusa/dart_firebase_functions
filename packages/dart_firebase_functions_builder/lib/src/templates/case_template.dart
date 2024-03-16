import 'package:dart_firebase_functions/dart_firebase_functions.dart';

import '../factory_data.dart';

class CaseTemplate {
  const CaseTemplate(this.factoryData);

  final FactoryData factoryData;

  @override
  String toString() {
    switch (factoryData) {
      case HTTPFunctionFactoryData(
          :final functionName,
          :final hasRequestLoggerParameter,
        ):
        return """
'$functionName' => FunctionTarget.http${hasRequestLoggerParameter ? 'WithLogger' : ''}(
  function_library.$functionName,
),
""";
      case FirestoreTriggerFactoryData(
          :final functionName,
          :final firestoreDocumentEventType,
          :final pathPattern,
          :final documentIds,
          :final hasRequestContextParameter,
        ):
        return """
'$functionName' => FunctionTarget.cloudEvent${hasRequestContextParameter ? 'WithContext' : ''}(
  (event${hasRequestContextParameter ? ', context' : ''}) {
    const pathPattern = '$pathPattern';
    final documentIds = FirestorePathParser(pathPattern).parse(event.subject!);
    final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
    return function_library.$functionName(
      (${documentIds.map((documentId) => "$documentId: documentIds['$documentId']!").join(',')}),
      ${_snapshotParameter(firestoreDocumentEventType)},
      ${hasRequestContextParameter ? 'context,' : ''}
    );
  }),
""";
    }
  }

  String _snapshotParameter(
    FirestoreDocumentEventType firestoreDocumentEventType,
  ) =>
      switch (firestoreDocumentEventType) {
        FirestoreDocumentEventType.v1Created => 'data.snapshot',
        FirestoreDocumentEventType.v1Updated => 'data.change.toRecord()',
        FirestoreDocumentEventType.v1Deleted => 'data.snapshot',
        FirestoreDocumentEventType.v1Written => 'data.optionalChange.toRecord()'
      };
}
