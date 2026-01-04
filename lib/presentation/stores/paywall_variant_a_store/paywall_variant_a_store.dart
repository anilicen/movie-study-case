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
  }

  @observable
  String selectedOption = 'Yearly';

  @action
  void selectOption(String option) {
    selectedOption = option;
  }
}
