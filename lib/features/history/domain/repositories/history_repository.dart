import '../../../../core/network/network_data.dart';
import '../models/conversion.dart';

abstract class HistoryRepository {
  Future<DataState<List<Conversion>>> getConversionHistory();
  Future<DataState<void>> saveConversion({required Conversion conversion});
}
