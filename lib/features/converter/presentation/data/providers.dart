import 'package:flutter/cupertino.dart';

import '../../domain/models/currency.dart';

class ConversionAmountProvider extends ChangeNotifier {
  double? _amount;

  double? get amount => _amount;

  void setConversionAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  @override
  String toString() {
    return 'ConversionAmountProvider{_amount: $_amount}';
  }
}

class CurrencyConversionProvider extends ChangeNotifier {
  Currency? _targetCurrency;
  Currency? _destinationCurrency;

  Currency? get targetCurrency => _targetCurrency;
  Currency? get destinationCurrency => _destinationCurrency;

  void setTargetCurrency(Currency target) {
    _targetCurrency = target;
    notifyListeners();
  }

  void setDestinationCurrency(Currency destination) {
    _destinationCurrency = destination;
    notifyListeners();
  }

  @override
  String toString() {
    return 'CurrencyConversionProvider{_targetCurrency: $_targetCurrency, _destinationCurrency: $_destinationCurrency}';
  }
}
