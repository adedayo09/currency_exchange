import 'dart:convert';
import 'package:currency_assessment/core/constants/constants.dart';
import 'package:currency_assessment/features/converter/data/models/free_currency_api_rate_model.dart';
import 'package:dio/dio.dart';

import '../models/free_currency_api_currency_model.dart';
import '../models/free_currency_api_quota_model.dart';

class FreeCurrencyApiService {
  final dio = Dio();
  final baseUrl = 'https://api.freecurrencyapi.com/v1';

  Future<List<RateModel>> getRates(
      {required String targetCurrency,
      required String destinationCurrency}) async {
    final response = await dio.get(
        '$baseUrl/latest?apikey=$FREE_CURRENCY_API_KEY&base_currency=$targetCurrency&currencies=$destinationCurrency');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data['data'];
      List<RateModel> rates = [];
      data.forEach((key, value) {
        rates.add(RateModel(code: key, rate: value));
      });
      return rates;
    } else {
      throw Exception('Unable to get rates data');
    }
  }

  Future<List<CurrencySymbolModel>> getCurrencies() async {
    final response =
        await dio.get('$baseUrl/currencies?apikey=$FREE_CURRENCY_API_KEY');
    if (response.statusCode == 200) {
      Map<String, dynamic> data = response.data['data'];
      List<CurrencySymbolModel> currencies = [];
      data.forEach((key, value) {
        currencies.add(CurrencySymbolModel(
          label: key,
          details: CurrencySymbolModelData.fromJson(value),
        ));
      });
      return currencies;
    } else {
      throw Exception('Unable to get currency data');
    }
  }

  Future<QuotaModel> getQuota() async {
    final response =
        await dio.get('$baseUrl/status?apikey=$FREE_CURRENCY_API_KEY');
    if (response.statusCode == 200) {
      final json = response.data;
      QuotaModel quota = QuotaModel.fromJson(json);
      return quota;
    } else {
      throw Exception('Unable to get quota data');
    }
  }
}
