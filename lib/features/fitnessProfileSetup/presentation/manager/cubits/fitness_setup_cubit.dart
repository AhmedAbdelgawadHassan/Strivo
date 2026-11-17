import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strivo/features/fitnessProfileSetup/data/models/fitness_profile_model.dart';
import 'package:strivo/features/fitnessProfileSetup/data/repos/fitness_profile_repository.dart';

class FitnessSetupState {   // states just in different shape
  final FitnessProfileModel profile;
  final bool isSaving;
  final bool saved;
  final String? error;

  const FitnessSetupState({
    this.profile = const FitnessProfileModel(),
    this.isSaving = false,
    this.saved = false,
    this.error,
  });

  FitnessSetupState copyWith({
    FitnessProfileModel? profile,
    bool? isSaving,
    bool? saved,
    String? error,
  }) {
    return FitnessSetupState(
      profile: profile ?? this.profile,
      isSaving: isSaving ?? this.isSaving,
      saved: saved ?? this.saved,
      error: error,
    );
  }

  // ===== شروط تفعيل زرار Continue لكل صفحة =====
  bool get canContinueGender => profile.gender != null;

  bool get canContinueMeasurements =>
      profile.age != null &&
      profile.age! > 10 && profile.age! < 100 &&
      profile.height != null &&
      profile.height! > 100 && profile.height! < 250 &&
      profile.weight != null &&
      profile.weight! > 30 && profile.weight! < 300;

  bool get canContinueGoal => profile.goal != null;

  bool get canCompleteSetup => profile.activityLevel != null;

}


class FitnessSetupCubit extends Cubit<FitnessSetupState> {
  final FitnessProfileRepository _repo;

  FitnessSetupCubit(this._repo) : super(const FitnessSetupState());

  void selectGender(String gender) =>
      emit(state.copyWith(profile: state.profile.copyWith(gender: gender)));
      void updateMeasurements({int? age, double? height, double? weight}) {
  emit(state.copyWith(
    profile: state.profile.copyWithMeasurements(
      age: age,
      height: height,
      weight: weight,
    ),
  ));
}
  void selectGoal(String goal) =>
      emit(state.copyWith(profile: state.profile.copyWith(goal: goal)));

  void selectActivityLevel(String level) => emit(
      state.copyWith(profile: state.profile.copyWith(activityLevel: level)));

  Future<void> completeSetup() async {
    if (!state.canCompleteSetup) return;
    emit(state.copyWith(isSaving: true, error: null));
    try {
      final finalProfile = state.profile.copyWith(isCompleted: true);
      await _repo.saveProfile(finalProfile);
      emit(state.copyWith(profile: finalProfile, isSaving: false, saved: true));
    } catch (e, stack) {
  print('>>> SAVE ERROR: $e');
  print(stack);
  emit(state.copyWith(isSaving: false, error: 'There was an error pls Try again'));
}
  }
}