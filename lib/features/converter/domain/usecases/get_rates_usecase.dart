import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/core/usecase/usecase.dart';
import 'package:currency_assessment/features/converter/data/repository/converter_implementation.dart';
import 'package:currency_assessment/features/converter/domain/models/exchange_rates.dart';
import 'package:currency_assessment/features/converter/domain/repositories/converter_repository.dart';

class GetRatesParams {
  final String target, dest;

  GetRatesParams(this.target, this.dest);
}

class GetRatesUseCase
    implements UseCase<DataState<List<ExchangeRate>>, GetRatesParams> {
  final ConverterRepository _converterRepository = ConverterImpl();

  @override
  Future<DataState<List<ExchangeRate>>> call(
          {required GetRatesParams params}) =>
      _converterRepository.getRates(
          targetCurrency: params.target, destinationCurrency: params.dest);
}
