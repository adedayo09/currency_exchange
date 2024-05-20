import 'package:currency_assessment/features/history/domain/usecases/get_history_usecase.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key}) : _getHistoryUseCase = GetHistoryUseCase();

  final GetHistoryUseCase _getHistoryUseCase;

  String formatDate(int timestamp) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _getHistoryUseCase(),
        builder: (context, snapshot) {
          if (snapshot.hasError || !snapshot.hasData) {
            return const SizedBox.shrink();
          }
          var history = snapshot.data!.data!;
          return history.isEmpty
              ? const Center(child: Text('No history found'))
              : ListView.builder(
                  itemCount: history.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListTile(
                        tileColor: Colors.grey[200],
                        leading: const Icon(Icons.history),
                        title: Text(
                            '${history[index].targetCurrency} to ${history[index].destinationCurrency}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${history[index].amount} ${history[index].targetCurrency} = ${history[index].rate} ${history[index].destinationCurrency}',
                                style: const TextStyle(fontSize: 16)),
                            Text('Rate: ${history[index].rate}'),
                            Text(
                                'Date: ${formatDate(history[index].timestamp!)}'),
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
