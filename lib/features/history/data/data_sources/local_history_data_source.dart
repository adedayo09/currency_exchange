import 'dart:convert';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../models/conversion_history_model.dart';
import 'package:localstore/localstore.dart';

abstract class HistoryDataSource {
  Future<void> saveConversionHistory(ConversionHistoryModel conversion);
  Future<List<ConversionHistoryModel>> getConversionHistory();
}

@GenerateNiceMocks([MockSpec<LocalHistoryDataSource>()])
class LocalHistoryDataSource implements HistoryDataSource {
  var db = Localstore.instance;

  @override
  Future<List<ConversionHistoryModel>> getConversionHistory() async {
    var history = await db.collection('conversions').get();
    List<ConversionHistoryModel> conversions = [];
    history?.values.forEach((element) {
      conversions.add(ConversionHistoryModel.fromJson(element));
    });
    conversions.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));
    return conversions.take(10).toList();
  }

  @override
  Future<void> saveConversionHistory(ConversionHistoryModel conversion) async {
    final id = db.collection('conversions').doc().id;
    await db.collection('conversions').doc(id).set(conversion.toJson());

    final data = await db.collection('conversions').doc(id).get();
  }
}
