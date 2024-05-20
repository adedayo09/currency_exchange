// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/features/converter/data/data_sources/converter_remote_api_data_source.dart';
import 'package:currency_assessment/features/converter/data/models/free_currency_api_currency_model.dart';
import 'package:currency_assessment/features/converter/data/models/free_currency_api_quota_model.dart';
import 'package:currency_assessment/features/converter/data/models/free_currency_api_rate_model.dart';
import 'package:currency_assessment/features/converter/data/repository/converter_implementation.dart';
import 'package:currency_assessment/features/converter/domain/models/exchange_rates.dart';
import 'package:currency_assessment/features/converter/domain/models/quota.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

class MockConverterRemoteApiDataSource extends ConverterDataSource {
  @override
  Future<List<CurrencySymbolModel>> getCurrencies() async {
    //todo
    return [];
  }

  @override
  Future<QuotaModel> getQuota() async {
    return QuotaModel(
      accountId: 12345,
      quotas: Quotas(month: Month(total: 5000, used: 100, remaining: 4900)),
    );
  }

  @override
  Future<List<RateModel>> getRates(
      {required String targetCurrency,
      required String destinationCurrency}) async {
    return [RateModel(code: 'GBP', rate: 1), RateModel(code: 'USD', rate: 2)];
  }
}

void main() {
  group('test converter repository', () {
    test('test repo get quota', () async {
      // await initDependencies();
      MockConverterRemoteApiDataSource ds = MockConverterRemoteApiDataSource();

      if (!GetIt.instance.isRegistered<ConverterDataSource>()) {
        GetIt.instance.registerSingleton<ConverterDataSource>(ds);
      }
      ConverterImpl converterImpl = ConverterImpl();
      DataState<Quota> quota = await converterImpl.getQuota();
      expect(100, quota.data?.used);
    });

    test('test repo get rate', () async {
      // await initDependencies();
      MockConverterRemoteApiDataSource ds = MockConverterRemoteApiDataSource();
      if (!GetIt.instance.isRegistered<ConverterDataSource>()) {
        GetIt.instance.registerSingleton<ConverterDataSource>(ds);
      }
      ConverterImpl converterImpl = ConverterImpl();
      DataState<List<ExchangeRate>> exchangeList = await converterImpl.getRates(
          targetCurrency: "GBP", destinationCurrency: "EUR");
      ExchangeRate exchangeRateGBP = ExchangeRate(code: "GBP", rate: 1);
      expect(exchangeRateGBP, exchangeList.data?.first);
    });
  });
}
