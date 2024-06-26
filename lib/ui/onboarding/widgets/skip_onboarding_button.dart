import 'package:employee_apps/blocs/onboarding/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SkipOnboardingButton extends StatelessWidget {
  const SkipOnboardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () {
            if (state.currentIndex != 3) {
              OnboardingBloc.carouselController.animateToPage(3);
            }
          },
          child: Text(
            (state.currentIndex != 3) ? 'Skip' : '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        );
      },
    );
  }
}
