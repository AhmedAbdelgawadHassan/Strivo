

import 'package:firebase_auth/firebase_auth.dart';
import 'package:strivo/core/errors/exceptions.dart';

class FirebaseAuthServices {
  // =========================
  // Sign Up
  // =========================

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user == null) {
        throw CustomException(
          message: 'User data is not available.',
        );
      }

      await user.updateDisplayName(fullName);

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'weak-password':
          throw CustomException(
            message: 'The password is too weak.',
          );

        case 'email-already-in-use':
          throw CustomException(
            message: 'The email is already in use.',
          );

        case 'invalid-email':
          throw CustomException(
            message: 'The email address is invalid.',
          );

        case 'operation-not-allowed':
          throw CustomException(
            message: 'Email/password authentication is not enabled.',
          );

        default:
          throw CustomException(
            message: e.message ?? 'Authentication failed.',
          );
      }
    }
  }

  // =========================
  // Sign In
  // =========================

  Future<User> signInUserWithEmailAndPassword({required String email,required String password,}) async {
    try {
      final credential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password,);

      final user = credential.user;

      if (user == null) {
        throw CustomException(
          message: 'User data is not available.',
        );
      }

      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        
        case 'invalid-email':
          throw CustomException(
            message: 'The email address is invalid.',
          );


        case 'user-not-found':
          throw CustomException(
            message: 'No user found with this email.',
          );

        case 'wrong-password':
          throw CustomException(
            message: 'The password is incorrect.',
          );

        case 'invalid-credential':
          throw CustomException(
            message: 'The email or password is incorrect.',
          );

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
          throw CustomException(
            message: e.message ?? 'Authentication failed.',
          );
      }
    }
  }
}