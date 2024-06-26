import 'package:employee_apps/blocs/onboarding/onboarding_bloc.dart';
import 'package:employee_apps/blocs/onboarding/onboarding_status_cubit.dart';
import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/components/primary_button.dart';
import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NextOnboardingButton extends StatelessWidget {
  const NextOnboardingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, state) {
          return PrimaryButton(
            onTap: () {
              if (state.currentIndex != 3) {
                OnboardingBloc.carouselController.nextPage();
              } else {
                getIt.get<OnboardingStatusCubit>().setOnboardingStatus();
                getIt.get<UserBloc>().add(const FetchUserList());
                NavigationService.pushAndRemoveUntil(AppRoutes.home);
              }
            },
            text: (state.currentIndex != 3) ? 'NEXT' : 'GET STARTED',
          );
        },
      ),
    );
  }
}
