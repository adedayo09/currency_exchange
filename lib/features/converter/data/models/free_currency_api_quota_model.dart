class QuotaModel {
  int? accountId;
  Quotas? quotas;

  QuotaModel({this.accountId, this.quotas});

  QuotaModel.fromJson(Map<String, dynamic> json) {
    accountId = json['account_id'];
    quotas = json['quotas'] != null ? Quotas.fromJson(json['quotas']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_id'] = accountId;
    if (quotas != null) {
      data['quotas'] = quotas!.toJson();
    }
    return data;
  }
}

class Quotas {
  Month? month;
  Month? grace;

  Quotas({this.month, this.grace});

  Quotas.fromJson(Map<String, dynamic> json) {
    month = json['month'] != null ? Month.fromJson(json['month']) : null;
    grace = json['grace'] != null ? Month.fromJson(json['grace']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (month != null) {
      data['month'] = month!.toJson();
    }
    if (grace != null) {
      data['grace'] = grace!.toJson();
    }
    return data;
  }
}

class Month {
  int? total;
  int? used;
  int? remaining;

  Month({this.total, this.used, this.remaining});

  Month.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    used = json['used'];
    remaining = json['remaining'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['used'] = used;
    data['remaining'] = remaining;
    return data;
  }
}
