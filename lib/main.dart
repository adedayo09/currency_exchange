import 'package:currency_assessment/features/converter/presentation/pages/conversion_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/depencency_injection/service_locator.dart';
import 'features/converter/presentation/data/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrencyConversionProvider>(
            create: (context) => CurrencyConversionProvider()),
        ChangeNotifierProvider<ConversionAmountProvider>(
            create: (context) => ConversionAmountProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ConversionPage()),
    );
  }
}
