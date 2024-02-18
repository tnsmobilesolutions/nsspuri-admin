// ignore_for_file: avoid_print

import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';

class NetworkHelper {
  static final NetworkHelper _networkHelper = NetworkHelper._internal();

  DevoteeModel? currentDevotee;
  bool isAscending = true;
  List<String> selectedDates = [];

  DevoteeModel? get getCurrentDevotee {
    return currentDevotee;
  }

  set setCurrentDevotee(DevoteeModel currentdevotee) {
    currentDevotee = currentdevotee;
  }

  set setNameAscending(bool isNameAscending) {
    isAscending = isNameAscending;
  }

  bool get getNameAscending {
    return isAscending;
  }

  set setSelectedPrasadDate(String date) {
    selectedDates.add(date);
  }

  List<String> get getSelectedPrasadDate {
    return selectedDates;
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
