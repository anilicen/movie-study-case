import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.symmetric(vertical: 18.5),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive ? AppColors.kLightRed : AppColors.kDarkRed,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
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
