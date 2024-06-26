part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  final bool autoPlay;

  const OnboardingState({required this.currentIndex, required this.autoPlay});

  OnboardingState copyWith({int? currentIndex, bool? autoPlay}) {
    return OnboardingState(
      currentIndex: currentIndex ?? this.currentIndex,
      autoPlay: autoPlay ?? this.autoPlay,
    );
  }

  @override
  List<Object> get props => [currentIndex, autoPlay];
}
