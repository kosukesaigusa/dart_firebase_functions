// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:functions_framework/serve.dart';
import 'package:server/functions.dart' as function_library;

Future<void> main(List<String> args) async {
  final app = function_library.initializeAdminApp();
  FirebaseFunctions.initialize(app);
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) => switch (name) {
      'hello' => FunctionTarget.http(
          function_library.hello,
        ),
      'oncreatetodo' => FunctionTarget.cloudEventWithContext((event, context) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.oncreatetodo(
            (todoId: documentIds['todoId']!),
            data.snapshot,
            context,
          );
        }),
      'onupdatetodo' => FunctionTarget.cloudEventWithContext((event, context) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.onupdatetodo(
            (todoId: documentIds['todoId']!),
            data.change.toRecord(),
            context,
          );
        }),
      'ondeletetodo' => FunctionTarget.cloudEventWithContext((event, context) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.ondeletetodo(
            (todoId: documentIds['todoId']!),
            data.snapshot,
            context,
          );
        }),
      'onwritetodo' => FunctionTarget.cloudEventWithContext((event, context) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.onwritetodo(
            (todoId: documentIds['todoId']!),
            data.optionalChange.toRecord(),
            context,
          );
        }),
      'oncreatelog' => FunctionTarget.cloudEventWithContext((event, context) {
          const pathPattern = 'todos/{todoId}/logs/{logId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.oncreatelog(
            (todoId: documentIds['todoId']!, logId: documentIds['logId']!),
            data.snapshot,
            context,
          );
        }),
      'oncreatesubmission' =>
        FunctionTarget.cloudEventWithContext((event, context) {
          const pathPattern = 'submissions/{submissionId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.oncreatesubmission(
            (submissionId: documentIds['submissionId']!),
            data.snapshot,
            context,
          );
        }),
      'createfirebaseauthcustomtoken' => FunctionTarget.httpWithLogger(
          function_library.createfirebaseauthcustomtoken,
        ),
      _ => null
    };
