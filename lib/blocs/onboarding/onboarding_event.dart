part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends OnboardingEvent {
  final int pageIndex;

  const PageChanged(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class NextPage extends OnboardingEvent {}

class SkipToLastPage extends OnboardingEvent {}
