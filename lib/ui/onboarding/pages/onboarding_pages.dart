import 'package:employee_apps/ui/onboarding/widgets/next_onboarding_button.dart';
import 'package:employee_apps/ui/onboarding/widgets/onboarding_dot_indicator.dart';
import 'package:employee_apps/ui/onboarding/widgets/onboarding_slider.dart';
import 'package:employee_apps/ui/onboarding/widgets/skip_onboarding_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingSlider(),
            const OnboardingDotIndicator(),
            SizedBox(height: 52.h),
            const NextOnboardingButton(),
            const SkipOnboardingButton(),
          ],
        ),
      ),
    );
  }
}
