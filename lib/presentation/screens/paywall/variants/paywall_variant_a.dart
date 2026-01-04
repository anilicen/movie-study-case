import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_study_case/config/app_config.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/paywall_variant_a_store/paywall_variant_a_store.dart';
import 'package:movie_study_case/presentation/widgets/animated_feature_icon.dart';
import 'package:movie_study_case/presentation/widgets/animated_free_trial_button.dart';
import 'package:movie_study_case/presentation/widgets/auto_renew_text.dart';
import 'package:movie_study_case/presentation/widgets/primary_button.dart';
import 'package:movie_study_case/presentation/widgets/subscription_option.dart';
import 'package:movie_study_case/presentation/widgets/terms_of_use.dart';

class PaywallVariantA extends StatefulWidget {
  const PaywallVariantA({super.key});

  @override
  State<PaywallVariantA> createState() => _PaywallVariantAState();
}

class _PaywallVariantAState extends State<PaywallVariantA> {
  late final PaywallVariantAStore store;

  @override
  void initState() {
    super.initState();
    store = getIt<PaywallVariantAStore>();
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: SafeArea(
        child: Stack(
          children: [
            Observer(
              builder: (_) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 22.h),
                      Center(
                        child: Text(
                          AppConfig.instance.appName,
                          style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Content Columns
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Features Column
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30.h), // Spacer for Header
                                  _buildFeatureText('Daily Movie Suggestions'),
                                  _buildFeatureText(
                                    'AI-Powered Movie Insights',
                                  ),
                                  _buildFeatureText('Personalized Watchlists'),
                                  _buildFeatureText('Ad-Free Experience'),
                                ],
                              ),
                            ),

                            // FREE Column
                            Column(
                              children: [
                                SizedBox(
                                  height: 30.h,
                                  child: Center(
                                    child: Text(
                                      'FREE',
                                      style: TextStyle(
                                        color: AppColors.kWhite,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                AnimatedFeatureIcon(isEnabled: true, index: 0),
                                AnimatedFeatureIcon(isEnabled: false, index: 1),
                                AnimatedFeatureIcon(isEnabled: false, index: 2),
                                AnimatedFeatureIcon(isEnabled: false, index: 3),
                              ],
                            ),

                            SizedBox(width: 20.w),

                            // PRO Column
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: AppColors.kLightRed),
                              ),

                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 30.h,
                                    child: Center(
                                      child: Text(
                                        'PRO',
                                        style: TextStyle(
                                          color: AppColors.kWhite,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  ...List.generate(4, (index) {
                                    return AnimatedFeatureIcon(
                                      isEnabled:
                                          index < store.enabledFeaturesCount,
                                      index: index,
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Free Trial Toggle
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 8.h,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.kLightRed),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enable Free Trial',
                                style: TextStyle(
                                  color: AppColors.kWhite,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              CupertinoSwitch(
                                value: store.isFreeTrialEnabled,
                                onChanged: (value) =>
                                    store.toggleFreeTrial(value),
                                activeTrackColor: const Color(0xFF34C759),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 36.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          children: [
                            SubscriptionOption(
                              optionName: 'Weekly',
                              price: '1.99',
                              perWeekPrice: '1.99',
                              isSelected: store.selectedOption == 'Weekly',
                              onSelected: () => store.selectOption('Weekly'),
                            ),
                            SizedBox(height: 20.h),
                            SubscriptionOption(
                              optionName: 'Monthly',
                              price: '11.99',
                              perWeekPrice: '2.99',
                              isSelected: store.selectedOption == 'Monthly',
                              onSelected: () => store.selectOption('Monthly'),
                            ),
                            SizedBox(height: 20.h),
                            SubscriptionOption(
                              optionName: 'Yearly',
                              price: '49.99',
                              perWeekPrice: '0.96',
                              isSelected: store.selectedOption == 'Yearly',
                              onSelected: () => store.selectOption('Yearly'),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),
                      AutoRenewText(),
                      SizedBox(height: 20.h),
                      if (store.isFreeTrialEnabled)
                        AnimatedFreeTrialButton(
                          onPressed: () {},
                          line1: '3 Days Free',
                          line2: 'No Payment Now',
                        )
                      else
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: PrimaryButton(
                            text: 'Unlock MovieAI PRO',
                            isActive: true,
                            isLoading: false,
                            onPressed: () {},
                          ),
                        ),
                      SizedBox(height: 12.h),
                      TermsOfUse(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              top: 16.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Icon(Icons.close, color: AppColors.kWhite, size: 24.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureText(String text) {
    return Container(
      height: 40.h, // Fixed height for alignment
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
          color: AppColors.kWhite,
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
