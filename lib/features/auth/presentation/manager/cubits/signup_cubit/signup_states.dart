import 'package:strivo/features/auth/data/models/user_model.dart';

abstract class SignupState {}
class SignupInitial extends SignupState {}
class SignupLoading extends SignupState {}
class SignupSuccess extends SignupState {
  final UserModel user;
    
  SignupSuccess({required this.user});
}
class SignupFailure extends SignupState {
  final String message;

  SignupFailure({required this.message});
}