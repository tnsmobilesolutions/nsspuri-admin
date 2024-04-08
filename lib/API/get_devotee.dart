// ignore_for_file: avoid_print

import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/model/sangha_model.dart';
import 'package:sdp/model/update_timing_model.dart';
import 'package:sdp/utilities/network_helper.dart';

class GetDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>> loginDevotee(String uid) async {
    try {
      final response = await loginAPI("login/$uid");
      await fetchCurrentuser();
      print(response);
      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>> prasadCountBySelectdate(String date) async {
    try {
      final response = await getAPI("prasadCountByselectdate?date=$date");
      // print("count in api - ${response["data"]}");
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> viewerDashboard() async {
    try {
      final response = await getAPI("prasadTakenCount");
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> currentDevotee() async {
    try {
      final response = await getAPI("devotee/currentUser");
      // print("response of currentuser -- $response");

      DevoteeModel devotee =
          DevoteeModel.fromMap(response["data"]["singleDevotee"][0]);
      return {"statusCode": 200, "data": devotee};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>> updateTiming() async {
    // Dio dio = Dio();

    try {
      final response = await getAPI("prasadTimingSetting");
      print("prasadTiming : $response");
      return response;
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
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

  Future<Map<String, dynamic>?> devoteeListBycreatedById(
    String createdById,
    int page,
    int limit, {
    bool? isAscending,
  }) async {
    try {
      Map<String, dynamic> response;
      if (isAscending == true) {
        response = await getAPI(
            "devoteeListBycreatedById/$createdById?page=$page&limit=$limit&name=ascending");
        print(
            "api end point (ascending): devoteeListBycreatedById/$createdById?page=$page&limit=$limit&name=ascending");
      } else if (isAscending == false) {
        response = await getAPI(
            "devoteeListBycreatedById/$createdById?page=$page&limit=$limit&name=descending");
        print(
            "api end point (descending): devoteeListBycreatedById/$createdById?page=$page&limit=$limit&name=descending");
      } else {
        response = await getAPI(
            "devoteeListBycreatedById/$createdById?page=$page&limit=$limit");
        print(
            "api end point (default): devoteeListBycreatedById/$createdById?page=$page&limit=$limit");
      }

      List<DevoteeModel> devotees = [];

      final devoteelist = response["data"]["devoteeList"];

      devoteelist.forEach((devotee) {
        devotees.add(DevoteeModel.fromMap(devotee));
      });

      final count = response["data"]["count"];
      final totalPages = response["data"]["totalPages"];
      final currentPage = response["data"]["page"];

      return {
        "statusCode": 200,
        "data": devotees,
        "count": count,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
    } catch (e) {
      print(e);
      return {
        "statusCode": 500,
        "data": null,
        "count": 0,
        "totalPages": 0,
        "currentPage": 1,
      };
    }
  }

  Future<Map<String, dynamic>?> allDevotee(int page, int limit,
      {bool? isAscending}) async {
    try {
      Map<String, dynamic> response;
      List<DevoteeModel> devotees = [];
      if (isAscending == true) {
        response =
            await getAPI("devotee?page=$page&limit=$limit&name=ascending");
      } else if (isAscending == false) {
        response =
            await getAPI("devotee?page=$page&limit=$limit&name=descending");
      } else {
        response = await getAPI("devotee?page=$page&limit=$limit");
      }
      final devoteelist = response["data"]["allDevotee"];
      final count = response["data"]["count"];
      final totalPages = response["data"]["totalPages"];
      final currentPage = response["data"]["page"];
      devoteelist.forEach((devotee) {
        devotees.add(DevoteeModel.fromMap(devotee));
      });

      return {
        "statusCode": 200,
        "data": devotees,
        "count": count,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
    } catch (e) {
      print(e);
      return {
        "statusCode": 500,
        "data": null,
        "count": 0,
        "totalPages": 0,
        "currentPage": 1,
      };
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
    String query,
    String searchBy,
    int page,
    int limit, {
    bool? isAscending,
  }) async {
    try {
      Map<String, dynamic> response;
      List<DevoteeModel> devotees = [];
      if (searchBy == "devoteeName") {
        response = await getAPI("devotee/search?devoteeName=$query");
      } else {
        if (isAscending == true) {
          response = await getAPI(
              "devotee/search?status=$query&page=$page&limit=$limit&name=ascending");
        } else if (isAscending == false) {
          response = await getAPI(
              "devotee/search?status=$query&page=$page&limit=$limit&name=descending");
        } else {
          response = await getAPI(
              "devotee/search?status=$query&page=$page&limit=$limit");
        }
      }
      final devoteelist = response["data"]["searchDevotee"];
      devoteelist.forEach((devotee) {
        devotees.add(DevoteeModel.fromMap(devotee));
      });
      final count = response["data"]["count"];
      final totalPages = response["data"]["totalPages"];
      final currentPage = response["data"]["page"];
      return {
        "statusCode": 200,
        "data": devotees,
        "count": count,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
    } catch (e) {
      print(e);
      return {
        "statusCode": 500,
        "data": null,
        "count": 0,
        "totalPages": 0,
        "currentPage": 1,
      };
    }
  }

  Future<Map<String, dynamic>> advanceSearchDevotee(
    String query,
    String searchBy,
    int page,
    int limit, {
    String? status,
    bool? isAscending,
  }) async {
    Future<String> customEncodeComponent(String query) async {
      return query.replaceAll('+', '%2B').replaceAll('-', '%2D');
    }

    try {
      List<DevoteeModel> devotees = [];
      String encodedQuery = await customEncodeComponent(query);
      final Map<String, dynamic> response;
      if (status == null) {
        if (isAscending == true) {
          response = await getAPI(
              "devotee/advance-search?$searchBy=$encodedQuery&page=$page&limit=$limit&nameOrder=ascending&eventId=1");
        } else if (isAscending == false) {
          response = await getAPI(
              "devotee/advance-search?$searchBy=$encodedQuery&page=$page&limit=$limit&nameOrder=descending");
        } else {
          response = await getAPI(
              "devotee/advance-search?$searchBy=$encodedQuery&page=$page&limit=$limit");
        }
      } else {
        if (isAscending == true) {
          response = await getAPI(
              "devotee/advance-search?$searchBy=$encodedQuery&advanceStatus=$status&page=$page&limit=$limit&nameOrder=ascending");
        } else if (isAscending == false) {
          response = await getAPI(
              "devotee/advance-search?$searchBy=$encodedQuery&advanceStatus=$status&page=$page&limit=$limit&nameOrder=descending");
        } else {
          response = await getAPI(
              "devotee/advance-search?$searchBy=$encodedQuery&advanceStatus=$status&page=$page&limit=$limit");
        }
      }

      final devoteelist = response["data"]["searchDevotee"];
      devoteelist.forEach((devotee) {
        devotees.add(DevoteeModel.fromMap(devotee));
      });
      final count = response["data"]["count"];
      final totalPages = response["data"]["totalPages"];
      final currentPage = response["data"]["page"];
      return {
        "statusCode": 200,
        "data": devotees,
        "count": count,
        "totalPages": totalPages,
        "currentPage": currentPage,
      };
    } catch (e) {
      print(e);
      return {
        "statusCode": 500,
        "data": null,
        "count": 0,
        "totalPages": 0,
        "currentPage": 1,
      };
    }
  }

  Future<Map<String, dynamic>?> fetchAllSangha() async {
    try {
      final response = await getSanghaAPI("sangha");
      print('888888$response');
      return {"statusCode": 200, "data": response["data"]["allSangha"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> viewCoupon(int couponCode) async {
    try {
      final response = await getAPI("viewCoupon/$couponCode");
      //print('888888$response');
      return response;
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>?> viewAllCoupon() async {
    try {
      final response = await getAPI("viewAllCoupon");
      return response;
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
