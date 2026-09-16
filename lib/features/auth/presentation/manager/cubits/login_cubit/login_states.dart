import 'package:strivo/features/auth/data/models/user_model.dart';

abstract class LoginStates {}
class LoginIntailState extends LoginStates {}
class LoginLoadingState extends LoginStates {}
class LoginSuccessState extends LoginStates {
  final UserModel user;

  LoginSuccessState({required this.user});
}
class LoginFailureState extends LoginStates {
  final String message;
  LoginFailureState({required this.message});
}