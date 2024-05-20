import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  String? symbol;
  String? name;
  String? symbolNative;
  int? decimalDigits;
  int? rounding;
  String? code;
  String? namePlural;

  Currency(
      {this.symbol,
      this.name,
      this.symbolNative,
      this.decimalDigits,
      this.rounding,
      this.code,
      this.namePlural});

  Currency.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    symbolNative = json['symbol_native'];
    decimalDigits = json['decimal_digits'];
    rounding = json['rounding'];
    code = json['code'];
    namePlural = json['name_plural'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['symbol_native'] = symbolNative;
    data['decimal_digits'] = decimalDigits;
    data['rounding'] = rounding;
    data['code'] = code;
    data['name_plural'] = namePlural;
    return data;
  }

  @override
  List<Object?> get props =>
      [symbol, name, namePlural, code, decimalDigits, symbolNative];
}
