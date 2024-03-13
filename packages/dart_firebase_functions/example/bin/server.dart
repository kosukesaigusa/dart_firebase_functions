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
      'oncreatetodo' => FunctionTarget.cloudEvent((event) {
          const document = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(document).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.oncreatetodo(
            (todoId: documentIds['todoId']!),
            data.snapshot,
          );
        }),
      'onupdatetodo' => FunctionTarget.cloudEvent((event) {
          const document = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(document).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.onupdatetodo(
            (todoId: documentIds['todoId']!),
            data.change.toRecord(),
          );
        }),
      'ondeletetodo' => FunctionTarget.cloudEvent((event) {
          const document = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(document).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.ondeletetodo(
            (todoId: documentIds['todoId']!),
            data.snapshot,
          );
        }),
      'onwritetodo' => FunctionTarget.cloudEvent((event) {
          const document = 'todos/{todoId}';
          final documentIds =
              FirestorePathParser(document).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.onwritetodo(
            (todoId: documentIds['todoId']!),
            data.optionalChange.toRecord(),
          );
        }),
      'oncreatelog' => FunctionTarget.cloudEvent((event) {
          const document = 'todos/{todoId}/logs/{logId}';
          final documentIds =
              FirestorePathParser(document).parse(event.subject!);
          final data = QueryDocumentSnapshotBuilder(event).fromCloudEvent();
          return function_library.oncreatelog(
            (todoId: documentIds['todoId']!, logId: documentIds['logId']!),
            data.snapshot,
          );
        }),
      _ => null
    };
