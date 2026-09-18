import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';
import 'package:strivo/features/auth/presentation/manager/cubits/login_cubit/login_states.dart';


/// Login With Email And Password Cubit
class LoginCubit extends Cubit<LoginStates>{
  LoginCubit(super.initialState, {required this.authRepo} );
   final AuthRepo authRepo;

   Future<void> SignInwithEmailAndPassword(String email, String password) async {
    emit(LoginLoadingState());
   var result = await authRepo.signInUserWithEmailAndPassword(email, password,);
   result.fold(
    (failure) => emit(LoginFailureState(message: failure.message)),
   
    (user) => emit(LoginSuccessState(user: user)),
    );
     
  } 


/// Login With Google Cubit
  Future<void> SignInWithGoogle() async {
    emit(LoginLoadingState());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(LoginFailureState(message: failure.message)),
      (user) => emit(LoginSuccessState(user: user)),
    );
  }



//// Sign In With Facebook Cubit
  Future<void> SignInWithFacebook() async {
    emit(LoginLoadingState());
    var result = await authRepo.signInWithFacebook();
    result.fold(
      (failure) => emit(LoginFailureState(message: failure.message)),
      (user) => emit(LoginSuccessState(user: user)),
    );
  }
  
  
  }