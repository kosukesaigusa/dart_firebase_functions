import 'package:dart_firebase_admin/auth.dart';
import 'package:dart_firebase_admin/dart_firebase_admin.dart';
import 'package:dart_firebase_admin/firestore.dart';
import 'package:dart_firebase_admin/messaging.dart';

import 'environment_variable.dart';

final _environmentVariable = EnvironmentVariable(EnvironmentProvider());

final adminApp = FirebaseAdminApp.initializeApp(
  _environmentVariable.projectId,
  Credential.fromServiceAccountParams(
    clientId: _environmentVariable.clientId,
    privateKey: _environmentVariable.privateKey,
    email: _environmentVariable.clientEmail,
  ),
);

final firestore = Firestore(adminApp);

final auth = Auth(adminApp);

final messaging = Messaging(adminApp);
