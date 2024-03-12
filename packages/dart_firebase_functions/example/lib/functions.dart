import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';

FirebaseAdminApp initializeAdminApp() => FirebaseAdminApp.initializeApp(
      'project-id',
      Credential.fromServiceAccountParams(
        clientId: 'client-id',
        privateKey: 'private-key',
        email: 'email',
      ),
    );

@OnDocumentCreated('todos/{todoId}')
Future<void> oncreatetodo(
  ({String todoId}) params,
  QueryDocumentSnapshot snapshot,
) async {
  final todoId = params.todoId;
  final data = snapshot.data();
}

@OnDocumentUpdated('todos/{todoId}')
Future<void> onupdatetodo(
  ({String todoId}) params,
  ({QueryDocumentSnapshot before, QueryDocumentSnapshot after}) snapshot,
) async {
  final todoId = params.todoId;
  final before = snapshot.before.data();
  final after = snapshot.after.data();
}

@OnDocumentDeleted('todos/{todoId}')
Future<void> ondeletetodo(
  ({String todoId}) params,
  QueryDocumentSnapshot snapshot,
) async {
  final todoId = params.todoId;
  final data = snapshot.data();
}

@OnDocumentWritten('todos/{todoId}')
Future<void> onwritetodo(
  ({String todoId}) params,
  ({QueryDocumentSnapshot? before, QueryDocumentSnapshot? after}) snapshot,
) async {
  final todoId = params.todoId;
  final before = snapshot.before?.data();
  final after = snapshot.after?.data();
}

@OnDocumentCreated('todos/{todoId}/logs/{logId}')
Future<void> oncreatelog(
  ({String todoId, String logId}) params,
  QueryDocumentSnapshot snapshot,
) async {
  final todoId = params.todoId;
  final logId = params.logId;
  final data = snapshot.data();
}
