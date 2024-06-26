import 'package:employee_apps/blocs/selected_user/selected_user_bloc.dart';
import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/components/primary_button.dart';
import 'package:employee_apps/components/skeleton_loading.dart';
import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/utils/app_colors.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:employee_apps/utils/assets_constant.dart';
import 'package:employee_apps/utils/enum.dart';
import 'package:employee_apps/utils/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTile extends StatelessWidget {
  final User user;
  const UserTile({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final List<PopupOptionType> listAction = [
      PopupOptionType.select,
      PopupOptionType.update,
      PopupOptionType.delete,
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAvatar(imageUrl: user.avatar),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${user.firstName} ${user.lastName}',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BlocBuilder<SelectedUserBloc, SelectedUserState>(
                      builder: (context, state) {
                        return PopupMenuButton<PopupOptionType>(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          color: AppColors.backgroundPopupColor,
                          icon: const Icon(
                            Icons.more_horiz,
                            color: AppColors.primaryTextColor,
                          ),
                          onSelected: (item) {
                            switch (item) {
                              case PopupOptionType.select:
                                if (state is SelectedUserLoaded &&
                                    state.users.any(
                                        (element) => element.id == user.id)) {
                                  getIt
                                      .get<SelectedUserBloc>()
                                      .add(UnselectUser(user.id));
                                } else {
                                  getIt
                                      .get<SelectedUserBloc>()
                                      .add(SelectUser(user));
                                }
                                break;
                              case PopupOptionType.update:
                                NavigationService.push(
                                  AppRoutes.addUpdateUser,
                                  arguments: user,
                                );
                                break;
                              case PopupOptionType.delete:
                                _showDeleteBottomSheet(context, user.id);
                                break;
                              default:
                            }
                          },
                          itemBuilder: (context) => listAction
                              .map((popupOptionType) => _buildMenuOptionItem(
                                    context,
                                    popupOptionType,
                                    (state is SelectedUserLoaded &&
                                            state.users.any((element) =>
                                                element.id == user.id))
                                        ? true
                                        : false,
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
                Text(
                  user.email,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryColor,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  PopupMenuItem<PopupOptionType> _buildMenuOptionItem(
    BuildContext context,
    PopupOptionType popupOptionType,
    bool isSelected,
  ) {
    return PopupMenuItem<PopupOptionType>(
      value: popupOptionType,
      child: Container(
        padding: EdgeInsets.only(left: 24.w),
        width: 100.w,
        child: Text(
          (popupOptionType == PopupOptionType.select && isSelected)
              ? 'Unselect'
              : popupOptionType.name.capitalizeFirst(),
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 14.sp,
                letterSpacing: 0.15,
                color: (popupOptionType != PopupOptionType.delete)
                    ? AppColors.primaryTextColor
                    : AppColors.errorColor,
              ),
        ),
      ),
    );
  }

  void _showDeleteBottomSheet(BuildContext context, int id) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.whiteColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      useSafeArea: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            36.h,
            16.w,
            48.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Are you sure?',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 20.sp),
              ),
              SizedBox(height: 24.h),
              BlocConsumer<UserBloc, UserState>(
                listenWhen: (previous, current) {
                  return (ModalRoute.of(context)?.isCurrent ?? false);
                },
                listener: (context, state) {
                  if (state is DeleteUserSuccess) {
                    NavigationService.pushAndRemoveUntil(
                      AppRoutes.success,
                      arguments: ActionType.delete,
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
                      getIt.get<UserBloc>().add(DeleteUser(id));
                    },
                    text: 'DELETE NOW',
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
              )
            ],
          ),
        );
      },
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String imageUrl;
  const UserAvatar({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: Image.network(
        imageUrl,
        width: 102.w,
        height: 95.h,
        fit: BoxFit.fill,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;

          return RectangleSkeletonAnimation(
            width: 102.w,
            height: 95.h,
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            assetImagePlaceholder,
            width: 102.w,
            height: 95.h,
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
