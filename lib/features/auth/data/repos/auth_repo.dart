import 'package:dartz/dartz.dart';
import 'package:strivo/core/errors/failure.dart';
import 'package:strivo/features/auth/data/models/user_model.dart';

abstract class AuthRepo {

  /// Sign Up Method
  Future<Either<Failure,UserModel>>CreateUserWithEmailAndPassword(String email, String password,String fullName, );
    /// Sign In Method
    Future<Either<Failure,UserModel>>signInUserWithEmailAndPassword(String email, String password);
   //// Sign In WIth Google
     Future<Either<Failure,UserModel>>signInWithGoogle();

}