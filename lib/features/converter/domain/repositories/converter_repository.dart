import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/features/converter/data/models/free_currency_api_rate_model.dart';
import 'package:currency_assessment/features/converter/domain/models/exchange_rates.dart';

import '../models/currency.dart';
import '../models/quota.dart';

abstract class ConverterRepository {
  Future<DataState<List<Currency>>> getCurrencies();
  Future<DataState<List<ExchangeRate>>> getRates(
      {required String targetCurrency, required String destinationCurrency});
  Future<DataState<Quota>> getQuota();
}
