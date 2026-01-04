// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall_variant_b_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaywallVariantBStore on _PaywallVariantBStore, Store {
  late final _$selectedOptionAtom = Atom(
    name: '_PaywallVariantBStore.selectedOption',
    context: context,
  );

  @override
  String get selectedOption {
    _$selectedOptionAtom.reportRead();
    return super.selectedOption;
  }

  @override
  set selectedOption(String value) {
    _$selectedOptionAtom.reportWrite(value, super.selectedOption, () {
      super.selectedOption = value;
    });
  }

  late final _$isLoadingAtom = Atom(
    name: '_PaywallVariantBStore.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: '_PaywallVariantBStore.errorMessage',
    context: context,
  );

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$purchaseSubscriptionAsyncAction = AsyncAction(
    '_PaywallVariantBStore.purchaseSubscription',
    context: context,
  );

  @override
  Future<void> purchaseSubscription() {
    return _$purchaseSubscriptionAsyncAction.run(
      () => super.purchaseSubscription(),
    );
  }

  late final _$restorePurchasesAsyncAction = AsyncAction(
    '_PaywallVariantBStore.restorePurchases',
    context: context,
  );

  @override
  Future<void> restorePurchases() {
    return _$restorePurchasesAsyncAction.run(() => super.restorePurchases());
  }

  late final _$_PaywallVariantBStoreActionController = ActionController(
    name: '_PaywallVariantBStore',
    context: context,
  );

  @override
  void selectOption(String option) {
    final _$actionInfo = _$_PaywallVariantBStoreActionController.startAction(
      name: '_PaywallVariantBStore.selectOption',
    );
    try {
      return super.selectOption(option);
    } finally {
      _$_PaywallVariantBStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedOption: ${selectedOption},
isLoading: ${isLoading},
errorMessage: ${errorMessage}
    ''';
  }
}
