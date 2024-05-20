import 'package:currency_assessment/core/network/network_data.dart';

import 'package:currency_assessment/features/converter/domain/models/currency.dart';
import 'package:currency_assessment/features/converter/domain/models/exchange_rates.dart';
import 'package:currency_assessment/features/converter/domain/models/quota.dart';

import '../../../../core/depencency_injection/service_locator.dart';
import '../../domain/repositories/converter_repository.dart';
import '../data_sources/converter_remote_api_data_source.dart';
import 'package:dio/dio.dart';

class ConverterImpl implements ConverterRepository {
  ConverterDataSource remoteApiDataSource = sl<ConverterDataSource>();

  // ConverterImpl({this.remoteApiDataSource =  })

  @override
  Future<DataState<List<Currency>>> getCurrencies() async {
    try {
      var currencies = await remoteApiDataSource.getCurrencies();
      return DataSuccess(currencies
          .map((e) => Currency.fromJson(e.details!.toJson()))
          .toList());
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<List<ExchangeRate>>> getRates(
      {required String targetCurrency,
      required String destinationCurrency}) async {
    try {
      var rates = await remoteApiDataSource.getRates(
          targetCurrency: targetCurrency,
          destinationCurrency: destinationCurrency);
      return DataSuccess(
          rates.map((e) => ExchangeRate(code: e.code, rate: e.rate)).toList());
    } on DioException catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<Quota>> getQuota() async {
    try {
      var quota = await remoteApiDataSource.getQuota();
      return DataSuccess(Quota(
          remaining: quota.quotas?.month?.remaining,
          total: quota.quotas?.month?.total,
          used: quota.quotas?.month?.used));
    } on DioException catch (e) {
      return DataError(e);
    }
  }
}
