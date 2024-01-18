// ignore_for_file: avoid_print

import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';

class NetworkHelper {
  static final NetworkHelper _networkHelper = NetworkHelper._internal();
  DevoteeModel? currentDevotee;
  DevoteeModel? get getCurrentDevotee {
    return currentDevotee;
  }

  set setCurrentDevotee(DevoteeModel currentdevotee) {
    currentDevotee = currentdevotee;
  }

  factory NetworkHelper() {
    return _networkHelper;
  }
  NetworkHelper._internal();
}

fetchCurrentuser() async {
  try {
    final currentDevoteedata = await GetDevoteeAPI().currentDevotee();
    NetworkHelper().setCurrentDevotee = currentDevoteedata?["data"];
  } catch (e) {
    print('fetching currentDevotee error : $e');
  }
}
