import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/components/primary_button.dart';
import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/utils/app_colors.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:employee_apps/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserSuccess extends StatelessWidget {
  final ActionType actionType;
  const UserSuccess({
    super.key,
    required this.actionType,
  });

  @override
  Widget build(BuildContext context) {
    late String message;

    switch (actionType) {
      case ActionType.create:
        message = 'Create Successful';
        break;
      case ActionType.update:
        message = 'Update Successful';
        break;
      default:
        message = 'Delete Successful';
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                padding: EdgeInsets.all(16.r),
                child: const Icon(
                  Icons.check,
                  color: AppColors.whiteColor,
                  size: 60,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 16.h),
              PrimaryButton(
                onTap: () {
                  getIt.get<UserBloc>().add(const FetchUserList());
                  NavigationService.pushAndRemoveUntil(AppRoutes.home);
                },
                text: 'OK',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
