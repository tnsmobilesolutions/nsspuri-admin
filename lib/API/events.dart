import 'dart:convert';

import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/model/event_model.dart';

class EventsAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>> getSingleEvent(String eventAntendeeId) async {
    try {
      final response = await getAPI("eventAttendees/$eventAntendeeId");
      print("count in api - ${response["data"]}");
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>> getAllEvent(String eventId) async {
    try {
      final response = await getAPI("eventAttendees/$eventId");
      print("count in api - ${response["data"]}");
      return {"statusCode": 200, "data": response["data"]};
    } catch (e) {
      print(e);
      return {"statusCode": 500, "data": null};
    }
  }

  Future<Map<String, dynamic>> addEvent(EventModel event) async {
    var encodedata = jsonEncode(event.toMap());
    try {
      final response = await postAPI("eventAttendees/create", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....$e");
      return {"statusCode": 500, "error": e};
    }
  }

  Future<Map<String, dynamic>> updateEvent(
      EventModel event, String eventAntendeeId) async {
    var encodedata = jsonEncode(event.toMap());
    try {
      final response =
          await putAPI("eventAttendees/update/$eventAntendeeId", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....$e");
      return {"statusCode": 500, "error": e};
    }
  }

  Future<Map<String, dynamic>?> searchAttendees({
    String? eventId,
    String? searchBy,
    String? searchKeyword,
  }) async {
    try {
      final response = await getAPI(
          "eventAttendees/$eventId?searchBy=$searchBy&search=$searchKeyword");
      print('search attendees response: $response');
      // List<DevoteeModel> devotees = [];
      // final devoteelist = response["data"];
      // devoteelist.forEach((devotee) {
      //   devotees.add(DevoteeModel.fromMap(devotee));
      // });
      final count = response["data"]["count"];
      final totalPages = response["data"]["totalPages"];
      final currentPage = response["data"]["currentPage"];
      return {
        "statusCode": 200,
        "data": response["data"],
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
}
