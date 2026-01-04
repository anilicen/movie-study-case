import 'dart:math';

enum PaywallVariant { variantA, variantB }

class RemoteConfigService {
  PaywallVariant _paywallVariant = PaywallVariant.variantA;

  PaywallVariant get paywallVariant => _paywallVariant;

  List<PaywallVariant> _variantBag = [];

  void randomizePaywallVariant() {
    if (_variantBag.isEmpty) {
      _variantBag.addAll(PaywallVariant.values);
    }

    final random = Random();
    final index = random.nextInt(_variantBag.length);

    _paywallVariant = _variantBag.removeAt(index);
  }

  Future<void> fetchAndActivate() async {
    randomizePaywallVariant();
  }
}
