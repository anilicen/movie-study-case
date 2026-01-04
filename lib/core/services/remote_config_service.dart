import 'dart:math';

enum PaywallVariant {
  variantA,
  variantB,
  // Scalable for C, D, etc.
}

class RemoteConfigService {
  PaywallVariant _paywallVariant = PaywallVariant.variantA;

  PaywallVariant get paywallVariant => _paywallVariant;

  Future<void> fetchAndActivate() async {
    // In a real app, this would come from Firebase Remote Config
    final random = Random();
    _paywallVariant =
        PaywallVariant.values[random.nextInt(PaywallVariant.values.length)];
  }
}
