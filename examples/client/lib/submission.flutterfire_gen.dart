// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submission.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class Submission {
  const Submission({
    required this.title,
    required this.isVerified,
    required this.submittedByUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.submissionId,
    required this.path,
    required this.submissionReference,
  });

  final String title;

  final bool isVerified;

  final String? submittedByUserId;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  final String submissionId;

  final String path;

  final DocumentReference<Submission> submissionReference;

  factory Submission.fromJson(Map<String, dynamic> json) {
    final extendedJson = <String, dynamic>{
      ...json,
    };
    return Submission(
      title: extendedJson['title'] as String,
      isVerified: extendedJson['isVerified'] as bool? ?? false,
      submittedByUserId: extendedJson['submittedByUserId'] as String?,
      createdAt: (extendedJson['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (extendedJson['updatedAt'] as Timestamp?)?.toDate(),
      submissionId: extendedJson['submissionId'] as String,
      path: extendedJson['path'] as String,
      submissionReference:
          extendedJson['submissionReference'] as DocumentReference<Submission>,
    );
  }

  factory Submission.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Submission.fromJson(<String, dynamic>{
      ...data,
      'submissionId': ds.id,
      'path': ds.reference.path,
      'submissionReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => Submission.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  Submission copyWith({
    String? title,
    bool? isVerified,
    String? submittedByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? submissionId,
    String? path,
    DocumentReference<Submission>? submissionReference,
  }) {
    return Submission(
      title: title ?? this.title,
      isVerified: isVerified ?? this.isVerified,
      submittedByUserId: submittedByUserId ?? this.submittedByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      submissionId: submissionId ?? this.submissionId,
      path: path ?? this.path,
      submissionReference: submissionReference ?? this.submissionReference,
    );
  }
}

/// Represents the data structure for creating a new submission document in Cloud Firestore.
///
/// This class is used to define the necessary data for creating a new submission document.
/// `@alwaysUseFieldValueServerTimestampWhenCreating` annotated fields are
/// automatically set to the server's timestamp.
class CreateSubmissionData {
  const CreateSubmissionData({
    required this.title,
    this.isVerified,
    this.submittedByUserId,
  });

  final String title;

  final bool? isVerified;

  final String? submittedByUserId;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'title': title,
      'isVerified': isVerified ?? false,
      'submittedByUserId': submittedByUserId,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for updating a submission document in Cloud Firestore.
///
/// This class provides a way to specify which fields of a submission document should
/// be updated. Fields set to `null` will not be updated. It also automatically
/// sets the `@alwaysUseFieldValueServerTimestampWhenUpdating` annotated fields
/// to the server's timestamp upon updating.
class UpdateSubmissionData {
  const UpdateSubmissionData({
    this.title,
    this.isVerified,
    this.submittedByUserId,
    this.createdAt,
  });

  final String? title;

  final bool? isVerified;

  final String? submittedByUserId;

  final DateTime? createdAt;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (title != null) 'title': title,
      if (isVerified != null) 'isVerified': isVerified,
      if (submittedByUserId != null) 'submittedByUserId': submittedByUserId,
      if (createdAt != null)
        'createdAt': createdAt == null ? null : Timestamp.fromDate(createdAt!),
      'updatedAt': FieldValue.serverTimestamp(),
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for deleting a submission document in Cloud Firestore.
class DeleteSubmission {}

/// Reference to the 'submissions' collection with a converter for [Submission].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents to [Submission] objects.
final readSubmissionsCollectionReference = FirebaseFirestore.instance
    .collection('submissions')
    .withConverter<Submission>(
      fromFirestore: (ds, _) => Submission.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Creates a [DocumentReference] for a specific Submission document.
DocumentReference<Submission> readSubmissionDocumentReference({
  required String submissionId,
}) =>
    readSubmissionsCollectionReference.doc(submissionId);

/// Reference to the 'submissions' collection with a converter for [CreateSubmissionData].
/// This enables type-safe create operations in Firestore, converting
/// [CreateSubmissionData] objects to Firestore document data.
final createSubmissionsCollectionReference = FirebaseFirestore.instance
    .collection('submissions')
    .withConverter<CreateSubmissionData>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Creates a [DocumentReference] for a specific Submission document.
DocumentReference<CreateSubmissionData> createSubmissionDocumentReference({
  required String submissionId,
}) =>
    createSubmissionsCollectionReference.doc(submissionId);

/// Reference to the 'submissions' collection with a converter for [UpdateSubmissionData].
/// This allows for type-safe update operations in Firestore, converting
/// [UpdateSubmissionData] objects to Firestore document data.
final updateSubmissionsCollectionReference = FirebaseFirestore.instance
    .collection('submissions')
    .withConverter<UpdateSubmissionData>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Creates a [DocumentReference] for a specific Submission document.
DocumentReference<UpdateSubmissionData> updateSubmissionDocumentReference({
  required String submissionId,
}) =>
    updateSubmissionsCollectionReference.doc(submissionId);

/// Reference to the 'submissions' collection with a converter for [DeleteSubmission].
/// This reference is used specifically for delete operations and does not
/// support reading or writing data to Firestore.
final deleteSubmissionsCollectionReference = FirebaseFirestore.instance
    .collection('submissions')
    .withConverter<DeleteSubmission>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Creates a [DocumentReference] for a specific Submission document.
DocumentReference<DeleteSubmission> deleteSubmissionDocumentReference({
  required String submissionId,
}) =>
    deleteSubmissionsCollectionReference.doc(submissionId);

/// Reference to the 'submissions' collection group with a converter for [Submission].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents from various paths in the 'submissions' collection group
/// into [Submission] objects. It facilitates unified handling of 'submissions' documents
/// scattered across different locations in Firestore, ensuring consistent
/// data structure and manipulation.
final readSubmissionsCollectionGroupReference = FirebaseFirestore.instance
    .collectionGroup('submissions')
    .withConverter<Submission>(
      fromFirestore: (ds, _) => Submission.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// A sealed class that serves as a base for representing batch write operations in Firestore.
///
/// This class is the abstract base for subclasses that define specific types
/// of batch operations, such as creating, updating, or deleting submission documents.
/// It is used as a part of a type hierarchy for batch operations and is not
/// intended for direct instantiation. Instead, it establishes a common
/// interface and structure for various types of batch write operations.
///
/// The use of a sealed class here ensures type safety and polymorphic handling
/// of different batch operation types, while allowing specific implementations
/// in the subclasses.
sealed class BatchWriteSubmission {
  const BatchWriteSubmission();
}

/// Represents a batch operation for creating a submission document in Firestore.
///
/// This class is used as part of a batch write to Firestore, specifically for
/// creating new submission documents. It encapsulates the ID of the new submission document
/// and the data required for creation.
final class BatchCreateSubmission extends BatchWriteSubmission {
  const BatchCreateSubmission({
    required this.submissionId,
    required this.createSubmissionData,
  });

  final String submissionId;

  final CreateSubmissionData createSubmissionData;
}

/// Represents a batch operation for updating an existing submission document in Firestore.
///
/// This class is utilized in a batch write process to Firestore, allowing for
/// the update of existing submission documents. It includes the submission document's ID
/// and the data for the update.
final class BatchUpdateSubmission extends BatchWriteSubmission {
  const BatchUpdateSubmission({
    required this.submissionId,
    required this.updateSubmissionData,
  });

  final String submissionId;

  final UpdateSubmissionData updateSubmissionData;
}

// Represents a batch operation for deleting a submission document in Firestore.
///
/// Used in a batch write to Firestore for deleting a submission document. This class
/// only requires the ID of the submission document to be deleted, as no additional
/// data is needed for deletion.
final class BatchDeleteSubmission extends BatchWriteSubmission {
  const BatchDeleteSubmission({
    required this.submissionId,
  });

  final String submissionId;
}

/// A service class for managing submission documents in the database.
///
/// This class provides methods to perform CRUD (Create, Read, Update, Delete)
/// operations on submission documents, along with additional utilities like counting
/// documents, and calculating sum and average values for specific fields.
///
/// It includes methods to:
///
/// - Fetch single or multiple [Submission] documents ([fetchDocuments], [fetchDocument]).
/// - Subscribe to real-time updates of single or multiple [Submission] documents ([subscribeDocuments], [subscribeDocument]).
/// - Count documents based on queries ([count]).
/// - Calculate sum ([getSum]) and average ([getAverage]) of specific fields across documents.
/// - Add ([add]), set ([set]), update ([update]), and delete ([delete]) submission documents.
///
/// The class uses Firebase Firestore as the backend, assuming [Submission],
/// [CreateSubmissionData], [UpdateSubmissionData] are models representing the data.
///
/// Usage:
///
/// - To fetch or subscribe to submission documents, or to count them, use the corresponding fetch, subscribe, and count methods.
/// - To modify submission documents, use the methods for adding, setting, updating, or deleting.
/// - To perform aggregate calculations like sum and average, use [getSum] and [getAverage].
///
/// This class abstracts the complexities of direct Firestore usage and provides
/// a straightforward API for submission document operations.
class SubmissionQuery {
  /// Fetches a list of [Submission] documents from Cloud Firestore.
  ///
  /// This method retrieves documents based on the provided query and sorts them
  /// if a [compare] function is given. You can customize the query by using the
  /// [queryBuilder] and control the source of the documents with [options].
  /// The [asCollectionGroup] parameter determines whether to fetch documents
  /// from the 'submissions' collection directly (false) or as a collection group across
  /// different Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [options] Optional [GetOptions] to define the source of the documents (server, cache).
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the Submission documents.
  /// - [asCollectionGroup] Fetch the 'submissions' as a collection group if true.
  ///
  /// Returns a list of [Submission] documents.
  Future<List<Submission>> fetchDocuments({
    GetOptions? options,
    Query<Submission>? Function(Query<Submission> query)? queryBuilder,
    int Function(Submission lhs, Submission rhs)? compare,
    bool asCollectionGroup = false,
  }) async {
    Query<Submission> query = asCollectionGroup
        ? readSubmissionsCollectionGroupReference
        : readSubmissionsCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final qs = await query.get(options);
    final result = qs.docs.map((qds) => qds.data()).toList();
    if (compare != null) {
      result.sort(compare);
    }
    return result;
  }

  /// Subscribes to a stream of [Submission] documents from Cloud Firestore.
  ///
  /// This method returns a stream of [Submission] documents, which updates in
  /// real-time based on the database changes. You can customize the query using
  /// [queryBuilder]. The documents can be sorted using the [compare] function.
  /// The [asCollectionGroup] parameter determines whether to query the 'submissions'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the Submission documents.
  /// - [includeMetadataChanges] Include metadata changes in the stream.
  /// - [excludePendingWrites] Exclude documents with pending writes from the stream.
  /// - [asCollectionGroup] Query the 'submissions' as a collection group if true.
  Stream<List<Submission>> subscribeDocuments({
    Query<Submission>? Function(Query<Submission> query)? queryBuilder,
    int Function(Submission lhs, Submission rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
    bool asCollectionGroup = false,
  }) {
    Query<Submission> query = asCollectionGroup
        ? readSubmissionsCollectionGroupReference
        : readSubmissionsCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    var streamQs =
        query.snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamQs = streamQs.where((qs) => !qs.metadata.hasPendingWrites);
    }
    return streamQs.map((qs) {
      final result = qs.docs.map((qds) => qds.data()).toList();
      if (compare != null) {
        result.sort(compare);
      }
      return result;
    });
  }

  /// Counts the number of submission documents in Cloud Firestore.
  ///
  /// This method returns the count of documents based on the provided query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to count documents
  /// in the 'submissions' collection directly (false) or across various Firestore
  /// paths as a collection group (true). The [source] parameter allows you to
  /// specify whether to count documents from the server or the local cache.
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [source] Source of the count, either from the server or local cache.
  /// - [asCollectionGroup] Count the 'submissions' as a collection group if true.
  ///
  /// Returns the count of documents as an integer.
  Future<int?> count({
    Query<Submission>? Function(Query<Submission> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<Submission> query = asCollectionGroup
        ? readSubmissionsCollectionGroupReference
        : readSubmissionsCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.count();
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.count;
  }

  /// Returns the sum of the values of the documents that match the query.
  ///
  /// This method returns the sum of the values of the documents that match the query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to query the 'submissions'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to sum over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'submissions' as a collection group if true.
  ///
  /// Returns the sum of the values of the documents that match the query.
  Future<double?> getSum({
    required String field,
    Query<Submission>? Function(Query<Submission> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<Submission> query = asCollectionGroup
        ? readSubmissionsCollectionGroupReference
        : readSubmissionsCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.aggregate(sum(field));
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.getSum(field);
  }

  /// Returns the average of the values of the documents that match the query.
  ///
  /// This method returns the average of the values of the documents that match the query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to query the 'submissions'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to average over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'submissions' as a collection group if true.
  ///
  /// Returns the average of the values of the documents that match the query.
  Future<double?> getAverage({
    required String field,
    Query<Submission>? Function(Query<Submission> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<Submission> query = asCollectionGroup
        ? readSubmissionsCollectionGroupReference
        : readSubmissionsCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.aggregate(average(field));
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.getAverage(field);
  }

  /// Fetches a single [Submission] document from Cloud Firestore by its ID.
  ///
  /// This method retrieves a specific document using the provided [submissionId].
  /// You can control the data retrieval with [GetOptions].
  Future<Submission?> fetchDocument({
    required String submissionId,
    GetOptions? options,
  }) async {
    final ds = await readSubmissionDocumentReference(
      submissionId: submissionId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes to a stream of a single [Submission] document from Cloud Firestore by its ID.
  ///
  /// This method returns a stream of a single [Submission] document, which updates in
  /// real-time based on the database changes. You can control the data retrieval with [GetOptions].
  Stream<Submission?> subscribeDocument({
    required String submissionId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readSubmissionDocumentReference(
      submissionId: submissionId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a submission document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createSubmission] data.
  Future<DocumentReference<CreateSubmissionData>> add({
    required CreateSubmissionData createSubmissionData,
  }) =>
      createSubmissionsCollectionReference.add(createSubmissionData);

  /// Sets a submission document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createSubmission] data.
  Future<void> set({
    required String submissionId,
    required CreateSubmissionData createSubmissionData,
    SetOptions? options,
  }) =>
      createSubmissionDocumentReference(
        submissionId: submissionId,
      ).set(createSubmissionData, options);

  /// Updates a submission document in Cloud Firestore.
  ///
  /// This method partially updates the document identified by [submissionId] with the
  /// provided [updateSubmission] data.
  /// The update is based on the structure defined in `UpdateSubmissionData.toJson()`.
  Future<void> update({
    required String submissionId,
    required UpdateSubmissionData updateSubmissionData,
  }) =>
      updateSubmissionDocumentReference(
        submissionId: submissionId,
      ).update(updateSubmissionData.toJson());

  /// Deletes a submission document from Cloud Firestore.
  ///
  /// This method deletes an existing document identified by [submissionId].
  Future<void> delete({
    required String submissionId,
  }) =>
      deleteSubmissionDocumentReference(
        submissionId: submissionId,
      ).delete();

  /// Performs a batch write operation in Firestore using a list of [BatchWriteSubmission] tasks.
  ///
  /// This function allows for executing multiple Firestore write operations (create, update, delete)
  /// as a single batch. This ensures that all operations either complete successfully or fail
  /// without applying any changes, providing atomicity.
  ///
  /// Parameters:
  ///
  /// - [batchWriteTasks] A list of [BatchWriteSubmission] objects, each representing a specific
  /// write operation (create, update, or delete) for Submission documents.
  ///
  /// The function iterates over each task in [batchWriteTasks] and performs the corresponding
  /// Firestore operation. This includes:
  ///
  /// - Creating new documents for tasks of type [BatchCreateSubmission].
  /// - Updating existing documents for tasks of type [BatchUpdateSubmission].
  /// - Deleting documents for tasks of type [BatchDeleteSubmission].
  ///
  /// Returns a `Future<void>` that completes when the batch operation is committed successfully.
  ///
  /// Throws:
  ///
  /// - Firestore exceptions if the batch commit fails or if there are issues with the individual
  /// operations within the batch.
  Future<void> batchWrite(List<BatchWriteSubmission> batchWriteTasks) {
    final batch = FirebaseFirestore.instance.batch();
    for (final task in batchWriteTasks) {
      switch (task) {
        case BatchCreateSubmission(
            submissionId: final submissionId,
            createSubmissionData: final createSubmissionData,
          ):
          batch.set(
            createSubmissionDocumentReference(
              submissionId: submissionId,
            ),
            createSubmissionData,
          );
        case BatchUpdateSubmission(
            submissionId: final submissionId,
            updateSubmissionData: final updateSubmissionData,
          ):
          batch.update(
            updateSubmissionDocumentReference(
              submissionId: submissionId,
            ),
            updateSubmissionData.toJson(),
          );
        case BatchDeleteSubmission(submissionId: final submissionId):
          batch.delete(deleteSubmissionDocumentReference(
            submissionId: submissionId,
          ));
      }
    }
    return batch.commit();
  }
}
