import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/core/usecase/usecase.dart';
import 'package:currency_assessment/features/converter/data/repository/converter_implementation.dart';
import 'package:currency_assessment/features/converter/domain/repositories/converter_repository.dart';

import '../models/currency.dart';

class GetCurrenciesUseCase implements UseCase<DataState<List<Currency>>, void> {
  final ConverterRepository _converterRepository = ConverterImpl();

  @override
  Future<DataState<List<Currency>>> call({void params}) =>
      _converterRepository.getCurrencies();
}
