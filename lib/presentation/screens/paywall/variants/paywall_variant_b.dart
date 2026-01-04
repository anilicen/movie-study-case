import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_study_case/config/app_config.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/paywall_variant_b_store/paywall_variant_b_store.dart';
import 'package:movie_study_case/presentation/widgets/auto_renew_text.dart';
import 'package:movie_study_case/presentation/widgets/primary_button.dart';
import 'package:movie_study_case/presentation/widgets/subscription_option.dart';
import 'package:movie_study_case/presentation/widgets/terms_of_use.dart';

class PaywallVariantB extends StatefulWidget {
  const PaywallVariantB({super.key});

  @override
  State<PaywallVariantB> createState() => _PaywallVariantBState();
}

class _PaywallVariantBState extends State<PaywallVariantB> {
  late final PaywallVariantBStore store;

  @override
  void initState() {
    super.initState();
    store = getIt<PaywallVariantBStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/paywall_background.png',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Main Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close Button
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        margin: EdgeInsets.only(top: 16.h),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 185.h),

                  Text(
                    AppConfig.instance.appName,
                    style: TextStyle(
                      color: AppColors.kWhite,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Feature List with Checkmark Chips
                  _buildFeatureItem('Daily Movie Suggestions'),
                  _buildFeatureItem('AI-Powered Movie Insights'),
                  _buildFeatureItem('Personalized Watchlists'),
                  _buildFeatureItem('Ad-Free Experience'),

                  const Spacer(),

                  // Subscription Options
                  Observer(
                    builder: (_) {
                      return Column(
                        children: [
                          SubscriptionOption(
                            optionName: 'Monthly',
                            price: '7.99',
                            perWeekPrice: '2.99',
                            isSelected: store.selectedOption == 'Monthly',
                            onSelected: () => store.selectOption('Monthly'),
                          ),
                          SizedBox(height: 12.h),
                          SubscriptionOption(
                            optionName: 'Yearly',
                            price: '39.99',
                            perWeekPrice: '0.96',
                            isSelected: store.selectedOption == 'Yearly',
                            onSelected: () => store.selectOption('Yearly'),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 20.h),
                  AutoRenewText(),
                  SizedBox(height: 12.h),
                  // CTA Button
                  Observer(
                    builder: (_) => PrimaryButton(
                      text: 'Continue',
                      onPressed: store.purchaseSubscription,
                      isLoading: store.isLoading,
                      isActive: true,
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Footer Links
                  TermsOfUse(),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/checkmark_chips.png', width: 24.w, height: 24.w),
          SizedBox(width: 12.w),
          Text(
            text,
            style: TextStyle(
              color: AppColors.kWhite,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
