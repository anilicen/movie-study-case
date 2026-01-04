import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isLoading;
  final VoidCallback? onPressed;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.isActive,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive && !isLoading ? onPressed : null,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 18.5.h),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive ? AppColors.kLightRed : AppColors.kDarkRed,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: const CircularProgressIndicator(
                    color: AppColors.kWhite,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: isActive ? AppColors.kWhite : AppColors.kGray,
                    fontWeight: FontWeight.w600, // Semibold
                  ),
                ),
        ),
      ),
    );
  }
}
