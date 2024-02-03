// ignore_for_file: avoid_print

import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';

class NetworkHelper {
  static final NetworkHelper _networkHelper = NetworkHelper._internal();
  DevoteeModel? currentDevotee;
  bool? isAscending;
  DevoteeModel? get getCurrentDevotee {
    return currentDevotee;
  }

  set setCurrentDevotee(DevoteeModel currentdevotee) {
    currentDevotee = currentdevotee;
  }

  bool? get ascending {
    return isAscending;
  }

  set setAscending(bool isOrderAscending) {
    isAscending = isOrderAscending;
  }

  factory NetworkHelper() {
    return _networkHelper;
  }
  NetworkHelper._internal();
}

fetchCurrentuser() async {
  try {
    Map<String, dynamic>? currentDevoteedata =
        await GetDevoteeAPI().currentDevotee();
    NetworkHelper().setCurrentDevotee = currentDevoteedata?["data"];
  } catch (e) {
    print('fetching currentDevotee error : $e');
  }
}
// Future<void> setCurrentUser(DevoteeModel devotee) async {
//   try {
//     NetworkHelper().setCurrentDevotee = devotee; 
    
//   } catch (e) {
//     print('fetching currentDevotee error : $e');
//   }
// }

