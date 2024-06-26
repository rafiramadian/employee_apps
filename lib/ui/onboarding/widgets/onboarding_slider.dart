import 'package:carousel_slider/carousel_slider.dart';
import 'package:employee_apps/blocs/onboarding/onboarding_bloc.dart';
import 'package:employee_apps/di/injector.dart';
import 'package:employee_apps/utils/assets_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingSlider extends StatelessWidget {
  const OnboardingSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<OnboardingBloc, OnboardingState>(
        builder: (context, onboardingState) {
          return CarouselSlider(
            carouselController: OnboardingBloc.carouselController,
            options: CarouselOptions(
              height: double.infinity,
              autoPlay: onboardingState.autoPlay,
              enableInfiniteScroll: false,
              reverse: false,
              viewportFraction: 1,
              enlargeCenterPage: true,
              enlargeFactor: 0.25,
              onPageChanged: (index, reason) {
                getIt.get<OnboardingBloc>().add(PageChanged(index));
              },
            ),
            items: List.generate(
              OnboardingBloc.totalOnboardingScreens,
              (index) => _buildItem(context),
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 48.h),
        Image.asset(
          assetIllustrationOnboarding1,
          height: 292.h,
          width: 240.w,
        ),
        SizedBox(height: 24.h),
        Text(
          'Loren Ipsum Sit Amet',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 24.sp,
              ),
        ),
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Text(
            'Lorem ipsum dolor sit amet, consectetur elit sit amet',
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
