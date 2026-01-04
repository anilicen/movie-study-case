import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class SubscriptionOption extends StatelessWidget {
  final bool isSelected;
  final String optionName;
  final String price;
  final String perWeekPrice;
  final Function() onSelected;
  const SubscriptionOption({
    super.key,
    required this.isSelected,
    required this.optionName,
    required this.price,
    required this.perWeekPrice,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 20.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.kLightRed : AppColors.kDarkGray,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (isSelected)
                  SvgPicture.asset(
                    'assets/checkmark.svg',
                    height: 16.h,
                    width: 16.w,
                  )
                else
                  Container(
                    width: 16.w,
                    height: 16.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? AppColors.kLightRed : Colors.white,
                        width: 2.w,
                      ),
                    ),
                  ),
                SizedBox(width: 20.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      optionName,
                      style: TextStyle(
                        color: AppColors.kWhite,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Only \$$perWeekPrice per week',
                      style: TextStyle(
                        color: AppColors.kDarkGray,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            Text(
              '\$$price / ${optionName.replaceFirst('ly', '')}',
              style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
