class CurrencySymbolModel {
  String? label;
  CurrencySymbolModelData? details;

  CurrencySymbolModel({this.label, this.details});

  factory CurrencySymbolModel.fromJson(Map<String, dynamic> json) {
    return CurrencySymbolModel(
      label: json['label'],
      details: json['details'] != null
          ? CurrencySymbolModelData.fromJson(json['details'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class CurrencySymbolModelData {
  String? symbol;
  String? name;
  String? symbolNative;
  int? decimalDigits;
  int? rounding;
  String? code;
  String? namePlural;

  CurrencySymbolModelData(
      {this.symbol,
      this.name,
      this.symbolNative,
      this.decimalDigits,
      this.rounding,
      this.code,
      this.namePlural});

  CurrencySymbolModelData.fromJson(Map<String, dynamic> json) {
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
}
