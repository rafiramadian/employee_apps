import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:employee_apps/ui/home/widgets/non_selected_user_list.dart';
import 'package:employee_apps/ui/home/widgets/selected_user_list.dart';
import 'package:employee_apps/utils/app_colors.dart';
import 'package:employee_apps/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          double.infinity,
          95.h,
        ),
        child: AppBar(
          elevation: 0.1,
          centerTitle: false,
          title: _buildTitle(),
          actions: _buildActionsButton(),
          bottom: _buildBottomAppBar(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          NonSelectedUserList(),
          SelectedUserList(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 4.w),
      child: Text(
        'User List',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 17.sp,
            ),
      ),
    );
  }

  List<Widget> _buildActionsButton() {
    return [
      Padding(
        padding: EdgeInsets.only(right: 20.w),
        child: ElevatedButton(
          onPressed: () {
            NavigationService.push(AppRoutes.addUpdateUser);
          },
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            alignment: Alignment.center,
            minimumSize: Size(45.w, 45.h),
            padding: EdgeInsets.zero,
            backgroundColor: AppColors.addButtonColor,
            foregroundColor: AppColors.blackColor,
          ),
          child: const Icon(
            Icons.add,
            size: 30,
          ),
        ),
      ),
    ];
  }

  PreferredSizeWidget _buildBottomAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Padding(
        padding: EdgeInsets.only(right: 64.w),
        child: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primaryColor,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 20.w),
          labelColor: AppColors.primaryColor,
          labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
              ),
          unselectedLabelColor: AppColors.primaryTextColor,
          unselectedLabelStyle: Theme.of(context).textTheme.bodyMedium,
          tabs: const [
            Tab(
              text: 'Non Selected',
            ),
            Tab(
              text: 'Selected',
            ),
          ],
        ),
      ),
    );
  }
}
