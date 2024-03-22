// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_fcm_token.dart';

// **************************************************************************
// Generator: FlutterFireGen
// **************************************************************************

class UserFcmToken {
  const UserFcmToken({
    required this.token,
    required this.userFcmTokenId,
    required this.path,
    required this.userFcmTokenReference,
  });

  final String token;

  final String userFcmTokenId;

  final String path;

  final DocumentReference<UserFcmToken> userFcmTokenReference;

  factory UserFcmToken.fromJson(Map<String, dynamic> json) {
    final extendedJson = <String, dynamic>{
      ...json,
    };
    return UserFcmToken(
      token: extendedJson['token'] as String,
      userFcmTokenId: extendedJson['userFcmTokenId'] as String,
      path: extendedJson['path'] as String,
      userFcmTokenReference: extendedJson['userFcmTokenReference']
          as DocumentReference<UserFcmToken>,
    );
  }

  factory UserFcmToken.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return UserFcmToken.fromJson(<String, dynamic>{
      ...data,
      'userFcmTokenId': ds.id,
      'path': ds.reference.path,
      'userFcmTokenReference': ds.reference.parent.doc(ds.id).withConverter(
            fromFirestore: (ds, _) => UserFcmToken.fromDocumentSnapshot(ds),
            toFirestore: (obj, _) => throw UnimplementedError(),
          ),
    });
  }

  UserFcmToken copyWith({
    String? token,
    String? userFcmTokenId,
    String? path,
    DocumentReference<UserFcmToken>? userFcmTokenReference,
  }) {
    return UserFcmToken(
      token: token ?? this.token,
      userFcmTokenId: userFcmTokenId ?? this.userFcmTokenId,
      path: path ?? this.path,
      userFcmTokenReference:
          userFcmTokenReference ?? this.userFcmTokenReference,
    );
  }
}

/// Represents the data structure for creating a new userFcmToken document in Cloud Firestore.
///
/// This class is used to define the necessary data for creating a new userFcmToken document.
/// `@alwaysUseFieldValueServerTimestampWhenCreating` annotated fields are
/// automatically set to the server's timestamp.
class CreateUserFcmTokenData {
  const CreateUserFcmTokenData({
    required this.token,
  });

  final String token;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'token': token,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for updating a userFcmToken document in Cloud Firestore.
///
/// This class provides a way to specify which fields of a userFcmToken document should
/// be updated. Fields set to `null` will not be updated. It also automatically
/// sets the `@alwaysUseFieldValueServerTimestampWhenUpdating` annotated fields
/// to the server's timestamp upon updating.
class UpdateUserFcmTokenData {
  const UpdateUserFcmTokenData({
    this.token,
  });

  final String? token;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      if (token != null) 'token': token,
    };
    final jsonPostProcessors = <({String key, dynamic value})>[];
    return {
      ...json,
      ...Map.fromEntries(jsonPostProcessors
          .map((record) => MapEntry(record.key, record.value))),
    };
  }
}

/// Represents the data structure for deleting a userFcmToken document in Cloud Firestore.
class DeleteUserFcmToken {}

/// Reference to the 'userFcmTokens' collection with a converter for [UserFcmToken].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents to [UserFcmToken] objects.
final readUserFcmTokensCollectionReference = FirebaseFirestore.instance
    .collection('userFcmTokens')
    .withConverter<UserFcmToken>(
      fromFirestore: (ds, _) => UserFcmToken.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Creates a [DocumentReference] for a specific UserFcmToken document.
DocumentReference<UserFcmToken> readUserFcmTokenDocumentReference({
  required String userFcmTokenId,
}) =>
    readUserFcmTokensCollectionReference.doc(userFcmTokenId);

/// Reference to the 'userFcmTokens' collection with a converter for [CreateUserFcmTokenData].
/// This enables type-safe create operations in Firestore, converting
/// [CreateUserFcmTokenData] objects to Firestore document data.
final createUserFcmTokensCollectionReference = FirebaseFirestore.instance
    .collection('userFcmTokens')
    .withConverter<CreateUserFcmTokenData>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Creates a [DocumentReference] for a specific UserFcmToken document.
DocumentReference<CreateUserFcmTokenData> createUserFcmTokenDocumentReference({
  required String userFcmTokenId,
}) =>
    createUserFcmTokensCollectionReference.doc(userFcmTokenId);

/// Reference to the 'userFcmTokens' collection with a converter for [UpdateUserFcmTokenData].
/// This allows for type-safe update operations in Firestore, converting
/// [UpdateUserFcmTokenData] objects to Firestore document data.
final updateUserFcmTokensCollectionReference = FirebaseFirestore.instance
    .collection('userFcmTokens')
    .withConverter<UpdateUserFcmTokenData>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (obj, _) => obj.toJson(),
    );

/// Creates a [DocumentReference] for a specific UserFcmToken document.
DocumentReference<UpdateUserFcmTokenData> updateUserFcmTokenDocumentReference({
  required String userFcmTokenId,
}) =>
    updateUserFcmTokensCollectionReference.doc(userFcmTokenId);

/// Reference to the 'userFcmTokens' collection with a converter for [DeleteUserFcmToken].
/// This reference is used specifically for delete operations and does not
/// support reading or writing data to Firestore.
final deleteUserFcmTokensCollectionReference = FirebaseFirestore.instance
    .collection('userFcmTokens')
    .withConverter<DeleteUserFcmToken>(
      fromFirestore: (_, __) => throw UnimplementedError(),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// Creates a [DocumentReference] for a specific UserFcmToken document.
DocumentReference<DeleteUserFcmToken> deleteUserFcmTokenDocumentReference({
  required String userFcmTokenId,
}) =>
    deleteUserFcmTokensCollectionReference.doc(userFcmTokenId);

/// Reference to the 'userFcmTokens' collection group with a converter for [UserFcmToken].
/// This allows for type-safe read operations from Firestore, converting
/// Firestore documents from various paths in the 'userFcmTokens' collection group
/// into [UserFcmToken] objects. It facilitates unified handling of 'userFcmTokens' documents
/// scattered across different locations in Firestore, ensuring consistent
/// data structure and manipulation.
final readUserFcmTokensCollectionGroupReference = FirebaseFirestore.instance
    .collectionGroup('userFcmTokens')
    .withConverter<UserFcmToken>(
      fromFirestore: (ds, _) => UserFcmToken.fromDocumentSnapshot(ds),
      toFirestore: (_, __) => throw UnimplementedError(),
    );

/// A sealed class that serves as a base for representing batch write operations in Firestore.
///
/// This class is the abstract base for subclasses that define specific types
/// of batch operations, such as creating, updating, or deleting userFcmToken documents.
/// It is used as a part of a type hierarchy for batch operations and is not
/// intended for direct instantiation. Instead, it establishes a common
/// interface and structure for various types of batch write operations.
///
/// The use of a sealed class here ensures type safety and polymorphic handling
/// of different batch operation types, while allowing specific implementations
/// in the subclasses.
sealed class BatchWriteUserFcmToken {
  const BatchWriteUserFcmToken();
}

/// Represents a batch operation for creating a userFcmToken document in Firestore.
///
/// This class is used as part of a batch write to Firestore, specifically for
/// creating new userFcmToken documents. It encapsulates the ID of the new userFcmToken document
/// and the data required for creation.
final class BatchCreateUserFcmToken extends BatchWriteUserFcmToken {
  const BatchCreateUserFcmToken({
    required this.userFcmTokenId,
    required this.createUserFcmTokenData,
  });

  final String userFcmTokenId;

  final CreateUserFcmTokenData createUserFcmTokenData;
}

/// Represents a batch operation for updating an existing userFcmToken document in Firestore.
///
/// This class is utilized in a batch write process to Firestore, allowing for
/// the update of existing userFcmToken documents. It includes the userFcmToken document's ID
/// and the data for the update.
final class BatchUpdateUserFcmToken extends BatchWriteUserFcmToken {
  const BatchUpdateUserFcmToken({
    required this.userFcmTokenId,
    required this.updateUserFcmTokenData,
  });

  final String userFcmTokenId;

  final UpdateUserFcmTokenData updateUserFcmTokenData;
}

// Represents a batch operation for deleting a userFcmToken document in Firestore.
///
/// Used in a batch write to Firestore for deleting a userFcmToken document. This class
/// only requires the ID of the userFcmToken document to be deleted, as no additional
/// data is needed for deletion.
final class BatchDeleteUserFcmToken extends BatchWriteUserFcmToken {
  const BatchDeleteUserFcmToken({
    required this.userFcmTokenId,
  });

  final String userFcmTokenId;
}

/// A service class for managing userFcmToken documents in the database.
///
/// This class provides methods to perform CRUD (Create, Read, Update, Delete)
/// operations on userFcmToken documents, along with additional utilities like counting
/// documents, and calculating sum and average values for specific fields.
///
/// It includes methods to:
///
/// - Fetch single or multiple [UserFcmToken] documents ([fetchDocuments], [fetchDocument]).
/// - Subscribe to real-time updates of single or multiple [UserFcmToken] documents ([subscribeDocuments], [subscribeDocument]).
/// - Count documents based on queries ([count]).
/// - Calculate sum ([getSum]) and average ([getAverage]) of specific fields across documents.
/// - Add ([add]), set ([set]), update ([update]), and delete ([delete]) userFcmToken documents.
///
/// The class uses Firebase Firestore as the backend, assuming [UserFcmToken],
/// [CreateUserFcmTokenData], [UpdateUserFcmTokenData] are models representing the data.
///
/// Usage:
///
/// - To fetch or subscribe to userFcmToken documents, or to count them, use the corresponding fetch, subscribe, and count methods.
/// - To modify userFcmToken documents, use the methods for adding, setting, updating, or deleting.
/// - To perform aggregate calculations like sum and average, use [getSum] and [getAverage].
///
/// This class abstracts the complexities of direct Firestore usage and provides
/// a straightforward API for userFcmToken document operations.
class UserFcmTokenQuery {
  /// Fetches a list of [UserFcmToken] documents from Cloud Firestore.
  ///
  /// This method retrieves documents based on the provided query and sorts them
  /// if a [compare] function is given. You can customize the query by using the
  /// [queryBuilder] and control the source of the documents with [options].
  /// The [asCollectionGroup] parameter determines whether to fetch documents
  /// from the 'userFcmTokens' collection directly (false) or as a collection group across
  /// different Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [options] Optional [GetOptions] to define the source of the documents (server, cache).
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the UserFcmToken documents.
  /// - [asCollectionGroup] Fetch the 'userFcmTokens' as a collection group if true.
  ///
  /// Returns a list of [UserFcmToken] documents.
  Future<List<UserFcmToken>> fetchDocuments({
    GetOptions? options,
    Query<UserFcmToken>? Function(Query<UserFcmToken> query)? queryBuilder,
    int Function(UserFcmToken lhs, UserFcmToken rhs)? compare,
    bool asCollectionGroup = false,
  }) async {
    Query<UserFcmToken> query = asCollectionGroup
        ? readUserFcmTokensCollectionGroupReference
        : readUserFcmTokensCollectionReference;
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

  /// Subscribes to a stream of [UserFcmToken] documents from Cloud Firestore.
  ///
  /// This method returns a stream of [UserFcmToken] documents, which updates in
  /// real-time based on the database changes. You can customize the query using
  /// [queryBuilder]. The documents can be sorted using the [compare] function.
  /// The [asCollectionGroup] parameter determines whether to query the 'userFcmTokens'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [compare] Optional function to sort the UserFcmToken documents.
  /// - [includeMetadataChanges] Include metadata changes in the stream.
  /// - [excludePendingWrites] Exclude documents with pending writes from the stream.
  /// - [asCollectionGroup] Query the 'userFcmTokens' as a collection group if true.
  Stream<List<UserFcmToken>> subscribeDocuments({
    Query<UserFcmToken>? Function(Query<UserFcmToken> query)? queryBuilder,
    int Function(UserFcmToken lhs, UserFcmToken rhs)? compare,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
    bool asCollectionGroup = false,
  }) {
    Query<UserFcmToken> query = asCollectionGroup
        ? readUserFcmTokensCollectionGroupReference
        : readUserFcmTokensCollectionReference;
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

  /// Counts the number of userFcmToken documents in Cloud Firestore.
  ///
  /// This method returns the count of documents based on the provided query.
  /// You can customize the query by using the [queryBuilder].
  /// The [asCollectionGroup] parameter determines whether to count documents
  /// in the 'userFcmTokens' collection directly (false) or across various Firestore
  /// paths as a collection group (true). The [source] parameter allows you to
  /// specify whether to count documents from the server or the local cache.
  ///
  /// Parameters:
  ///
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [source] Source of the count, either from the server or local cache.
  /// - [asCollectionGroup] Count the 'userFcmTokens' as a collection group if true.
  ///
  /// Returns the count of documents as an integer.
  Future<int?> count({
    Query<UserFcmToken>? Function(Query<UserFcmToken> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<UserFcmToken> query = asCollectionGroup
        ? readUserFcmTokensCollectionGroupReference
        : readUserFcmTokensCollectionReference;
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
  /// The [asCollectionGroup] parameter determines whether to query the 'userFcmTokens'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to sum over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'userFcmTokens' as a collection group if true.
  ///
  /// Returns the sum of the values of the documents that match the query.
  Future<double?> getSum({
    required String field,
    Query<UserFcmToken>? Function(Query<UserFcmToken> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<UserFcmToken> query = asCollectionGroup
        ? readUserFcmTokensCollectionGroupReference
        : readUserFcmTokensCollectionReference;
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
  /// The [asCollectionGroup] parameter determines whether to query the 'userFcmTokens'
  /// collection directly (false) or as a collection group across different
  /// Firestore paths (true).
  ///
  /// Parameters:
  ///
  /// - [field] The field to average over.
  /// - [queryBuilder] Optional function to build and customize the Firestore query.
  /// - [asCollectionGroup] Query the 'userFcmTokens' as a collection group if true.
  ///
  /// Returns the average of the values of the documents that match the query.
  Future<double?> getAverage({
    required String field,
    Query<UserFcmToken>? Function(Query<UserFcmToken> query)? queryBuilder,
    AggregateSource source = AggregateSource.server,
    bool asCollectionGroup = false,
  }) async {
    Query<UserFcmToken> query = asCollectionGroup
        ? readUserFcmTokensCollectionGroupReference
        : readUserFcmTokensCollectionReference;
    if (queryBuilder != null) {
      query = queryBuilder(query)!;
    }
    final aggregateQuery = await query.aggregate(average(field));
    final aggregateQs = await aggregateQuery.get(source: source);
    return aggregateQs.getAverage(field);
  }

  /// Fetches a single [UserFcmToken] document from Cloud Firestore by its ID.
  ///
  /// This method retrieves a specific document using the provided [userFcmTokenId].
  /// You can control the data retrieval with [GetOptions].
  Future<UserFcmToken?> fetchDocument({
    required String userFcmTokenId,
    GetOptions? options,
  }) async {
    final ds = await readUserFcmTokenDocumentReference(
      userFcmTokenId: userFcmTokenId,
    ).get(options);
    return ds.data();
  }

  /// Subscribes to a stream of a single [UserFcmToken] document from Cloud Firestore by its ID.
  ///
  /// This method returns a stream of a single [UserFcmToken] document, which updates in
  /// real-time based on the database changes. You can control the data retrieval with [GetOptions].
  Stream<UserFcmToken?> subscribeDocument({
    required String userFcmTokenId,
    bool includeMetadataChanges = false,
    bool excludePendingWrites = false,
  }) {
    var streamDs = readUserFcmTokenDocumentReference(
      userFcmTokenId: userFcmTokenId,
    ).snapshots(includeMetadataChanges: includeMetadataChanges);
    if (excludePendingWrites) {
      streamDs = streamDs.where((ds) => !ds.metadata.hasPendingWrites);
    }
    return streamDs.map((ds) => ds.data());
  }

  /// Adds a userFcmToken document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createUserFcmToken] data.
  Future<DocumentReference<CreateUserFcmTokenData>> add({
    required CreateUserFcmTokenData createUserFcmTokenData,
  }) =>
      createUserFcmTokensCollectionReference.add(createUserFcmTokenData);

  /// Sets a userFcmToken document to Cloud Firestore.
  ///
  /// This method creates a new document in Cloud Firestore using the provided
  /// [createUserFcmToken] data.
  Future<void> set({
    required String userFcmTokenId,
    required CreateUserFcmTokenData createUserFcmTokenData,
    SetOptions? options,
  }) =>
      createUserFcmTokenDocumentReference(
        userFcmTokenId: userFcmTokenId,
      ).set(createUserFcmTokenData, options);

  /// Updates a userFcmToken document in Cloud Firestore.
  ///
  /// This method partially updates the document identified by [userFcmTokenId] with the
  /// provided [updateUserFcmToken] data.
  /// The update is based on the structure defined in `UpdateUserFcmTokenData.toJson()`.
  Future<void> update({
    required String userFcmTokenId,
    required UpdateUserFcmTokenData updateUserFcmTokenData,
  }) =>
      updateUserFcmTokenDocumentReference(
        userFcmTokenId: userFcmTokenId,
      ).update(updateUserFcmTokenData.toJson());

  /// Deletes a userFcmToken document from Cloud Firestore.
  ///
  /// This method deletes an existing document identified by [userFcmTokenId].
  Future<void> delete({
    required String userFcmTokenId,
  }) =>
      deleteUserFcmTokenDocumentReference(
        userFcmTokenId: userFcmTokenId,
      ).delete();

  /// Performs a batch write operation in Firestore using a list of [BatchWriteUserFcmToken] tasks.
  ///
  /// This function allows for executing multiple Firestore write operations (create, update, delete)
  /// as a single batch. This ensures that all operations either complete successfully or fail
  /// without applying any changes, providing atomicity.
  ///
  /// Parameters:
  ///
  /// - [batchWriteTasks] A list of [BatchWriteUserFcmToken] objects, each representing a specific
  /// write operation (create, update, or delete) for UserFcmToken documents.
  ///
  /// The function iterates over each task in [batchWriteTasks] and performs the corresponding
  /// Firestore operation. This includes:
  ///
  /// - Creating new documents for tasks of type [BatchCreateUserFcmToken].
  /// - Updating existing documents for tasks of type [BatchUpdateUserFcmToken].
  /// - Deleting documents for tasks of type [BatchDeleteUserFcmToken].
  ///
  /// Returns a `Future<void>` that completes when the batch operation is committed successfully.
  ///
  /// Throws:
  ///
  /// - Firestore exceptions if the batch commit fails or if there are issues with the individual
  /// operations within the batch.
  Future<void> batchWrite(List<BatchWriteUserFcmToken> batchWriteTasks) {
    final batch = FirebaseFirestore.instance.batch();
    for (final task in batchWriteTasks) {
      switch (task) {
        case BatchCreateUserFcmToken(
            userFcmTokenId: final userFcmTokenId,
            createUserFcmTokenData: final createUserFcmTokenData,
          ):
          batch.set(
            createUserFcmTokenDocumentReference(
              userFcmTokenId: userFcmTokenId,
            ),
            createUserFcmTokenData,
          );
        case BatchUpdateUserFcmToken(
            userFcmTokenId: final userFcmTokenId,
            updateUserFcmTokenData: final updateUserFcmTokenData,
          ):
          batch.update(
            updateUserFcmTokenDocumentReference(
              userFcmTokenId: userFcmTokenId,
            ),
            updateUserFcmTokenData.toJson(),
          );
        case BatchDeleteUserFcmToken(userFcmTokenId: final userFcmTokenId):
          batch.delete(deleteUserFcmTokenDocumentReference(
            userFcmTokenId: userFcmTokenId,
          ));
      }
    }
    return batch.commit();
  }
}
