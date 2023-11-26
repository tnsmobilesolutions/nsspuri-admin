import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>?> loginDevotee(String uid) async {
    try {
      final response = await loginAPI("login/$uid");
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

  Future<Map<String, dynamic>?> DevoteeDetailsById(String devoteeId) async {
    try {
      final response = await getAPI("devotee/$devoteeId");
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
      List<DevoteeModel> devotees = [];
      final response = await getAPI("devotee");
      final devoteelist = response["data"]["allDevotee"];
      devoteelist.forEach((devotee) {
        devotees.add(DevoteeModel.fromMap(devotee));
      });

      return {"statusCode": 200, "data": devotees};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> adminDashboard() async {
    try {
      final response = await getAPI("admin/dashboard");
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>> searchDevotee(
      String query, String searchBy) async {
    try {
      Map<String, dynamic> response;
      List<DevoteeModel> devotees = [];
      if (searchBy == "devoteeName") {
        response = await getAPI("devotee/search?devoteeName=$query");
      } else {
        response = await getAPI("devotee/search?status=$query");
      }
      final devoteelist = response["data"]["searchDevotee"];
      devoteelist.forEach((devotee) {
        devotees.add(DevoteeModel.fromMap(devotee));
      });

      return {"statusCode": 200, "data": devotees};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> devoteeWithRelatives() async {
    try {
      final response = await getAPI("devotee/relatives");
      print(response);
      return {"statusCode": 200, "data": response["data"]["singleDevotee"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }
}
