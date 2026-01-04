import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class AutoRenewText extends StatelessWidget {
  const AutoRenewText({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/shield_checkmark.png', height: 16.h, width: 16.w),
        SizedBox(width: 4.w),
        Text(
          'Auto Renewable, Cancel Anytime',
          style: TextStyle(color: AppColors.kWhite, fontSize: 10.sp),
        ),
      ],
    );
  }
}
