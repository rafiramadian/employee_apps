import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class RectangleSkeletonAnimation extends StatelessWidget {
  final double height;
  final double? width;
  final double? radius;
  const RectangleSkeletonAnimation({
    Key? key,
    required this.height,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerColor: Colors.white54,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius:
              (radius != null) ? BorderRadius.circular(radius!) : null,
          color: Colors.grey[300],
        ),
      ),
    );
  }
}
