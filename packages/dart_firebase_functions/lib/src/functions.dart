import 'package:dart_firebase_admin/dart_firebase_admin.dart';

import 'dart_firebase_functions/annotations.dart';
import 'dart_firebase_functions/firebase_functions.dart';

FirebaseAdminApp initializeAdminApp() => FirebaseAdminApp.initializeApp(
      'project-id',
      throw UnimplementedError(),
    );

@OnDocumentCreated('todos/{todoId}')
Future<void> onCreateTodo(
  ({String todoId}) params,
  QueryDocumentSnapshot snapshot,
) async {
  final todoId = params.todoId;
  final data = snapshot.data();
}

@OnDocumentUpdated('todos/{todoId}')
Future<void> onUpdateTodo(
  ({String todoId}) params,
  ({QueryDocumentSnapshot before, QueryDocumentSnapshot after}) snapshot,
) async {
  final todoId = params.todoId;
  final before = snapshot.before.data();
  final after = snapshot.after.data();
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}')
Future<void> onCreateLog(
  ({String todoId, String logId}) params,
  QueryDocumentSnapshot snapshot,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final data = snapshot.data();
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}/foos/{fooId}')
Future<void> onCreateFoo(
  ({String todoId, String logId, String fooId}) params,
  QueryDocumentSnapshot snapshot,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final fooId = params.fooId;
  final data = snapshot.data();
}
