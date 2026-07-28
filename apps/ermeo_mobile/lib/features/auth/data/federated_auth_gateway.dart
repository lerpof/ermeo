import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:ermeo_api/ermeo_api.dart' as api;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FederatedCredentials {
  const FederatedCredentials({
    required this.provider,
    required this.idToken,
    this.accessToken,
    this.nonce,
  });

  final api.FederatedProvider provider;
  final String idToken;
  final String? accessToken;
  final String? nonce;
}

abstract class FederatedAuthGateway {
  Future<FederatedCredentials> signInWithGoogle();

  Future<FederatedCredentials> signInWithApple();
}

class NativeFederatedAuthGateway implements FederatedAuthGateway {
  NativeFederatedAuthGateway({GoogleSignIn? googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;
  bool _googleInitialized = false;

  Future<void> _ensureGoogleInitialized() async {
    if (_googleInitialized) {
      return;
    }
    await _googleSignIn.initialize();
    _googleInitialized = true;
  }

  @override
  Future<FederatedCredentials> signInWithGoogle() async {
    await _ensureGoogleInitialized();
    try {
      final account = await _googleSignIn.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null || idToken.isEmpty) {
        throw StateError('Google Sign-In did not return an ID token');
      }

      String? accessToken;
      try {
        final authz = await account.authorizationClient.authorizeScopes(
          const ['email'],
        );
        accessToken = authz.accessToken;
      } on Object {
        accessToken = null;
      }

      return FederatedCredentials(
        provider: api.FederatedProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
    } on GoogleSignInException catch (error) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw const FederatedAuthCancelledException();
      }
      rethrow;
    }
  }

  @override
  Future<FederatedCredentials> signInWithApple() async {
    final rawNonce = _generateNonce();
    final nonce = sha256.convert(utf8.encode(rawNonce)).toString();
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      final idToken = credential.identityToken;
      if (idToken == null || idToken.isEmpty) {
        throw StateError('Apple Sign-In did not return an identity token');
      }
      return FederatedCredentials(
        provider: api.FederatedProvider.apple,
        idToken: idToken,
        nonce: rawNonce,
      );
    } on SignInWithAppleAuthorizationException catch (error) {
      if (error.code == AuthorizationErrorCode.canceled) {
        throw const FederatedAuthCancelledException();
      }
      rethrow;
    }
  }

  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }
}

class FederatedAuthCancelledException implements Exception {
  const FederatedAuthCancelledException();
}
