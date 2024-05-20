import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/core/usecase/usecase.dart';
import 'package:currency_assessment/features/history/domain/models/conversion.dart';
import 'package:currency_assessment/features/history/domain/repositories/history_repository.dart';

import '../../data/repository/conversion_history_impl.dart';

class GetHistoryUseCase implements UseCase<DataState<List<Conversion>>, void> {
  final HistoryRepository _historyRepository = HistoricalConversion();

  @override
  Future<DataState<List<Conversion>>> call({void params}) =>
      _historyRepository.getConversionHistory();
}
