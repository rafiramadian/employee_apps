import 'package:employee_apps/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final Widget? child;
  final double borderRadius;
  final Color color;
  final EdgeInsets? padding;
  final double? width;
  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.borderRadius = 10,
    this.color = AppColors.primaryColor,
    this.padding,
    this.width,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: (padding != null)
            ? padding
            : EdgeInsets.symmetric(
                vertical: 16.h,
              ),
        width: (width != null) ? width : double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          color: color,
        ),
        child: (child != null)
            ? child
            : Text(
                text,
                style: Theme.of(context).textTheme.titleSmall!.copyWith(
                      color: AppColors.whiteColor,
                    ),
              ),
      ),
    );
  }
}
