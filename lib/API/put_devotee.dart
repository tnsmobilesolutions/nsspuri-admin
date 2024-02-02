import 'dart:convert';

import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/model/update_timing_model.dart';

class PutDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>> updateDevotee(
      DevoteeModel devotee, String devoteeId) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(devotee.toMap());
    try {
      final response = await putAPI("devotee/$devoteeId", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }

  Future<Map<String, dynamic>> updateTiming(UpadateTimeModel time) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(time.toMap());
    try {
      final response = await putAPI("prasadTimingSetting", encodedata);
      print("timing Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }
}
