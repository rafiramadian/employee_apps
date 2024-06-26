import 'package:employee_apps/blocs/onboarding/onboarding_bloc.dart';
import 'package:employee_apps/blocs/onboarding/onboarding_status_cubit.dart';
import 'package:employee_apps/blocs/selected_user/selected_user_bloc.dart';
import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:employee_apps/utils/app_theme.dart';
import 'package:employee_apps/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  initializeLogger();
  setupDI();
  runApp(const EmployeeApps());
}

class EmployeeApps extends StatelessWidget {
  const EmployeeApps({super.key});

  @override
  Widget build(BuildContext context) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<OnboardingStatusCubit>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<OnboardingBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<UserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<SelectedUserBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            title: 'Employee Apps',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.getTheme(textScaleFactor),
            navigatorKey: NavigationService.navigatorKey,
            onGenerateRoute: AppRoutes.generateRoute,
            initialRoute: AppRoutes.splash,
          );
        },
      ),
    );
  }
}
