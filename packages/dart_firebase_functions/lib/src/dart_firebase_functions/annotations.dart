sealed class FirestoreTriggeredAnnotation {
  const FirestoreTriggeredAnnotation();
}

class OnDocumentCreated extends FirestoreTriggeredAnnotation {
  const OnDocumentCreated(this.document);

  final String document;
}

class OnDocumentUpdated extends FirestoreTriggeredAnnotation {
  const OnDocumentUpdated(this.document);

  final String document;
}

class OnDocumentDeleted extends FirestoreTriggeredAnnotation {
  const OnDocumentDeleted(this.document);

  final String document;
}

class OnDocumentWritten extends FirestoreTriggeredAnnotation {
  const OnDocumentWritten(this.document);

  final String document;
}

class HTTPFunction {
  const HTTPFunction();
}
