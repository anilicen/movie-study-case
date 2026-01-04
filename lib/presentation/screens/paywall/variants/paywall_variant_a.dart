import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/presentation/stores/paywall_variant_a_store/paywall_variant_a_store.dart';
import 'package:movie_study_case/presentation/widgets/primary_button.dart';
import 'package:movie_study_case/presentation/widgets/subscription_option.dart';

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Observer(
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 22.h),
                    Center(
                      child: Text(
                        'AppName',
                        style: TextStyle(
                          color: AppColors.kWhite,
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Content Columns
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Features Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 30.h), // Spacer for Header
                              _buildFeatureText('Daily Movie Suggestions'),
                              _buildFeatureText('Create Watch Parties'),
                              _buildFeatureText('Detailed Statistics'),
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
                            _buildFeatureIcon(true),
                            _buildFeatureIcon(false),
                            _buildFeatureIcon(false),
                            _buildFeatureIcon(false),
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
                              _buildFeatureIcon(true),
                              _buildFeatureIcon(true),
                              _buildFeatureIcon(true),
                              _buildFeatureIcon(true),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),

                    // Free Trial Toggle
                    Container(
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
                            onChanged: (value) => store.toggleFreeTrial(value),
                            activeTrackColor: const Color(0xFF34C759),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36.h),
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
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/shield_checkmark.png',
                          height: 16.h,
                          width: 16.w,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Auto Renewable, Cancel Anytime',
                          style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 10.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    PrimaryButton(
                      text: 'Unlock MovieAI PRO',
                      isActive: true,
                      isLoading: false,
                      onPressed: () {},
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Terms of Use',
                          style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 8.sp,
                          ),
                        ),
                        Text(
                          'Restore Purchase',
                          style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 8.sp,
                          ),
                        ),
                        Text(
                          'Privacy Policy',
                          style: TextStyle(
                            color: AppColors.kWhite,
                            fontSize: 8.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              );
            },
          ),
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

  Widget _buildFeatureIcon(bool isEnabled) {
    return Container(
      height: 40.h, // Fixed height for alignment
      width: 50.w,
      alignment: Alignment.center,
      child: isEnabled
          ? Image.asset(
              'assets/green_check_circle.png',
              width: 24.w,
              height: 24.h,
            )
          : Image.asset('assets/gray-cross.png', width: 24.w, height: 24.h),
    );
  }
}
