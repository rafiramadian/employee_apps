import 'package:employee_apps/components/skeleton_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 24.h),
          RectangleSkeletonAnimation(
            height: 25.h,
            radius: 10.r,
          ),
          ...List.generate(
            3,
            (index) => Padding(
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
            ),
          )
        ],
      ),
    );
  }
}
