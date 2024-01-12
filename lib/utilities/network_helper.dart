// ignore_for_file: avoid_print

import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';

class Networkhelper {
  static final Networkhelper _networkHelper = Networkhelper._internal();
  DevoteeModel? currentDevotee;
  DevoteeModel? get getCurrentDevotee {
    return currentDevotee;
  }

  set setCurrentDevotee(DevoteeModel currentdevotee) {
    currentDevotee = currentdevotee;
  }

  factory Networkhelper() {
    return _networkHelper;
  }
  Networkhelper._internal();
}

fetchCurrentuser() async {
  try {
    final currentDevoteedata = await GetDevoteeAPI().currentDevotee();
    Networkhelper().setCurrentDevotee = currentDevoteedata?["data"];
  } catch (e) {
    print('fetching currentDevotee error : $e');
  }
}
