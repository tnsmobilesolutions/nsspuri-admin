// ignore_for_file: avoid_print

import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';

class NetworkHelper {
  static final NetworkHelper _networkHelper = NetworkHelper._internal();
  DevoteeModel? currentDevotee;
  int dataCount = 10;
  DevoteeModel? get getCurrentDevotee {
    return currentDevotee;
  }

  set setCurrentDevotee(DevoteeModel currentdevotee) {
    currentDevotee = currentdevotee;
  }

  int? get dataCountPerPage {
    return dataCount;
  }

  set devoteeCountPerPage(int totalData) {
    dataCount = totalData;
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

