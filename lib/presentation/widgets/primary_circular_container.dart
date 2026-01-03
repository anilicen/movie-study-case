import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class PrimaryCircularContainer extends StatelessWidget {
  final Widget? child;
  final bool isActive;

  const PrimaryCircularContainer({
    super.key,
    this.child,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          shape: BoxShape.circle,
          border: isActive
              ? Border.all(color: AppColors.kLightRed, width: 2)
              : null,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (child != null) child!,
            if (isActive)
              Positioned(
                right: 0,
                bottom: 0,
                child: SvgPicture.asset('assets/checkmark.svg'),
              ),
          ],
        ),
      ),
    );
  }
}
