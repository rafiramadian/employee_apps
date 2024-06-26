import 'package:employee_apps/blocs/onboarding/onboarding_bloc.dart';
import 'package:employee_apps/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingDotIndicator extends StatelessWidget {
  const OnboardingDotIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            OnboardingBloc.totalOnboardingScreens,
            (index) => _buildItem(
              index,
              state.currentIndex,
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(
    int index,
    int currentIndex,
  ) {
    return Container(
      margin: EdgeInsets.only(right: (index == 3) ? 0 : 8.w),
      width: 10.w,
      height: 10.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: (index == currentIndex)
            ? AppColors.primaryColor
            : AppColors.primaryColor.withOpacity(0.3),
      ),
    );
  }
}
