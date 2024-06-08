[![version][version-badge]][package]
[![PRs Welcome][prs-badge]](https://makeapullrequest.com)

# dart_firebase_functions

⚠️ Please note that this project is still in its early stages, so it may contain bugs and undergo frequent breaking changes.

## Motivation

This project aims to provide functionality similar to the Node.js `firebase-functions` package in Dart, using the [functions_framework](https://pub.dev/packages/functions_framework) and [dart_firebase_admin](https://pub.dev/packages/dart_firebase_admin) packages.

## How to use

### Install

Please add the following to your Flutter app's `pubspec.yaml`:

```yaml
dependencies:
  dart_firebase_admin: latest
  dart_firebase_functions: latest
  functions_framework: latest
  shelf:

dev_dependencies:
  build_runner:
  dart_firebase_functions_builder: latest
```

### Define `adminApp`

Before defining functions, it required to configure `FirebaseAdminApp` with your credentials.

```dart
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:functions_framework/functions_framework.dart';

final adminApp = FirebaseAdminApp.initializeApp(
  'your-project-id',
  Credential.fromServiceAccountParams(
    clientId: 'your-client-id',
    privateKey: 'your-private-key',
    email: 'your-client-email',
  ),
);

final firestore = Firestore(adminApp);

final auth = Auth(adminApp);

final messaging = Messaging(adminApp);
```

### Define HTTP function

Use `@HTTPFunction()` to define HTTP Function.

```dart
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:shelf/shelf.dart';

FirebaseAdminApp initializeAdminApp() => adminApp;

@HTTPFunction()
Future<Response> hello(Request request) async => Response.ok('Hello, World!');
```

Then, run `builder_runner` to generate codes.

```sh
dart pub run build_runner build -d
```

You will get the code like the following:

```dart
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
      _ => null
    };
```

### Define Cloud Firestore triggered function

In order to define Cloud Firestore document creation triggered function, use `@OnDocumentCreated` with the parameters like the following example.

```dart
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:functions_framework/functions_framework.dart';

FirebaseAdminApp initializeAdminApp() => adminApp;

@OnDocumentCreated('todos/{todoId}')
Future<void> oncreatetodo(
  ({String todoId}) params,
  QueryDocumentSnapshot snapshot,
  RequestContext context,
) async {
  context.logger.debug('todoId: ${params.todoId}');
  final data = snapshot.data();
  final title = data?['title'] as String?;
  await snapshot.ref.update({'title': '$title from server!'});
}
```

It is also possible to be triggered by nested document creation.

```dart
@OnDocumentCreated('todos/{todoId}/logs/{logId}')
Future<void> oncreatelog(
  ({String todoId, String logId}) params,
  QueryDocumentSnapshot snapshot,
  RequestContext context,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final data = snapshot.data();
  context.logger.debug('todoId: $todoId');
  context.logger.debug('logId: $logId');
  context.logger.debug('data: $data');
}
```

Then, run `builder_runner` to generate codes.

```sh
dart pub run build_runner build -d
```

You will get the code like the following:

```dart
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
      _ => null
    };
```

[version-badge]: https://img.shields.io/pub/v/dart_firebase_functions.svg
[package]: https://pub.dartlang.org/packages/dart_firebase_functions
[prs-badge]: https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square
