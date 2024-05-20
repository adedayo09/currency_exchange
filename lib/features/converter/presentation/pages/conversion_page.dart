import 'package:currency_assessment/core/styles/styles.dart';
import 'package:currency_assessment/features/converter/presentation/pages/currencies_page.dart';
import 'package:currency_assessment/features/history/domain/usecases/save_history_usecase.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../history/domain/models/conversion.dart';
import '../../domain/models/currency.dart';
import '../../domain/usecases/get_rates_usecase.dart';
import '../data/providers.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/drawer.dart';

class ConversionPage extends StatefulWidget {
  const ConversionPage({super.key});

  @override
  State<ConversionPage> createState() => _ConversionPageState();
}

class _ConversionPageState extends State<ConversionPage> {
  final key = GlobalKey<FormState>();
  late TextEditingController targetController,
      destinationController,
      amountController;

  late GetRatesUseCase _getRatesUseCase;
  late SaveHistoryUseCase _saveHistoryUseCase;

  @override
  void initState() {
    targetController = TextEditingController();
    destinationController = TextEditingController();
    amountController = TextEditingController();
    _getRatesUseCase = GetRatesUseCase();
    _saveHistoryUseCase = SaveHistoryUseCase();
    super.initState();
  }

  var divider = const Divider(thickness: 2, color: Colors.grey);
  var spacer = const SizedBox(height: 15);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('CURRENCY APP'),
          centerTitle: true,
        ),
        drawer: const MyDrawer(),
        body: SafeArea(
          minimum: const EdgeInsets.all(18),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    divider,
                    spacer,
                    const Text('Target Currency', style: textStyle),
                    CustomTextfield(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textStyle: textStyle.copyWith(color: Colors.black),
                      hintText: 'Target currency',
                      controller: targetController,
                      validator: (val) => val!.isEmpty ? 'enter value' : null,
                      readOnly: true,
                      onTap: () async {
                        Currency? targetCurrency = await Navigator.of(context)
                            .push(MaterialPageRoute(
                                builder: (ctx) => CurrenciesPage()));

                        print(targetCurrency?.code);

                        targetController.text = targetCurrency!.code!;

                        Provider.of<CurrencyConversionProvider>(context,
                                listen: false)
                            .setTargetCurrency(targetCurrency);
                      },
                    ),
                    spacer,
                    const Text('Destination Currency', style: textStyle),
                    CustomTextfield(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textStyle: textStyle.copyWith(color: Colors.black),
                      hintText: 'Destination Currency',
                      validator: (val) => val!.isEmpty ? 'enter value' : null,
                      controller: destinationController,
                      readOnly: true,
                      onTap: () async {
                        Currency? destinationCurrency =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => CurrenciesPage()));

                        destinationController.text = destinationCurrency!.code!;

                        Provider.of<CurrencyConversionProvider>(context,
                                listen: false)
                            .setDestinationCurrency(destinationCurrency);
                      },
                    ),
                    spacer,
                    const Text('Amount', style: textStyle),
                    CustomTextfield(
                      keyboardType: TextInputType.number,
                      controller: amountController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textStyle: textStyle.copyWith(color: Colors.black),
                      hintText: 'Amount',
                      validator: (val) => val!.isEmpty ? 'enter value' : null,
                      onChanged: (val) {
                        Provider.of<ConversionAmountProvider>(context,
                                listen: false)
                            .setConversionAmount(double.parse(val));
                      },
                    ),
                    Consumer<CurrencyConversionProvider>(
                      builder: (BuildContext context,
                          CurrencyConversionProvider currencyConversionValue,
                          Widget? child) {
                        if (currencyConversionValue.targetCurrency == null ||
                            currencyConversionValue.destinationCurrency ==
                                null) {
                          return const SizedBox.shrink();
                        }
                        return FutureBuilder(
                            future: _getRatesUseCase(
                                params: GetRatesParams(
                                    currencyConversionValue
                                        .targetCurrency!.code!,
                                    currencyConversionValue
                                        .destinationCurrency!.code!)),
                            builder: (context, snapshot) {
                              if (snapshot.hasError || !snapshot.hasData) {
                                return const SizedBox.shrink();
                              }
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  Text(
                                      'Rate: ${snapshot.data!.data!.first.rate?.toStringAsFixed(5)}',
                                      style: textStyle),
                                  const SizedBox(height: 15),
                                  Consumer<ConversionAmountProvider>(
                                    builder: (context, conversionAmountValue,
                                        child) {
                                      if (conversionAmountValue.amount == null)
                                        return SizedBox.shrink();
                                      num a = conversionAmountValue.amount! *
                                          (snapshot.data!.data!.first.rate
                                              as num);
                                      return Text(
                                        'You will receive: ${currencyConversionValue.destinationCurrency?.symbol}${a.toStringAsFixed(2)}',
                                        style: textStyle,
                                      );
                                    },
                                  ),
                                  spacer,
                                  divider,
                                  spacer,
                                  MaterialButton(
                                    onPressed: () async {
                                      if (key.currentState!.validate()) {
                                        await _saveHistoryUseCase(
                                            params: Conversion(
                                          timestamp: DateTime.now()
                                              .millisecondsSinceEpoch,
                                          amount: double.tryParse(
                                              amountController.text),
                                          targetCurrency: targetController.text,
                                          destinationCurrency:
                                              destinationController.text,
                                          rate: double.parse(snapshot
                                              .data!.data!.first.rate!
                                              .toStringAsFixed(5)),
                                        ));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text('Saved successfully'),
                                          duration: Duration(seconds: 2),
                                          backgroundColor: Colors.green,
                                        ));
                                      }
                                    },
                                    shape: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(8)),
                                    color: Colors.green,
                                    minWidth: double.infinity,
                                    height: 60,
                                    child: Text(
                                      'SAVE',
                                      style: textStyle.copyWith(
                                          fontSize: 23, color: Colors.white),
                                    ),
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ]),
            ),
          ),
        ));
  }
}
