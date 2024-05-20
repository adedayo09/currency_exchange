import 'package:currency_assessment/features/converter/data/models/free_currency_api_currency_model.dart';
import 'package:currency_assessment/features/converter/data/models/free_currency_api_rate_model.dart';

import '../../../../core/depencency_injection/service_locator.dart';
import '../models/free_currency_api_quota_model.dart';
import '../services/free_currency_api_service.dart';

abstract class ConverterDataSource {
  Future<List<CurrencySymbolModel>> getCurrencies();

  Future<List<RateModel>> getRates(
      {required String targetCurrency, required String destinationCurrency});

  Future<QuotaModel> getQuota();
}

class ConverterRemoteApiDataSource implements ConverterDataSource {
  final FreeCurrencyApiService _currencyApiService =
      sl<FreeCurrencyApiService>();

  ConverterRemoteApiDataSource();

  @override
  Future<List<CurrencySymbolModel>> getCurrencies() =>
      _currencyApiService.getCurrencies();

  @override
  Future<List<RateModel>> getRates(
          {required String targetCurrency,
          required String destinationCurrency}) =>
      _currencyApiService.getRates(
          targetCurrency: targetCurrency,
          destinationCurrency: destinationCurrency);

  @override
  Future<QuotaModel> getQuota() => _currencyApiService.getQuota();
}
