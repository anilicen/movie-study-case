import 'package:flutter/material.dart';
import 'package:movie_study_case/config/theme/app_colors.dart';

class PaywallVariantB extends StatelessWidget {
  const PaywallVariantB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kBlack,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.diamond, size: 100, color: Colors.blueAccent),
            const SizedBox(height: 20),
            const Text(
              'Paywall Variant B',
              style: TextStyle(
                color: AppColors.kWhite,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Focus on Monthly Plan',
              style: TextStyle(
                color: AppColors.kWhite.withOpacity(0.7),
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
