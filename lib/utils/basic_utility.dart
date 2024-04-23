import 'dart:convert';

import 'package:mpin_demo/features/set_mpin/data/models/mpin_model.dart';
import 'package:mpin_demo/injector.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class BasicUtility {
  bool isMPinAlreadyExist(String mpin) {
    try {
      List<String>? mpinList = sl<SharedPreferences>().getStringList('list');
      if (mpinList != null) {
        List<MpinModel> mpinModels = mpinList
            .map((item) => MpinModel.fromJson(jsonDecode(item)))
            .toList();
        if (mpinModels.where((element) => element.pin == mpin).isNotEmpty) {
          return true;
        }
      }
    } catch (e) {
      return false;
    }
    return false;
  }
}
