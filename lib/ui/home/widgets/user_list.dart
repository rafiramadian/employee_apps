import 'package:employee_apps/blocs/user/user_bloc.dart';
import 'package:employee_apps/components/skeleton_loading.dart';
import 'package:employee_apps/data/models/user_model.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/ui/home/widgets/user_tile.dart';
import 'package:employee_apps/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserList extends StatefulWidget {
  final int totalUser;
  final List<User> users;
  final bool hasReachedMax;
  const UserList({
    super.key,
    required this.totalUser,
    required this.users,
    required this.hasReachedMax,
  });

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      getIt.get<UserBloc>().add(const FetchUserList(initialFetch: false));
    }
  }

  @override
  Widget build(BuildContext context) {
    int length = 0;
    length += widget.users.length;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Total ${widget.totalUser} items',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.secondaryTextColor.withOpacity(0.8),
                ),
          ),
          SizedBox(height: 16.h),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async =>
                  getIt.get<UserBloc>().add(const FetchUserList()),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: length + 1,
                itemBuilder: (context, index) {
                  if (index < widget.users.length) {
                    return UserTile(
                      user: widget.users[index],
                    );
                  } else {
                    if (!widget.hasReachedMax) {
                      return _buildLoadingItem();
                    }
                  }

                  return null;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingItem() {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.h,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RectangleSkeletonAnimation(
            height: 102.h,
            width: 102.w,
            radius: 20.r,
          ),
          SizedBox(
            width: 12.w,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Column(
                children: [
                  RectangleSkeletonAnimation(
                    height: 25.h,
                    radius: 10.r,
                  ),
                  SizedBox(height: 16.h),
                  RectangleSkeletonAnimation(
                    height: 25.h,
                    radius: 10.r,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
