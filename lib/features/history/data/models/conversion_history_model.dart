class ConversionHistoryModel {
  int? timestamp;
  String? targetCurrency, destinationCurrency;
  double? rate, amount, amountReceived;

  ConversionHistoryModel(
      {this.timestamp,
      this.targetCurrency,
      this.destinationCurrency,
      this.rate,
      this.amount,
      this.amountReceived});

  ConversionHistoryModel.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    targetCurrency = json['targetCurrency'];
    destinationCurrency = json['destinationCurrency'];
    rate = json['rate'];
    amount = json['amount'];
    amountReceived = json['amountReceived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['targetCurrency'] = targetCurrency;
    data['destinationCurrency'] = destinationCurrency;
    data['rate'] = rate;
    data['amount'] = amount;
    data['amountReceived'] = amountReceived;

    return data;
  }
}
