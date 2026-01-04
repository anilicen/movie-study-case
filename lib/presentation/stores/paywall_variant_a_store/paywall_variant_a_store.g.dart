// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paywall_variant_a_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaywallVariantAStore on _PaywallVariantAStore, Store {
  late final _$isInitializedAtom = Atom(
    name: '_PaywallVariantAStore.isInitialized',
    context: context,
  );

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  late final _$isFreeTrialEnabledAtom = Atom(
    name: '_PaywallVariantAStore.isFreeTrialEnabled',
    context: context,
  );

  @override
  bool get isFreeTrialEnabled {
    _$isFreeTrialEnabledAtom.reportRead();
    return super.isFreeTrialEnabled;
  }

  @override
  set isFreeTrialEnabled(bool value) {
    _$isFreeTrialEnabledAtom.reportWrite(value, super.isFreeTrialEnabled, () {
      super.isFreeTrialEnabled = value;
    });
  }

  late final _$selectedOptionAtom = Atom(
    name: '_PaywallVariantAStore.selectedOption',
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

  late final _$_PaywallVariantAStoreActionController = ActionController(
    name: '_PaywallVariantAStore',
    context: context,
  );

  @override
  void init() {
    final _$actionInfo = _$_PaywallVariantAStoreActionController.startAction(
      name: '_PaywallVariantAStore.init',
    );
    try {
      return super.init();
    } finally {
      _$_PaywallVariantAStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFreeTrial(bool value) {
    final _$actionInfo = _$_PaywallVariantAStoreActionController.startAction(
      name: '_PaywallVariantAStore.toggleFreeTrial',
    );
    try {
      return super.toggleFreeTrial(value);
    } finally {
      _$_PaywallVariantAStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selectOption(String option) {
    final _$actionInfo = _$_PaywallVariantAStoreActionController.startAction(
      name: '_PaywallVariantAStore.selectOption',
    );
    try {
      return super.selectOption(option);
    } finally {
      _$_PaywallVariantAStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isInitialized: ${isInitialized},
isFreeTrialEnabled: ${isFreeTrialEnabled},
selectedOption: ${selectedOption}
    ''';
  }
}
