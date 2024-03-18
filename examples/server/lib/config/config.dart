import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dart_firebase_admin/messaging.dart';

import 'environment_variable.dart';

final environmentVariable = EnvironmentVariable(EnvironmentProvider());

final adminApp = FirebaseAdminApp.initializeApp(
  environmentVariable.projectId,
  Credential.fromServiceAccountParams(
    clientId: environmentVariable.clientId,
    privateKey: environmentVariable.privateKey,
    email: environmentVariable.clientEmail,
  ),
);

final firestore = Firestore(adminApp);

final auth = Auth(adminApp);

final messaging = Messaging(adminApp);
