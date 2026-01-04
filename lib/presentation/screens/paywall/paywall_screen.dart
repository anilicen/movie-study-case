import 'package:flutter/material.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/core/services/remote_config_service.dart';
import 'package:movie_study_case/presentation/screens/paywall/variants/paywall_variant_a.dart';
import 'package:movie_study_case/presentation/screens/paywall/variants/paywall_variant_b.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the variant determined during Splash initialization
    final remoteConfig = getIt<RemoteConfigService>();
    final variant = remoteConfig.paywallVariant;

    // A/B Testing Logic
    switch (PaywallVariant.variantA) {
      case PaywallVariant.variantA:
        return const PaywallVariantA();
      case PaywallVariant.variantB:
        return const PaywallVariantB();
    }
  }
}
