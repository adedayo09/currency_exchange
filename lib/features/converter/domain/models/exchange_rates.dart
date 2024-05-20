import 'package:equatable/equatable.dart';

class ExchangeRate extends Equatable {
  String? code;
  double? rate;

  ExchangeRate({required this.code, required this.rate});

  ExchangeRate.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['rate'] = rate;
    return data;
  }

  @override
  List<Object?> get props => [code, rate];
}
