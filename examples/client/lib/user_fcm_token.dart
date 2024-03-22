import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'user_fcm_token.flutterfire_gen.dart';

@FirestoreDocument(path: 'userFcmTokens/{userFcmTokenId}')
// ignore: unused_element
class _$UserFcmToken {
  const _$UserFcmToken({required this.token});

  final String token;
}
