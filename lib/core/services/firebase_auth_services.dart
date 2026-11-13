import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:strivo/core/errors/exceptions.dart';

class FirebaseAuthServices {
    final GoogleSignIn _googleSignIn = GoogleSignIn.instance; 
     final FirebaseAuth _auth = FirebaseAuth.instance;


  // =========================
  // Sign Up
  // =========================

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;

      if (user == null) {
        throw CustomException(message: 'User data is not available.');
      }

      await user.updateDisplayName(fullName);

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw CustomException(message: 'The password is too weak.');

        case 'email-already-in-use':
          throw CustomException(message: 'The email is already in use.');

        case 'invalid-email':
          throw CustomException(message: 'The email address is invalid.');

        case 'operation-not-allowed':
          throw CustomException(
            message: 'Email/password authentication is not enabled.',
          );

        default:
          throw CustomException(message: e.message ?? 'Authentication failed.');
      }
    }
  }

  // =========================
  // Sign In
  // =========================

  Future<User> signInUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw CustomException(message: 'User data is not available.');
      }

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          throw CustomException(message: 'The email address is invalid.');

        case 'user-not-found':
          throw CustomException(message: 'No user found with this email.');

        case 'wrong-password':
          throw CustomException(message: 'The password is incorrect.');

        case 'invalid-credential':
          throw CustomException(message: 'The email or password is incorrect.');

        case 'user-disabled':
          throw CustomException(
            message: 'This user account has been disabled.',
          );

        case 'operation-not-allowed':
          throw CustomException(
            message: 'Email/password authentication is not enabled.',
          );

        case 'too-many-requests':
          throw CustomException(
            message: 'Too many attempts. Please try again later.',
          );

        default:
          throw CustomException(message: e.message ?? 'Authentication failed.');
      }
    }
  }




  Future<void> initializeGoogleSignIn() async {
    await _googleSignIn.initialize(
      serverClientId:
          '644513652198-3qr8k1ooci66n81vjsj1o4379f8i2nv5.apps.googleusercontent.com',
    );
  }

  /// Sign In With Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await _googleSignIn.authenticate();

    if (googleUser == null) {
      throw CustomException(
        message: 'Google sign in was cancelled.',
      );
    }

    final GoogleSignInAuthentication googleAuth =
        googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    
  }

  /// Sign In / Sign Up With Facebook
  Future<UserCredential> signInWithFacebook() async {
    try {
      final rawNonce = _generateNonce();
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: const ['email', 'public_profile'],
        loginTracking: defaultTargetPlatform == TargetPlatform.iOS
            ? LoginTracking.limited
            : LoginTracking.enabled,
        nonce: rawNonce,
      );

      if (result.status == LoginStatus.cancelled) {
        throw CustomException(
          message: 'Facebook sign in was cancelled.',
        );
      }

      if (result.status != LoginStatus.success) {
        throw CustomException(
          message: result.message ?? 'Facebook sign in failed.',
        );
      }

      final AccessToken? accessToken = result.accessToken;

      if (accessToken == null) {
        throw CustomException(
          message: 'Facebook access token is null.',
        );
      }

      final OAuthCredential credential = _facebookCredential(
        accessToken: accessToken,
        rawNonce: rawNonce,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );

      final user = userCredential.user;
      if (user != null &&
          (user.displayName == null || user.displayName!.isEmpty) &&
          accessToken is LimitedToken &&
          accessToken.userName.isNotEmpty) {
        await user.updateDisplayName(accessToken.userName);
      }

      return userCredential;
    } on CustomException {
      rethrow;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'account-exists-with-different-credential':
          throw CustomException(
            message:
                'An account already exists with this email. Sign in with the original method first.',
          );
        case 'invalid-credential':
          throw CustomException(
            message: 'Facebook credential is invalid or expired.',
          );
        case 'operation-not-allowed':
          throw CustomException(
            message: 'Facebook authentication is not enabled.',
          );
        case 'user-disabled':
          throw CustomException(
            message: 'This user account has been disabled.',
          );
        default:
          throw CustomException(
            message: e.message ?? 'Facebook authentication failed.',
          );
      }
    } catch (e) {
      throw CustomException(
        message: e.toString(),
      );
    }
  }

  OAuthCredential _facebookCredential({
    required AccessToken accessToken,
    required String rawNonce,
  }) {
    if (accessToken is LimitedToken) {
      return OAuthProvider('facebook.com').credential(
        idToken: accessToken.tokenString,
        rawNonce: accessToken.nonce.isNotEmpty ? accessToken.nonce : rawNonce,
      );
    }

    return FacebookAuthProvider.credential(accessToken.tokenString);
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

   /// Reset Passw
  Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    await _auth.sendPasswordResetEmail(
      email: email,
    );
  }

}
