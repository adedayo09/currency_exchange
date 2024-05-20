import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/core/usecase/usecase.dart';
import 'package:currency_assessment/features/history/domain/models/conversion.dart';
import 'package:currency_assessment/features/history/domain/repositories/history_repository.dart';

import '../../data/repository/conversion_history_impl.dart';

class SaveHistoryUseCase implements UseCase<DataState<void>, Conversion> {
  final HistoryRepository _historyRepository = HistoricalConversion();

  @override
  Future<DataState<void>> call({required Conversion params}) =>
      _historyRepository.saveConversion(conversion: params);
}
