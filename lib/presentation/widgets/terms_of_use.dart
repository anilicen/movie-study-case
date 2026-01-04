import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Terms of Use',
          style: TextStyle(color: AppColors.kWhite, fontSize: 8.sp),
        ),
        Text(
          'Restore Purchase',
          style: TextStyle(color: AppColors.kWhite, fontSize: 8.sp),
        ),
        Text(
          'Privacy Policy',
          style: TextStyle(color: AppColors.kWhite, fontSize: 8.sp),
        ),
      ],
    );
  }
}
