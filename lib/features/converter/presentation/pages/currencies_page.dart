import 'package:flutter/material.dart';

import '../../domain/usecases/get_currencies_usecase.dart';

class CurrenciesPage extends StatelessWidget {
  CurrenciesPage({super.key});
  final _getCurrencyUseCase = GetCurrenciesUseCase();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select a currency'),
      ),
      body: FutureBuilder(
        future: _getCurrencyUseCase(),
        builder: (context, snapshot) {
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data?.error != null) {
            return SizedBox.shrink();
          }
          var data = snapshot.data?.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${data?[index].name}, ${data?[index].symbol}'),
                subtitle: Text('${data?[index].code}'),
                onTap: () {
                  Navigator.of(context).pop(data?[index]);
                },
              );
            },
            itemCount: snapshot.data?.data?.length ?? 0,
          );
        },
      ),
    );
  }
}
