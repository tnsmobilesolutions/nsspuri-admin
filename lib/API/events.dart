import 'dart:convert';

import 'package:sdp/API/dio_fuction.dart';
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
      final response = await putAPI("eventAttendees/update/$eventAntendeeId", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....$e");
      return {"statusCode": 500, "error": e};
    }
  }
}
