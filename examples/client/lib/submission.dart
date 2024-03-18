import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterfire_gen_annotation/flutterfire_gen_annotation.dart';

part 'submission.flutterfire_gen.dart';

@FirestoreDocument(path: 'submissions/{submissionId}')
// ignore: unused_element
class _$Submission {
  const _$Submission({
    required this.title,
    required this.isVerified,
    required this.submittedByUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String title;

  @ReadDefault(false)
  @CreateDefault(false)
  final bool isVerified;

  final String? submittedByUserId;

  @alwaysUseFieldValueServerTimestampWhenCreating
  final DateTime? createdAt;

  @alwaysUseFieldValueServerTimestampWhenCreating
  @alwaysUseFieldValueServerTimestampWhenUpdating
  final DateTime? updatedAt;
}
