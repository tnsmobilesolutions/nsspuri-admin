import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/model/sangha_model.dart';

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
      print("response of currentuser -- $response");
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"][0]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> devoteeDetailsById(String devoteeId) async {
    try {
      final response = await getAPI("devoteeById/$devoteeId");
      // final decodeddevotee = json.decode(response["data"]["singleDevotee"]);
      // print("devotee in api - $decodeddevotee");
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"][0]);
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

  Future<Map<String, dynamic>> advanceSearchDevotee(
      String query, String searchBy) async {
    Future<String> customEncodeComponent(String query) async {
      return query.replaceAll('+', '%2B').replaceAll('-', '%2D');
    }

    try {
      List<DevoteeModel> devotees = [];
// Encoding the query string
      String encodedQuery = await customEncodeComponent(query);
      print("encodedQuery----- $encodedQuery");
      final response =
          await getAPI("devotee/advance-search?$searchBy=$encodedQuery");
      print("API URL = devotee/advance-search?$searchBy=$encodedQuery");
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

  Future<Map<String, dynamic>?> fetchAllSangha() async {
    try {
      final response = await getAPI("sangha");
      print('888888$response');
      return {"statusCode": 200, "data": response["data"]["allSangha"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<List<SanghaModel>?> getAllSangha() async {
    List<SanghaModel>? sanghas = [];
    // WRITE THE CODE HERE TO FETCH ALL SANGHA AND RETURN THE LIST
    Map<String, dynamic>? sanghaMap = await fetchAllSangha();
    SanghaModel sm;
    for (var sangha in sanghaMap?['data']) {
      sm = SanghaModel.fromMap(sangha);
      sanghas.add(sm);
    }

    return sanghas;
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
