import 'package:flutter/material.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class GradientShadow extends StatelessWidget {
  final double height;
  final bool isTop;

  const GradientShadow({super.key, required this.height, this.isTop = true});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: isTop ? Alignment.topCenter : Alignment.bottomCenter,
            end: isTop ? Alignment.bottomCenter : Alignment.topCenter,
            colors: [
              AppColors.kBlack.withValues(alpha: 0.8),
              AppColors.kBlack.withValues(alpha: 0),
            ],
          ),
        ),
      ),
    );
  }
}
