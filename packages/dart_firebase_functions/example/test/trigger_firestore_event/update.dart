// ignore_for_file: lines_longer_than_80_chars

import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:test/test.dart';

void main() {
  test('trigger google.cloud.firestore.document.v1.updated event', () async {
    await http.post(
      Uri.parse('http://localhost:8080/'),
      body: _protobufBytesWhenUpdatingDocument,
      headers: {
        'ce-dataschema':
            'https://github.com/googleapis/google-cloudevents/blob/main/proto/google/events/cloud/firestore/v1/data.proto',
        'accept-encoding': 'gzip, deflate, br',
        'authorization': 'Bearer <BEARER_TOKEN_HERE>',
        'ce-subject': 'documents/todos/6iGrCr5nJar6NNB8gPog',
        'ce-namespace': '(default)',
        'x-forwarded-proto': 'https',
        'forwarded': 'for="107.178.225.67";proto=https',
        'traceparent':
            '00-d2c86ac980326478aab4c3d62aab1d4d-7012b244d703e9da-01',
        'content-length': '1167',
        'ce-source':
            '//firestore.googleapis.com/projects/full-dart-monorepo/databases/(default)',
        'ce-id': 'bab5a25f-26f5-4b46-95d0-22ca086f0e74',
        'ce-type': 'google.cloud.firestore.document.v1.updated',
        'x-cloud-trace-context':
            'd2c86ac980326478aab4c3d62aab1d4d/8075713090563598810;o=1',
        'user-agent':
            'APIs-Google; (+https://developers.google.com/webmasters/APIs-Google.html)',
        'ce-time': '2024-02-04T04:49:47.731375Z',
        'ce-database': '(default)',
        'content-type': 'application/protobuf',
        'from': 'noreply@google.com',
        'accept': 'application/json',
        'ce-location': 'asia-northeast1',
        'ce-specversion': '1.0',
        'host': 'onupdatetodo-cwi73pbowq-an.a.run.app',
        'x-forwarded-for': '107.178.225.67',
        'ce-document': 'todos/6iGrCr5nJar6NNB8gPog',
        'ce-project': 'full-dart-monorepo',
      },
    );
  });
}

// ignore: unreachable_from_main
final updateDocumentEventData = {
  'value': {
    'name':
        'projects/full-dart-monorepo/databases/(default)/documents/todos/6iGrCr5nJar6NNB8gPog',
    'fields': {
      'nullField': {'nullValue': 'NULL_VALUE'},
      'title': {'stringValue': 'null from server!'},
      'geopointField': {
        'geoPointValue': {'latitude': 2.46, 'longitude': 9.12},
      },
      'arrayField': {
        'arrayValue': {
          'values': [
            {'stringValue': 'hello world'},
            {'doubleValue': 6.28},
          ],
        },
      },
      'doubleField': {'doubleValue': 6.48},
      'referenceField': {
        'referenceValue':
            'projects/full-dart-monorepo/databases/(default)/documents/todos/7A81Jk1VpYgT2k6ccdv9',
      },
      'integerField': {'integerValue': '2'},
      'mapField': {
        'mapValue': {
          'fields': {
            'newField': {'integerValue': '1'},
            'message': {'stringValue': 'hello world'},
          },
        },
      },
      'newField': {'integerValue': '1'},
      'timestampField': {'timestampValue': '2024-02-04T04:49:47.643Z'},
      'stringField': {'stringValue': 'b'},
    },
    'createTime': '2024-02-04T04:37:43.939407Z',
    'updateTime': '2024-02-04T04:49:47.731375Z',
  },
  'oldValue': {
    'name':
        'projects/full-dart-monorepo/databases/(default)/documents/todos/6iGrCr5nJar6NNB8gPog',
    'fields': {
      'geopointField': {
        'geoPointValue': {'latitude': 1.23, 'longitude': 4.56},
      },
      'doubleField': {'doubleValue': 3.14},
      'arrayField': {
        'arrayValue': {
          'values': [
            {'stringValue': 'hello'},
            {'doubleValue': 3.14},
          ],
        },
      },
      'referenceField': {
        'referenceValue':
            'projects/full-dart-monorepo/databases/(default)/documents/todos/6iGrCr5nJar6NNB8gPog',
      },
      'integerField': {'integerValue': '1'},
      'mapField': {
        'mapValue': {
          'fields': {
            'message': {'stringValue': 'hello'},
          },
        },
      },
      'nullField': {'nullValue': 'NULL_VALUE'},
      'timestampField': {'timestampValue': '2024-02-03T03:34:56.720Z'},
      'stringField': {'stringValue': 'a'},
      'title': {'stringValue': 'null from server!'},
    },
    'createTime': '2024-02-04T04:37:43.939407Z',
    'updateTime': '2024-02-04T04:37:45.969407Z',
  },
  'updateMask': {
    'fieldPaths': [
      'geopointField',
      'doubleField',
      'arrayField',
      'referenceField',
      'integerField',
      'mapField.message',
      'mapField.newField',
      'timestampField',
      'stringField',
      'newField',
    ],
  },
};

/// A record in protobuf when updating todo document.
final _protobufBytesWhenUpdatingDocument =
    Uint8List.fromList(_bytesWhenUpdatingDocument);

/// A record in json when updating todo document.
final _bytesWhenUpdatingDocument = [
  10,
  144,
  4,
  10,
  84,
  112,
  114,
  111,
  106,
  101,
  99,
  116,
  115,
  47,
  102,
  117,
  108,
  108,
  45,
  100,
  97,
  114,
  116,
  45,
  109,
  111,
  110,
  111,
  114,
  101,
  112,
  111,
  47,
  100,
  97,
  116,
  97,
  98,
  97,
  115,
  101,
  115,
  47,
  40,
  100,
  101,
  102,
  97,
  117,
  108,
  116,
  41,
  47,
  100,
  111,
  99,
  117,
  109,
  101,
  110,
  116,
  115,
  47,
  116,
  111,
  100,
  111,
  115,
  47,
  54,
  105,
  71,
  114,
  67,
  114,
  53,
  110,
  74,
  97,
  114,
  54,
  78,
  78,
  66,
  56,
  103,
  80,
  111,
  103,
  18,
  15,
  10,
  9,
  110,
  117,
  108,
  108,
  70,
  105,
  101,
  108,
  100,
  18,
  2,
  88,
  0,
  18,
  29,
  10,
  5,
  116,
  105,
  116,
  108,
  101,
  18,
  20,
  138,
  1,
  17,
  110,
  117,
  108,
  108,
  32,
  102,
  114,
  111,
  109,
  32,
  115,
  101,
  114,
  118,
  101,
  114,
  33,
  18,
  37,
  10,
  13,
  103,
  101,
  111,
  112,
  111,
  105,
  110,
  116,
  70,
  105,
  101,
  108,
  100,
  18,
  20,
  66,
  18,
  9,
  174,
  71,
  225,
  122,
  20,
  174,
  3,
  64,
  17,
  61,
  10,
  215,
  163,
  112,
  61,
  34,
  64,
  18,
  43,
  10,
  10,
  97,
  114,
  114,
  97,
  121,
  70,
  105,
  101,
  108,
  100,
  18,
  29,
  74,
  27,
  10,
  14,
  138,
  1,
  11,
  104,
  101,
  108,
  108,
  111,
  32,
  119,
  111,
  114,
  108,
  100,
  10,
  9,
  25,
  31,
  133,
  235,
  81,
  184,
  30,
  25,
  64,
  18,
  24,
  10,
  11,
  100,
  111,
  117,
  98,
  108,
  101,
  70,
  105,
  101,
  108,
  100,
  18,
  9,
  25,
  236,
  81,
  184,
  30,
  133,
  235,
  25,
  64,
  18,
  104,
  10,
  14,
  114,
  101,
  102,
  101,
  114,
  101,
  110,
  99,
  101,
  70,
  105,
  101,
  108,
  100,
  18,
  86,
  42,
  84,
  112,
  114,
  111,
  106,
  101,
  99,
  116,
  115,
  47,
  102,
  117,
  108,
  108,
  45,
  100,
  97,
  114,
  116,
  45,
  109,
  111,
  110,
  111,
  114,
  101,
  112,
  111,
  47,
  100,
  97,
  116,
  97,
  98,
  97,
  115,
  101,
  115,
  47,
  40,
  100,
  101,
  102,
  97,
  117,
  108,
  116,
  41,
  47,
  100,
  111,
  99,
  117,
  109,
  101,
  110,
  116,
  115,
  47,
  116,
  111,
  100,
  111,
  115,
  47,
  55,
  65,
  56,
  49,
  74,
  107,
  49,
  86,
  112,
  89,
  103,
  84,
  50,
  107,
  54,
  99,
  99,
  100,
  118,
  57,
  18,
  18,
  10,
  12,
  105,
  110,
  116,
  101,
  103,
  101,
  114,
  70,
  105,
  101,
  108,
  100,
  18,
  2,
  16,
  2,
  18,
  57,
  10,
  8,
  109,
  97,
  112,
  70,
  105,
  101,
  108,
  100,
  18,
  45,
  50,
  43,
  10,
  14,
  10,
  8,
  110,
  101,
  119,
  70,
  105,
  101,
  108,
  100,
  18,
  2,
  16,
  1,
  10,
  25,
  10,
  7,
  109,
  101,
  115,
  115,
  97,
  103,
  101,
  18,
  14,
  138,
  1,
  11,
  104,
  101,
  108,
  108,
  111,
  32,
  119,
  111,
  114,
  108,
  100,
  18,
  14,
  10,
  8,
  110,
  101,
  119,
  70,
  105,
  101,
  108,
  100,
  18,
  2,
  16,
  1,
  18,
  32,
  10,
  14,
  116,
  105,
  109,
  101,
  115,
  116,
  97,
  109,
  112,
  70,
  105,
  101,
  108,
  100,
  18,
  14,
  82,
  12,
  8,
  235,
  174,
  252,
  173,
  6,
  16,
  192,
  205,
  205,
  178,
  2,
  18,
  19,
  10,
  11,
  115,
  116,
  114,
  105,
  110,
  103,
  70,
  105,
  101,
  108,
  100,
  18,
  4,
  138,
  1,
  1,
  98,
  26,
  12,
  8,
  151,
  169,
  252,
  173,
  6,
  16,
  152,
  237,
  248,
  191,
  3,
  34,
  12,
  8,
  235,
  174,
  252,
  173,
  6,
  16,
  152,
  203,
  223,
  220,
  2,
  18,
  228,
  3,
  10,
  84,
  112,
  114,
  111,
  106,
  101,
  99,
  116,
  115,
  47,
  102,
  117,
  108,
  108,
  45,
  100,
  97,
  114,
  116,
  45,
  109,
  111,
  110,
  111,
  114,
  101,
  112,
  111,
  47,
  100,
  97,
  116,
  97,
  98,
  97,
  115,
  101,
  115,
  47,
  40,
  100,
  101,
  102,
  97,
  117,
  108,
  116,
  41,
  47,
  100,
  111,
  99,
  117,
  109,
  101,
  110,
  116,
  115,
  47,
  116,
  111,
  100,
  111,
  115,
  47,
  54,
  105,
  71,
  114,
  67,
  114,
  53,
  110,
  74,
  97,
  114,
  54,
  78,
  78,
  66,
  56,
  103,
  80,
  111,
  103,
  18,
  37,
  10,
  13,
  103,
  101,
  111,
  112,
  111,
  105,
  110,
  116,
  70,
  105,
  101,
  108,
  100,
  18,
  20,
  66,
  18,
  9,
  174,
  71,
  225,
  122,
  20,
  174,
  243,
  63,
  17,
  61,
  10,
  215,
  163,
  112,
  61,
  18,
  64,
  18,
  24,
  10,
  11,
  100,
  111,
  117,
  98,
  108,
  101,
  70,
  105,
  101,
  108,
  100,
  18,
  9,
  25,
  31,
  133,
  235,
  81,
  184,
  30,
  9,
  64,
  18,
  37,
  10,
  10,
  97,
  114,
  114,
  97,
  121,
  70,
  105,
  101,
  108,
  100,
  18,
  23,
  74,
  21,
  10,
  8,
  138,
  1,
  5,
  104,
  101,
  108,
  108,
  111,
  10,
  9,
  25,
  31,
  133,
  235,
  81,
  184,
  30,
  9,
  64,
  18,
  104,
  10,
  14,
  114,
  101,
  102,
  101,
  114,
  101,
  110,
  99,
  101,
  70,
  105,
  101,
  108,
  100,
  18,
  86,
  42,
  84,
  112,
  114,
  111,
  106,
  101,
  99,
  116,
  115,
  47,
  102,
  117,
  108,
  108,
  45,
  100,
  97,
  114,
  116,
  45,
  109,
  111,
  110,
  111,
  114,
  101,
  112,
  111,
  47,
  100,
  97,
  116,
  97,
  98,
  97,
  115,
  101,
  115,
  47,
  40,
  100,
  101,
  102,
  97,
  117,
  108,
  116,
  41,
  47,
  100,
  111,
  99,
  117,
  109,
  101,
  110,
  116,
  115,
  47,
  116,
  111,
  100,
  111,
  115,
  47,
  54,
  105,
  71,
  114,
  67,
  114,
  53,
  110,
  74,
  97,
  114,
  54,
  78,
  78,
  66,
  56,
  103,
  80,
  111,
  103,
  18,
  18,
  10,
  12,
  105,
  110,
  116,
  101,
  103,
  101,
  114,
  70,
  105,
  101,
  108,
  100,
  18,
  2,
  16,
  1,
  18,
  35,
  10,
  8,
  109,
  97,
  112,
  70,
  105,
  101,
  108,
  100,
  18,
  23,
  50,
  21,
  10,
  19,
  10,
  7,
  109,
  101,
  115,
  115,
  97,
  103,
  101,
  18,
  8,
  138,
  1,
  5,
  104,
  101,
  108,
  108,
  111,
  18,
  15,
  10,
  9,
  110,
  117,
  108,
  108,
  70,
  105,
  101,
  108,
  100,
  18,
  2,
  88,
  0,
  18,
  32,
  10,
  14,
  116,
  105,
  109,
  101,
  115,
  116,
  97,
  109,
  112,
  70,
  105,
  101,
  108,
  100,
  18,
  14,
  82,
  12,
  8,
  224,
  232,
  246,
  173,
  6,
  16,
  128,
  168,
  169,
  215,
  2,
  18,
  19,
  10,
  11,
  115,
  116,
  114,
  105,
  110,
  103,
  70,
  105,
  101,
  108,
  100,
  18,
  4,
  138,
  1,
  1,
  97,
  18,
  29,
  10,
  5,
  116,
  105,
  116,
  108,
  101,
  18,
  20,
  138,
  1,
  17,
  110,
  117,
  108,
  108,
  32,
  102,
  114,
  111,
  109,
  32,
  115,
  101,
  114,
  118,
  101,
  114,
  33,
  26,
  12,
  8,
  151,
  169,
  252,
  173,
  6,
  16,
  152,
  237,
  248,
  191,
  3,
  34,
  12,
  8,
  153,
  169,
  252,
  173,
  6,
  16,
  152,
  244,
  159,
  206,
  3,
  26,
  146,
  1,
  10,
  13,
  103,
  101,
  111,
  112,
  111,
  105,
  110,
  116,
  70,
  105,
  101,
  108,
  100,
  10,
  11,
  100,
  111,
  117,
  98,
  108,
  101,
  70,
  105,
  101,
  108,
  100,
  10,
  10,
  97,
  114,
  114,
  97,
  121,
  70,
  105,
  101,
  108,
  100,
  10,
  14,
  114,
  101,
  102,
  101,
  114,
  101,
  110,
  99,
  101,
  70,
  105,
  101,
  108,
  100,
  10,
  12,
  105,
  110,
  116,
  101,
  103,
  101,
  114,
  70,
  105,
  101,
  108,
  100,
  10,
  16,
  109,
  97,
  112,
  70,
  105,
  101,
  108,
  100,
  46,
  109,
  101,
  115,
  115,
  97,
  103,
  101,
  10,
  17,
  109,
  97,
  112,
  70,
  105,
  101,
  108,
  100,
  46,
  110,
  101,
  119,
  70,
  105,
  101,
  108,
  100,
  10,
  14,
  116,
  105,
  109,
  101,
  115,
  116,
  97,
  109,
  112,
  70,
  105,
  101,
  108,
  100,
  10,
  11,
  115,
  116,
  114,
  105,
  110,
  103,
  70,
  105,
  101,
  108,
  100,
  10,
  8,
  110,
  101,
  119,
  70,
  105,
  101,
  108,
  100,
];
