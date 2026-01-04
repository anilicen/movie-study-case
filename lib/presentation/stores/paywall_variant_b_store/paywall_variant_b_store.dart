import 'package:mobx/mobx.dart';

part 'paywall_variant_b_store.g.dart';

class PaywallVariantBStore = _PaywallVariantBStore with _$PaywallVariantBStore;

abstract class _PaywallVariantBStore with Store {
  @observable
  String selectedOption = 'Yearly';

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  void selectOption(String option) {
    selectedOption = option;
  }

  @action
  Future<void> purchaseSubscription() async {
    isLoading = true;
    errorMessage = null;
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      errorMessage = 'Purchase failed. Please try again.';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> restorePurchases() async {
    isLoading = true;
    errorMessage = null;
    try {
      await Future.delayed(const Duration(seconds: 1));
    } catch (e) {
      errorMessage = 'Restore failed.';
    } finally {
      isLoading = false;
    }
  }
}
