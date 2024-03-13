import 'package:dart_firebase_admin/auth.dart' as admin_auth;
import 'package:dart_firebase_admin/dart_firebase_admin.dart' as admin;
import 'package:dart_firebase_admin/firestore.dart' as admin_firestore;
import 'package:dart_firebase_admin/messaging.dart' as admin_messaging;
import 'package:functions_framework/functions_framework.dart';

import '../internal/google/events/cloud/firestore/v1/data.pb.dart' as proto;

class FirebaseFunctions {
  factory FirebaseFunctions() => _instance;

  FirebaseFunctions._internal();

  static final FirebaseFunctions _instance = FirebaseFunctions._internal();

  admin.FirebaseAdminApp? _adminApp;

  // ignore: use_setters_to_change_properties
  static void initialize(admin.FirebaseAdminApp app) =>
      _instance._adminApp = app;

  static admin.FirebaseAdminApp get adminApp {
    if (_instance._adminApp == null) {
      throw Exception('FirebaseAdminApp is not initialized.');
    }
    return _instance._adminApp!;
  }

  static admin_firestore.Firestore get firestore {
    if (_instance._adminApp == null) {
      throw Exception('FirebaseAdminApp is not initialized for Firestore.');
    }
    return admin_firestore.Firestore(_instance._adminApp!);
  }

  static admin_auth.Auth get auth {
    if (_instance._adminApp == null) {
      throw Exception('FirebaseAdminApp is not initialized for Auth.');
    }
    return admin_auth.Auth(_instance._adminApp!);
  }

  static admin_messaging.Messaging get messaging {
    if (_instance._adminApp == null) {
      throw Exception('FirebaseAdminApp is not initialized for Messaging.');
    }
    return admin_messaging.Messaging(_instance._adminApp!);
  }

  static void useEmulator() => _instance._adminApp?.useEmulator();

  static void closeAdminApp() => _instance._adminApp?.close();
}

/// QueryDocumentSnapshot
class QueryDocumentSnapshot {
  QueryDocumentSnapshot._({
    required this.ref,
    required this.createTime,
    required this.updateTime,
    required proto.Document document,
  }) : _document = document;

  final admin_firestore.DocumentReference<Map<String, Object?>> ref;

  final admin_firestore.Timestamp? createTime;

  final admin_firestore.Timestamp? updateTime;

  final proto.Document _document;

  Map<String, Object?>? data() {
    return {
      for (final field in _document.fields.entries)
        field.key: _decodeValue(field.value),
    };
  }
}

enum FirestoreDocumentEventType { v1Created, v1Updated, v1Deleted, v1Written }

sealed class FirestoreTriggeredEventData {
  const FirestoreTriggeredEventData({required this.eventType});

  final FirestoreDocumentEventType eventType;

  QueryDocumentSnapshot get snapshot => switch (eventType) {
        FirestoreDocumentEventType.v1Created =>
          (this as DocumentCreatedData).snapshot,
        FirestoreDocumentEventType.v1Updated => throw UnimplementedError(),
        FirestoreDocumentEventType.v1Deleted =>
          (this as DocumentDeletedData).snapshot,
        FirestoreDocumentEventType.v1Written => throw UnimplementedError(),
      };

  Change get change => switch (eventType) {
        FirestoreDocumentEventType.v1Created => throw UnimplementedError(),
        FirestoreDocumentEventType.v1Updated => Change(
            before: (this as DocumentUpdatedData).snapshots.before,
            after: (this as DocumentUpdatedData).snapshots.after,
          ),
        FirestoreDocumentEventType.v1Deleted => throw UnimplementedError(),
        FirestoreDocumentEventType.v1Written => throw UnimplementedError(),
      };

  MaybeChange get maybeChange => switch (eventType) {
        FirestoreDocumentEventType.v1Created => throw UnimplementedError(),
        FirestoreDocumentEventType.v1Updated => throw UnimplementedError(),
        FirestoreDocumentEventType.v1Deleted => throw UnimplementedError(),
        FirestoreDocumentEventType.v1Written => MaybeChange(
            before: (this as DocumentWrittenData).values.before,
            after: (this as DocumentWrittenData).values.after,
          ),
      };
}

class DocumentCreatedData extends FirestoreTriggeredEventData {
  DocumentCreatedData({required super.eventType, required this.snapshot});

  @override
  final QueryDocumentSnapshot snapshot;
}

class DocumentUpdatedData extends FirestoreTriggeredEventData {
  DocumentUpdatedData({required super.eventType, required this.snapshots});

  final ({QueryDocumentSnapshot before, QueryDocumentSnapshot after}) snapshots;
}

class DocumentDeletedData extends FirestoreTriggeredEventData {
  DocumentDeletedData({required super.eventType, required this.snapshot});

  @override
  final QueryDocumentSnapshot snapshot;
}

class DocumentWrittenData extends FirestoreTriggeredEventData {
  DocumentWrittenData({required super.eventType, required this.values});

  final ({QueryDocumentSnapshot? before, QueryDocumentSnapshot? after}) values;
}

class Change {
  Change({required this.before, required this.after});

  final QueryDocumentSnapshot before;

  final QueryDocumentSnapshot after;

  ({QueryDocumentSnapshot before, QueryDocumentSnapshot after}) toRecord() =>
      (before: before, after: after);
}

// TODO: Update class name.
class MaybeChange {
  MaybeChange({required this.before, required this.after});

  final QueryDocumentSnapshot? before;

  final QueryDocumentSnapshot? after;

  ({QueryDocumentSnapshot? before, QueryDocumentSnapshot? after}) toRecord() =>
      (before: before, after: after);
}

class QueryDocumentSnapshotBuilder {
  QueryDocumentSnapshotBuilder(this.event);

  final CloudEvent event;

  FirestoreTriggeredEventData fromCloudEvent() {
    final type = event.type;
    return switch (type) {
      'google.cloud.firestore.document.v1.created' => _onCreated(event),
      'google.cloud.firestore.document.v1.updated' => _onUpdated(event),
      'google.cloud.firestore.document.v1.deleted' => _onDeleted(event),
      'google.cloud.firestore.document.v1.written' => _onWritten(event),
      _ => throw ArgumentError.value(
          type,
          'event',
          "Couldn't parse CloudEvent type: $type",
        ),
    };
  }

  DocumentCreatedData _onCreated(CloudEvent event) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    final path = subjectPathFromCloudEvent(event);
    final value = documentEventData.value;
    return DocumentCreatedData(
      eventType: FirestoreDocumentEventType.v1Created,
      snapshot: QueryDocumentSnapshot._(
        ref: FirebaseFunctions.firestore.doc(path),
        createTime:
            admin_firestore.Timestamp.fromDate(value.createTime.toDateTime()),
        updateTime:
            admin_firestore.Timestamp.fromDate(value.updateTime.toDateTime()),
        document: value,
      ),
    );
  }

  DocumentUpdatedData _onUpdated(CloudEvent event) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    final path = subjectPathFromCloudEvent(event);
    final value = documentEventData.value;
    final oldValue = documentEventData.oldValue;
    return DocumentUpdatedData(
      eventType: FirestoreDocumentEventType.v1Updated,
      snapshots: (
        before: QueryDocumentSnapshot._(
          ref: FirebaseFunctions.firestore.doc(path),
          createTime: admin_firestore.Timestamp.fromDate(
            oldValue.createTime.toDateTime(),
          ),
          updateTime: admin_firestore.Timestamp.fromDate(
            oldValue.updateTime.toDateTime(),
          ),
          document: oldValue,
        ),
        after: QueryDocumentSnapshot._(
          ref: FirebaseFunctions.firestore.doc(path),
          createTime: admin_firestore.Timestamp.fromDate(
            value.createTime.toDateTime(),
          ),
          updateTime: admin_firestore.Timestamp.fromDate(
            value.updateTime.toDateTime(),
          ),
          document: value,
        ),
      ),
    );
  }

  DocumentDeletedData _onDeleted(CloudEvent event) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    final path = subjectPathFromCloudEvent(event);
    final oldValue = documentEventData.oldValue;
    return DocumentDeletedData(
      eventType: FirestoreDocumentEventType.v1Deleted,
      snapshot: QueryDocumentSnapshot._(
        ref: FirebaseFunctions.firestore.doc(path),
        createTime: admin_firestore.Timestamp.fromDate(
          oldValue.createTime.toDateTime(),
        ),
        updateTime: admin_firestore.Timestamp.fromDate(
          oldValue.updateTime.toDateTime(),
        ),
        document: oldValue,
      ),
    );
  }

  DocumentWrittenData _onWritten(CloudEvent event) {
    final documentEventData =
        proto.DocumentEventData.fromBuffer(event.data! as List<int>);
    final path = subjectPathFromCloudEvent(event);
    final value = documentEventData.value;
    final hasValue = value.fields.isNotEmpty;
    final oldValue = documentEventData.oldValue;
    final hasOldValue = oldValue.fields.isNotEmpty;
    return DocumentWrittenData(
      eventType: FirestoreDocumentEventType.v1Written,
      values: (
        before: hasOldValue
            ? QueryDocumentSnapshot._(
                ref: FirebaseFunctions.firestore.doc(path),
                createTime: admin_firestore.Timestamp.fromDate(
                  oldValue.createTime.toDateTime(),
                ),
                updateTime: admin_firestore.Timestamp.fromDate(
                  oldValue.updateTime.toDateTime(),
                ),
                document: oldValue,
              )
            : null,
        after: hasValue
            ? QueryDocumentSnapshot._(
                ref: FirebaseFunctions.firestore.doc(path),
                createTime: admin_firestore.Timestamp.fromDate(
                  value.createTime.toDateTime(),
                ),
                updateTime: admin_firestore.Timestamp.fromDate(
                  value.updateTime.toDateTime(),
                ),
                document: value,
              )
            : null,
      ),
    );
  }
}

// documents/users/ghXNtePIFmdDOBH3iEMH
String subjectFromCloudEvent(CloudEvent event) =>
    event.toJson()['subject'] as String;

// users/ghXNtePIFmdDOBH3iEMH
String subjectPathFromCloudEvent(CloudEvent event) =>
    subjectFromCloudEvent(event).replaceFirst('documents/', '');

Object? _decodeValue(proto.Value value) {
  if (value.hasStringValue()) {
    return value.stringValue;
  } else if (value.hasBooleanValue()) {
    return value.booleanValue;
  } else if (value.hasIntegerValue()) {
    return value.integerValue.toInt();
  } else if (value.hasDoubleValue()) {
    return value.doubleValue;
  } else if (value.hasTimestampValue()) {
    return value.timestampValue;
  } else if (value.hasReferenceValue()) {
    return FirebaseFunctions.firestore.doc(
      RegExp(r'^projects\/([^/]*)\/databases\/([^/]*)(?:\/documents\/)?([\s\S]*)$')
          .firstMatch(value.referenceValue)!
          .group(3)!,
    );
  } else if (value.hasArrayValue()) {
    return [
      for (final value in value.arrayValue.values) _decodeValue(value),
    ];
  } else if (value.hasMapValue()) {
    final fields = value.mapValue.fields;
    return <String, Object?>{
      for (final entry in fields.entries) entry.key: _decodeValue(entry.value),
    };
  } else if (value.hasGeoPointValue()) {
    return admin_firestore.GeoPoint(
      latitude: value.geoPointValue.latitude,
      longitude: value.geoPointValue.longitude,
    );
  } else if (value.hasNullValue()) {
    return null;
  }

  throw ArgumentError.value(
    value,
    'value',
    'Cannot decode type from Firestore Value: ${value.runtimeType}',
  );
}
