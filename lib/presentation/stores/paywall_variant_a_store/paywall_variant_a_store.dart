import 'package:mobx/mobx.dart';

part 'paywall_variant_a_store.g.dart';

class PaywallVariantAStore = _PaywallVariantAStore with _$PaywallVariantAStore;

abstract class _PaywallVariantAStore with Store {
  // Logic and animations will be added later

  @observable
  bool isInitialized = false;

  @observable
  bool isFreeTrialEnabled = false;

  @action
  void init() {
    isInitialized = true;
  }

  @action
  void toggleFreeTrial(bool value) {
    isFreeTrialEnabled = value;
    if (value) {
      selectedOption = 'Yearly';
    }
  }

  @observable
  String selectedOption = 'Yearly';

  @action
  void selectOption(String option) {
    selectedOption = option;
    if (selectedOption != 'Yearly') {
      isFreeTrialEnabled = false;
    }
  }

  @computed
  int get enabledFeaturesCount {
    if (isFreeTrialEnabled) return 4; // Yearly is forced, so 4
    switch (selectedOption) {
      case 'Weekly':
        return 2;
      case 'Monthly':
        return 3;
      case 'Yearly':
        return 4;
      default:
        return 4;
    }
  }
}
