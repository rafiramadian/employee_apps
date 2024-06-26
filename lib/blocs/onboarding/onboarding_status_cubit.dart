import 'package:employee_apps/data/repositories/onboarding_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingStatusCubit extends Cubit<bool> {
  final OnboardingRepository _repository;
  OnboardingStatusCubit({
    required OnboardingRepository repository,
  })  : _repository = repository,
        super(true);

  Future<void> getOnboardingStatus() async {
    try {
      final bool result = await _repository.getOnboardingStatus();
      emit(result);
    } catch (e) {
      emit(true);
    }
  }

  Future<void> setOnboardingStatus() async {
    try {
      await _repository.setOnboardingStatus(false);
      emit(false);
    } catch (e) {
      emit(true);
    }
  }
}
