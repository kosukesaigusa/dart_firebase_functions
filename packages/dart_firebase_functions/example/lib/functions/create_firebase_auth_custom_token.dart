import 'dart:convert';

import 'package:functions_framework/functions_framework.dart';
import 'package:http/http.dart' as http;
import 'package:shelf/shelf.dart';

import '../config/config.dart';

class CreateFirebaseAuthCustomTokenFunction {
  const CreateFirebaseAuthCustomTokenFunction(this.request, this.logger);

  final Request request;

  final RequestLogger logger;

  /// Links Firebase Auth and LINE Login with custom token authentication.
  ///
  /// Verify the `accessToken` obtained from the request body of [request] with
  /// the [_verifyAccessToken] method, and get the LINE profile with the
  /// [_getLineProfile] method.
  ///
  /// Then, create a custom token from the LINE user ID in Firebase Auth, save
  /// the profile information in Firestore, and return the custom token.
  Future<Response> call() async {
    try {
      final json =
          jsonDecode(await request.readAsString()) as Map<String, dynamic>;
      final accessToken = json['accessToken'] as String?;
      if (accessToken == null) {
        return Response.badRequest(
          body: jsonEncode({'message': 'accessToken is required.'}),
        );
      }

      await _verifyAccessToken(accessToken);

      final profile = await _getLineProfile(accessToken);

      final customToken = await auth.createCustomToken(profile.lineUserId);

      await firestore.collection('users').doc(profile.lineUserId).set({
        'displayName': profile.displayName,
        'imageUrl': profile.imageUrl,
      });

      logger.debug('User document (${profile.lineUserId}) is set.');

      return Response.ok(jsonEncode({'customToken': customToken}));
    } on Exception catch (e) {
      return Response.badRequest(body: jsonEncode({'message': e.toString()}));
    }
  }

  Future<void> _verifyAccessToken(String accessToken) async {
    final response = await http.get(
      Uri.parse(
        'https://api.line.me/oauth2/v2.1/verify?access_token=$accessToken',
      ),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed in verifying access token.');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final channelId = json['client_id'] as String;
    final expiresIn = json['expires_in'] as int;

    if (channelId != environmentVariable.lineChannelId) {
      throw Exception('LINE Login channel ID is not correct.');
    }
    if (expiresIn <= 0) {
      throw Exception('Access toke is expired.');
    }
  }

  Future<({String lineUserId, String displayName, String? imageUrl})>
      _getLineProfile(String accessToken) async {
    final response = await http.get(
      Uri.parse('https://api.line.me/v2/profile'),
      headers: {'Authorization': 'Bearer $accessToken'},
    );
    if (response.statusCode != 200) {
      throw Exception('Failed in getting LINE profile by access token.');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return (
      lineUserId: json['userId'] as String,
      displayName: json['displayName'] as String,
      imageUrl: json['pictureUrl'] as String?,
    );
  }
}
