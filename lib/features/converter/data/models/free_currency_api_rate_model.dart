class RateModel {
  final String code;
  final double rate;

  RateModel({required this.code, required this.rate});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['rate'] = rate;
    return data;
  }
}
