import 'package:flutter/material.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class PrimaryChips extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function() onTap;
  const PrimaryChips({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 8 : 20,
          vertical: 6.5,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kLightRed : AppColors.kWhite,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            if (isSelected)
              Row(
                children: [
                  Image.asset(
                    'assets/checkmark_chips.png',
                    width: 16,
                    height: 16,
                    color: AppColors.kWhite,
                  ),
                  const SizedBox(width: 2),
                ],
              ),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.kWhite : AppColors.kBlack,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
