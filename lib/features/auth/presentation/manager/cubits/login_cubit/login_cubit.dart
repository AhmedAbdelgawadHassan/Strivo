import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';
import 'package:strivo/features/auth/presentation/manager/cubits/login_cubit/login_states.dart';

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


}