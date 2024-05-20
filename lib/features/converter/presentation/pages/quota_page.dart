import 'package:currency_assessment/core/styles/styles.dart';
import 'package:currency_assessment/features/converter/domain/usecases/get_quota_usecase.dart';
import 'package:flutter/material.dart';

import '../../data/models/free_currency_api_quota_model.dart';

class QuotaPage extends StatelessWidget {
  QuotaPage({super.key}) : _getQuotaUseCase = GetQuotaUseCase();

  final GetQuotaUseCase _getQuotaUseCase;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quota'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _getQuotaUseCase(),
          builder: (context, snapshot) {
            if (snapshot.hasError ||
                !snapshot.hasData ||
                snapshot.data?.error != null) return const SizedBox.shrink();
            var quota = snapshot.data?.data;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Total: ${quota?.total ?? '0'}',
                      style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text('Used: ${quota?.used ?? '0'}',
                      style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                  Text('Remaining: ${quota?.remaining ?? '0'}',
                      style: textStyle.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            );
          }),
    );
  }
}
