// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:example/functions.dart' as function_library;
import 'package:functions_framework/serve.dart';

Future<void> main(List<String> args) async {
  final app = function_library.initializeAdminApp();
  FirebaseFunctions.initialize(app);
  await serve(args, _nameToFunctionTarget);
}

FunctionTarget? _nameToFunctionTarget(String name) => switch (name) {
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
      'onupdatetodo' => FunctionTarget.cloudEvent((event) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.onupdatetodo(
            (todoId: documentIds['todoId']!),
            data.change.toRecord(),
          );
        }),
      'ondeletetodo' => FunctionTarget.cloudEvent((event) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.ondeletetodo(
            (todoId: documentIds['todoId']!),
            data.snapshot,
          );
        }),
      'onwritetodo' => FunctionTarget.cloudEvent((event) {
          const pathPattern = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.onwritetodo(
            (todoId: documentIds['todoId']!),
            data.optionalChange.toRecord(),
          );
        }),
      'oncreatelog' => FunctionTarget.cloudEvent((event) {
          const pathPattern = 'todos/{todoId}/logs/{logId}';
          final documentIds =
              FirestorePathParser(pathPattern).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.oncreatelog(
            (todoId: documentIds['todoId']!, logId: documentIds['logId']!),
            data.snapshot,
          );
        }),
      'hello' => FunctionTarget.httpWithLogger(
          function_library.hello,
        ),
      _ => null
    };
