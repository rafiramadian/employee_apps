import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/ui/add%20update%20user/pages/add_update_user_page.dart';
import 'package:employee_apps/ui/add%20update%20user/pages/user_success_page.dart';
import 'package:employee_apps/ui/home/pages/home_page.dart';
import 'package:employee_apps/ui/onboarding/pages/onboarding_pages.dart';
import 'package:employee_apps/ui/splash/splash_page.dart';
import 'package:employee_apps/utils/enum.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String addUpdateUser = '/add-update-user';
  static const String success = '/success';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingPage(),
        );
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case addUpdateUser:
        return MaterialPageRoute(
          builder: (_) => AddUpdateUserPage(
            user: settings.arguments as User?,
          ),
        );
      case success:
        return MaterialPageRoute(
          builder: (_) => UserSuccess(
            actionType: settings.arguments as ActionType,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
