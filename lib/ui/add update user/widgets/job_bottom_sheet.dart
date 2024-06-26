import 'package:employee_apps/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class JobBottomSheet extends StatelessWidget {
  final TextEditingController jobController;
  const JobBottomSheet({
    super.key,
    required this.jobController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.w,
        48.h,
        16.w,
        48.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildJobOptionTile(context, 'Front End'),
          SizedBox(height: 24.h),
          _buildJobOptionTile(context, 'Back End'),
          SizedBox(height: 24.h),
          _buildJobOptionTile(context, 'Data Analyst'),
        ],
      ),
    );
  }

  Widget _buildJobOptionTile(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        jobController.text = title;
        NavigationService.pop();
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
          ),
          const Icon(
            Icons.keyboard_arrow_right,
            size: 40,
          ),
        ],
      ),
    );
  }
}
