import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:mpin_demo/features/set_mpin/data/models/mpin_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IMPinLocalDataSource {
  List<MpinModel> getMpinFromDB();
  void saveMpinToDB(MpinModel mpinModel);
}

class MPinLocalDataSource implements IMPinLocalDataSource {
  final SharedPreferences sharedPreferences;

  MPinLocalDataSource({required this.sharedPreferences});

  @override
  List<MpinModel> getMpinFromDB() {
    List<MpinModel> mpinList;
    List<String>? listString = sharedPreferences.getStringList('list');
    if (listString != null) {
      mpinList = listString
          .map((item) => MpinModel.fromJson(jsonDecode(item)))
          .toList();
      return mpinList;
    }
    return [];
  }

  @override
  void saveMpinToDB(MpinModel mpinModel) {
    List<MpinModel> mpinModelList = getMpinFromDB();
    mpinModelList.add(mpinModel);
    debugPrint('Data source Imp called..');
    List<String> mpinList = [];
    mpinList = mpinModelList.map((item) => jsonEncode(item)).toList();
    if (mpinList.length > 3) {
      mpinList.removeAt(0);
    }
    sharedPreferences.setStringList("list", mpinList);
  }
}
