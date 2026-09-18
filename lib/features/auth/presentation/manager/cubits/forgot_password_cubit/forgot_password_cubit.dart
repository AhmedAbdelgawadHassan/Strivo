import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strivo/features/auth/data/repos/auth_repo.dart';
import 'package:strivo/features/auth/presentation/manager/cubits/forgot_password_cubit/forgot_password_states.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthRepo authRepo;

  ForgotPasswordCubit(this.authRepo)
      : super(ForgotPasswordInitial());

  Future<void> sendResetEmail(String email) async {
    emit(ForgotPasswordLoading());

    final result = await authRepo.sendPasswordResetEmail(
      email: email.trim(),
    );

    result.fold(
      (failure) {
        emit(
          ForgotPasswordFailure(
            failure.message,
          ),
        );
      },
      (_) {
        emit(ForgotPasswordSuccess());
      },
    );
  }
}