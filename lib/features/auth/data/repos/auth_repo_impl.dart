

import 'package:dartz/dartz.dart';
import 'package:strivo/core/errors/exceptions.dart';
import 'package:strivo/core/errors/failure.dart';
import 'package:strivo/core/services/firebase_auth_services.dart';
import 'package:strivo/features/auth/data/models/user_model.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  AuthRepoImpl({
    required this.firebaseAuthServices,
  });

  @override
  Future<Either<Failure, UserModel>> CreateUserWithEmailAndPassword(
    String email,
    String password,
    String fullName,
  ) async {
    try {
      final user =
          await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
        fullName: fullName,
      );

      return right(
        UserModel(
          
          email: user.email ?? '',
          fullName: user.displayName ?? '',
          userId: user.uid,
        ),
      );
    } on CustomException catch (e) {
      return left(
        ServerFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }

    
  }
  @override
   Future<Either<Failure, UserModel>> signInUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final user =
          await firebaseAuthServices.signInUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(
        UserModel(
          email: user.email ?? '',
          fullName: user.displayName ?? '',
          userId: user.uid,
        ),
      );
    } on CustomException catch (e) {
      return left(
        ServerFailure(
          message: e.message,
        ),
      );
    } catch (e) {
      return left(
        ServerFailure(
          message: e.toString(),
        ),
      );
    }

    
  }
  
  
}
