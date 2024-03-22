import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/messaging.dart';
import 'package:dart_firebase_functions/dart_firebase_functions.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:shelf/shelf.dart';

import 'config/config.dart';
import 'functions/create_firebase_auth_custom_token.dart';

FirebaseAdminApp initializeAdminApp() => adminApp;

@HTTPFunction()
Future<Response> hello(Request request) async => Response.ok('Hello, World!');

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

@OnDocumentUpdated('todos/{todoId}')
Future<void> onupdatetodo(
  ({String todoId}) params,
  ({QueryDocumentSnapshot before, QueryDocumentSnapshot after}) snapshot,
  RequestContext context,
) async {
  final todoId = params.todoId;
  final before = snapshot.before.data();
  final after = snapshot.after.data();
  context.logger.debug('todoId: $todoId');
  context.logger.debug('before: $before');
  context.logger.debug('after: $after');
}

@OnDocumentDeleted('todos/{todoId}')
Future<void> ondeletetodo(
  ({String todoId}) params,
  QueryDocumentSnapshot snapshot,
  RequestContext context,
) async {
  final todoId = params.todoId;
  final data = snapshot.data();
  context.logger.debug('todoId: $todoId');
  context.logger.debug('data: $data');
}

@OnDocumentWritten('todos/{todoId}')
Future<void> onwritetodo(
  ({String todoId}) params,
  ({QueryDocumentSnapshot? before, QueryDocumentSnapshot? after}) snapshot,
  RequestContext context,
) async {
  final todoId = params.todoId;
  final before = snapshot.before?.data();
  final after = snapshot.after?.data();
  context.logger.debug('todoId: $todoId');
  context.logger.debug('before: $before');
  context.logger.debug('after: $after');
}

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

@OnDocumentCreated('submissions/{submissionId}')
Future<void> oncreatesubmission(
  ({String submissionId}) params,
  QueryDocumentSnapshot snapshot,
  RequestContext context,
) async {
  final submissionId = params.submissionId;
  final submittedByUserId = snapshot.data()?['submittedByUserId'] as String?;
  if (submittedByUserId != null) {
    await snapshot.ref.update({'isVerified': true});
    context.logger.debug(
      'submission ($submissionId) submitted by $submittedByUserId is verified',
    );
    final userFcmTokenDocumentSnapshot = await firestore
        .collection('userFcmTokens')
        .doc(submittedByUserId)
        .get();
    final token = userFcmTokenDocumentSnapshot.data()?['token'] as String?;
    if (token != null) {
      const title = 'Submission Verified';
      const body = 'Your submission is verified!';
      final messageId = await messaging.send(
        TokenMessage(
          token: token,
          data: {
            'title': title,
            'body': body,
            'location': '',
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'status': 'done',
          },
          notification: Notification(title: title, body: body),
          apns: ApnsConfig(
            headers: {'apns-priority': '10'},
            payload: ApnsPayload(
              aps: Aps(
                contentAvailable: true,
                badge: 1,
                sound: null,
                alert: null,
                mutableContent: null,
                category: null,
                threadId: null,
              ),
            ),
          ),
          android: AndroidConfig(
            priority: AndroidConfigPriority.high,
            notification: AndroidNotification(
              priority: AndroidNotificationPriority.max,
              defaultSound: true,
              channelId: 'high-priority-channel',
              notificationCount: 1,
            ),
          ),
        ),
      );
      context.logger.debug(
        'message ($messageId) is sent to user ($submittedByUserId)',
      );
    }
  } else {
    context.logger.debug(
      '''submission ($submissionId) is not verified because submittedByUserId is null''',
    );
  }
}

@HTTPFunction()
Future<Response> createfirebaseauthcustomtoken(
  Request request,
  RequestLogger logger,
) async =>
    CreateFirebaseAuthCustomTokenFunction(request, logger).call();
