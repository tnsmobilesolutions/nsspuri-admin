

import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>?> loginDevotee(String uid) async {
    try {
      final response = await getAPI("login/$uid");
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> currentDevotee() async {
    try {
      final response = await getAPI("devotee/currentUser");
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
  Future<Map<String, dynamic>?> allDevotee() async {
    try {
      final response = await getAPI("devotee");
      print(response);
      return {"statusCode": 200, "data": response["data"]["allDevotee"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
  Future<Map<String, dynamic>?> searchDevotee(String devoteeName) async {
    try {
      final response = await getAPI("devotee/search?devoteeName=$devoteeName");
      print(response);
      return {"statusCode": 200, "data": response["data"]["searchDevotee"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
  Future<Map<String, dynamic>?> searchDevoteeByStatus(String status) async {
    try {
      final response = await getAPI("devotee/search?status=$status");
      print(response);
      return {"statusCode": 200, "data": response["data"]["searchDevotee"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
  Future<Map<String, dynamic>?> devoteeRelatives() async {
    try {
      final response = await getAPI("devotee/relatives");
      print(response);
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
}
