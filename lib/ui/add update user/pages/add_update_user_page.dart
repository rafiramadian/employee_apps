import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/components/form_field.dart';
import 'package:employee_apps/components/primary_button.dart';
import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/ui/add%20update%20user/widgets/job_bottom_sheet.dart';
import 'package:employee_apps/utils/app_colors.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:employee_apps/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddUpdateUserPage extends StatefulWidget {
  final User? user;
  const AddUpdateUserPage({super.key, this.user});

  @override
  State<AddUpdateUserPage> createState() => _AddUpdateUserPageState();
}

class _AddUpdateUserPageState extends State<AddUpdateUserPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    jobController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(
          double.infinity,
          kToolbarHeight,
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: AppBar(
            elevation: 0.0,
            title: _buildTitle(),
            centerTitle: false,
            leading: _buildLeadingWidget(),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.all(16.h),
          child: Column(
            children: [
              CustomFormField(
                controller: nameController,
                title: 'NAME',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.h),
              CustomFormField(
                controller: jobController,
                title: 'JOB',
                onTap: () {
                  _showJobOptionBottomSheet(context);
                },
                disable: true,
                suffixIcon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryTextColor,
                  size: 30,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job';
                  }
                  return null;
                },
              ),
              const Spacer(),
              BlocConsumer<UserBloc, UserState>(
                listener: (context, state) {
                  if (state is AddUserSuccess) {
                    NavigationService.pushAndRemoveUntil(
                      AppRoutes.success,
                      arguments: ActionType.create,
                    );
                  }

                  if (state is UpdateUserSuccess) {
                    NavigationService.pushAndRemoveUntil(
                      AppRoutes.success,
                      arguments: ActionType.update,
                    );
                  }

                  if (state is UserError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(state.message.toString()),
                    ));
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    onTap: () {
                      if (state is! UserLoading) {
                        if (formKey.currentState!.validate()) {
                          if (widget.user != null) {
                            getIt.get<UserBloc>().add(UpdateUser(
                                  nameController.text,
                                  jobController.text,
                                  widget.user!.id,
                                ));
                          } else {
                            getIt.get<UserBloc>().add(AddUser(
                                  nameController.text,
                                  jobController.text,
                                ));
                          }
                        }
                      }
                    },
                    text: (widget.user != null) ? 'UPDATE' : 'CREATE',
                    child: (state is UserLoading)
                        ? SizedBox(
                            height: 16.h,
                            width: 16.w,
                            child: const CircularProgressIndicator(
                              strokeWidth: 4,
                              color: AppColors.whiteColor,
                            ),
                          )
                        : null,
                  );
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      (widget.user != null) ? 'Update User' : 'Create User',
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontSize: 17.sp,
            color: AppColors.blackColor,
            letterSpacing: 0.15,
          ),
    );
  }

  Widget _buildLeadingWidget() {
    return GestureDetector(
      onTap: () {
        NavigationService.pop();
      },
      child: Container(
        width: 45.w,
        height: 45.h,
        margin: EdgeInsets.all(4.w),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.backgroundCloseButtonColor,
        ),
        child: const Icon(
          Icons.close,
          color: AppColors.blackColor,
        ),
      ),
    );
  }

  void _showJobOptionBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      useSafeArea: true,
      builder: (context) {
        return JobBottomSheet(
          jobController: jobController,
        );
      },
    );
  }
}
