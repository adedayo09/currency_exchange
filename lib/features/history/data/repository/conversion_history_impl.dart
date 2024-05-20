import 'package:currency_assessment/core/network/network_data.dart';
import 'package:currency_assessment/features/history/data/data_sources/local_history_data_source.dart';
import 'package:currency_assessment/features/history/data/models/conversion_history_model.dart';

import 'package:currency_assessment/features/history/domain/models/conversion.dart';

import '../../domain/repositories/history_repository.dart';

class HistoricalConversion implements HistoryRepository {
  final LocalHistoryDataSource _localHistoryDataSource =
      LocalHistoryDataSource();

  @override
  Future<DataState<List<Conversion>>> getConversionHistory() async {
    try {
      var conversions = await _localHistoryDataSource.getConversionHistory();
      print(conversions);
      return DataSuccess(
          conversions.map((e) => Conversion.fromJson(e.toJson())).toList());
    } on Exception catch (e) {
      return DataError(e);
    }
  }

  @override
  Future<DataState<void>> saveConversion(
      {required Conversion conversion}) async {
    try {
      _localHistoryDataSource.saveConversionHistory(
          ConversionHistoryModel.fromJson(conversion.toJson()));
      print("saving history");
      return DataSuccess(null);
    } on Exception catch (e) {
      print("error sabing $e");
      return DataError(e);
    }
  }
}
