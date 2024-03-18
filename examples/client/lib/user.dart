import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'user.flutterfire_gen.dart';

@FirestoreDocument(path: 'users/{userId}')
// ignore: unused_element
class _$User {
  const _$User({
    required this.displayName,
    required this.imageUrl,
  });

  final String displayName;

  final String? imageUrl;
}
