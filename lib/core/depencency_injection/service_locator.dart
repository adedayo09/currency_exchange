import 'package:currency_assessment/features/converter/data/data_sources/converter_remote_api_data_source.dart';
import 'package:get_it/get_it.dart';

import '../../features/converter/data/repository/converter_implementation.dart';
import '../../features/converter/data/services/free_currency_api_service.dart';
import '../../features/converter/domain/repositories/converter_repository.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // sl.registerSingleton(GetCurrenciesUseCase(sl()));
  sl.registerSingleton<FreeCurrencyApiService>(FreeCurrencyApiService());

  sl.registerSingleton<ConverterDataSource>(ConverterRemoteApiDataSource());

  sl.registerSingleton<ConverterRepository>(ConverterImpl());
}
