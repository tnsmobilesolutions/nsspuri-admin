import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/dashboard_card_model.dart';
import 'package:sdp/model/devotee_model.dart';

class DelegateStatusList {
  List<DashboardStatusModel> getAllSammilaniName() {
    var f = allStatusList.map((s) => s);
    return f.toList();
  }

  Future<List<DevoteeModel>> countdevotee(String url) async {
    List<DevoteeModel> alldevotee;
    if (url == "allDevotee") {
      final devoteesMap = await GetDevoteeAPI().allDevotee();
      alldevotee = devoteesMap?["data"];
      print(alldevotee);
      return alldevotee;
    } else {
      final devoteesMap = await GetDevoteeAPI().searchDevoteeByStatus(url);
      alldevotee = devoteesMap?["data"];
      print(alldevotee);
      return alldevotee;
    }
  }

  final allStatusList = [
    DashboardStatusModel(status: "Total Regesterd devotee", count: 100),
    DashboardStatusModel(status: "Total paid devotee", count: 20),
    DashboardStatusModel(status: "Total accepted devotee", count: 30),
    DashboardStatusModel(status: "Total rejected devotee", count: 40),
    DashboardStatusModel(status: "Total printed devotee", count: 50),
    DashboardStatusModel(status: "Total withdrawn devotee", count: 60),
    DashboardStatusModel(status: "Total lost devotee", count: 70),
    DashboardStatusModel(status: "Total reissued devotee", count: 80),
  ];
}
