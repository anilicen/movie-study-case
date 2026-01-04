import 'package:flutter/material.dart';
import 'package:movie_study_case/core/di/service_locator.dart';
import 'package:movie_study_case/core/services/remote_config_service.dart';
import 'package:movie_study_case/presentation/screens/paywall/variants/paywall_variant_a.dart';
import 'package:movie_study_case/presentation/screens/paywall/variants/paywall_variant_b.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  late final PaywallVariant variant;

  @override
  void initState() {
    super.initState();
    final remoteConfig = getIt<RemoteConfigService>();
    remoteConfig.randomizePaywallVariant();
    variant = remoteConfig.paywallVariant;
  }

  @override
  Widget build(BuildContext context) {
    // A/B Testing Logic
    switch (variant) {
      case PaywallVariant.variantA:
        return const PaywallVariantA();
      case PaywallVariant.variantB:
        return const PaywallVariantB();
    }
  }
}
