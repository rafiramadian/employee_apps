import 'package:carousel_slider/carousel_controller.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  static const totalOnboardingScreens = 4;
  static final CarouselController carouselController = CarouselController();

  OnboardingBloc()
      : super(const OnboardingState(currentIndex: 0, autoPlay: true)) {
    on<PageChanged>(_onPageChanged);
  }

  void _onPageChanged(PageChanged event, emit) {
    emit(state.copyWith(
      currentIndex: event.pageIndex,
      autoPlay: event.pageIndex != 3,
    ));
  }
}
