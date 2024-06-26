import 'package:employee_apps/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final Function()? onTap;
  final String? Function(String? value)? validator;
  final bool disable;
  final String? initialValue;
  final Widget? suffixIcon;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.title,
    this.disable = false,
    this.onTap,
    this.initialValue,
    this.suffixIcon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: 16.h),
        FormField<String>(
          initialValue: initialValue,
          validator: validator,
          builder: (FormFieldState<String> field) {
            controller.addListener(() {
              field.didChange(controller.text);
              if (controller.text != field.value) {
                field.validate();
              }
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 62.h,
                  padding: EdgeInsets.only(
                    left: 12.w,
                    top: 12.h,
                    bottom: 8.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.backgroundWidgetColor,
                    border: (field.hasError)
                        ? Border.all(color: AppColors.errorColor)
                        : null,
                  ),
                  child: TextFormField(
                    controller: controller,
                    readOnly: disable,
                    onTap: onTap,
                    initialValue: initialValue,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: title,
                      suffixIcon: suffixIcon,
                    ),
                    onChanged: (value) {
                      field.didChange(value);
                    },
                  ),
                ),
                if (field.hasError)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      field.errorText ?? '',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
