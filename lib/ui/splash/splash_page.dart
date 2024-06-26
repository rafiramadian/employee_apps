import 'package:employee_apps/blocs/onboarding/onboarding_status_cubit.dart';
import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:employee_apps/utils/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final OnboardingStatusCubit _onboardingStatusCubit;

  @override
  void initState() {
    _onboardingStatusCubit = getIt.get<OnboardingStatusCubit>();
    _navigateToHome();
    super.initState();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () async {
      await _onboardingStatusCubit.getOnboardingStatus();

      if (_onboardingStatusCubit.state) {
        NavigationService.pushAndRemoveUntil(AppRoutes.onboarding);
      } else {
        getIt.get<UserBloc>().add(const FetchUserList());
        NavigationService.pushAndRemoveUntil(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Image.asset(
            assetLogoSplash,
            width: 240.w,
          ),
        ),
      ),
    );
  }
}
