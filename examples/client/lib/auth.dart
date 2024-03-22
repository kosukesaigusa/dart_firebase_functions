import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

@riverpod
FirebaseAuth _firebaseAuth(_FirebaseAuthRef _) => FirebaseAuth.instance;

@riverpod
Stream<User?> authUser(AuthUserRef ref) =>
    ref.watch(_firebaseAuthProvider).userChanges();

@riverpod
String? currentUserId(CurrentUserIdRef ref) {
  ref.watch(_firebaseAuthProvider).userChanges();
  return ref.watch(_firebaseAuthProvider).currentUser?.uid;
}

@riverpod
class Auth extends _$Auth {
  @override
  Future<User?> build() async => null;

  Future<void> signInAnonymously() async {
    state = const AsyncLoading<User?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      return userCredential.user;
    });
  }

  Future<void> signInWithLine() async {
    state = const AsyncLoading<User?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      final loginResult = await LineSDK.instance.login();
      final accessToken =
          loginResult.accessToken.data['access_token'] as String;
      final uri = Uri.parse(
        'https://createfirebaseauthcustomtoken-cwi73pbowq-an.a.run.app',
      );
      final response =
          await http.post(uri, body: jsonEncode({'accessToken': accessToken}));
      final customToken = (jsonDecode(response.body)
          as Map<String, dynamic>)['customToken'] as String;

      final userCredential =
          await FirebaseAuth.instance.signInWithCustomToken(customToken);
      return userCredential.user;
    });
  }

  Future<void> signOut() async {
    state = const AsyncLoading<User?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() async {
      await FirebaseAuth.instance.signOut();
      await LineSDK.instance.logout();
      return null;
    });
  }
}
