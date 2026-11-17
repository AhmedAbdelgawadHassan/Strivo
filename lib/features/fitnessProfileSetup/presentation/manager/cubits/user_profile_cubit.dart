
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/fitness_profile_model.dart';
import 'package:strivo/features/fitnessProfileSetup/data/repos/fitness_profile_repository.dart';

class UserProfileState {
  final FitnessProfileModel? profile;
  final bool isLoading;
  final String? error;

  const UserProfileState({
    this.profile,
    this.isLoading = false,
    this.error,
  });

  // مستخدم عنده profile ومكتمل؟
  bool get hasCompletedProfile => profile != null && profile!.isCompleted;
}


class UserProfileCubit extends Cubit<UserProfileState> {
  final FitnessProfileRepository _repo;

  UserProfileCubit(this._repo) : super(const UserProfileState());

  /// تحميل الـ profile من Firestore (بعد الـ Login أو في الـ Splash)
  Future<void> loadProfile() async {
    emit(const UserProfileState(isLoading: true));
    try {
      final profile = await _repo.getProfile();
      emit(UserProfileState(profile: profile));
    } catch (e) {
      emit(const UserProfileState(error: '  We Can Load Your Data , pls try again'));
    }
  }

  /// بعد ما الـ Setup يخلص: حدّث الـ state من غير قراءة تانية من Firestore
  void setProfile(FitnessProfileModel profile) {
    emit(UserProfileState(profile: profile));
  }

  /// تعديل جزء من البيانات لاحقاً (مثلاً من شاشة Edit Profile)
  Future<void> updateProfile(FitnessProfileModel updated) async {
    final old = state.profile;
    emit(UserProfileState(profile: updated)); // تحديث فوري للـ UI
    try {
      await _repo.saveProfile(updated);
    } catch (e) {
      // لو الحفظ فشل، ارجع للبيانات القديمة
      emit(UserProfileState(
        profile: old,
        error: "oops Changes didn't Save",
      ));
    }
  }

  /// عند الـ Logout
  void clear() => emit(const UserProfileState());
}