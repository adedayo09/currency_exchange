import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/core/usecase/usecase.dart';
import 'package:currency_assessment/features/converter/data/repository/converter_implementation.dart';
import 'package:currency_assessment/features/converter/domain/models/quota.dart';
import 'package:currency_assessment/features/converter/domain/repositories/converter_repository.dart';

class GetQuotaUseCase implements UseCase<DataState<Quota>, void> {
  final ConverterRepository _converterRepository = ConverterImpl();

  @override
  Future<DataState<Quota>> call({void params}) =>
      _converterRepository.getQuota();
}
