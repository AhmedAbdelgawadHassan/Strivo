import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';
import 'package:strivo/features/auth/presentation/manager/cubits/signup_cubit/signup_states.dart';

class SignupCubit extends Cubit<SignupState>{
  SignupCubit(super.initialState, {required this.authRepo});
   final AuthRepo authRepo;

   Future<void> SignupwithEmailAndPassword(String email, String password, String fullName) async {
    emit(SignupLoading());
   var result = await authRepo.CreateUserWithEmailAndPassword(email, password, fullName,);
   result.fold(
    (failure) => emit(SignupFailure(message: failure.message)),
   
    (user) => emit(SignupSuccess(user: user)),
    );
     
  } 


 Future<void> signUpWithGoogle() async {
    emit(SignupLoading());
    var result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SignupFailure(message: failure.message)),
      (user) => emit(SignupSuccess(user: user)),
    );
  }

}