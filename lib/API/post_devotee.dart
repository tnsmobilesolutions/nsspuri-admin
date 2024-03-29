import 'dart:convert';

import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/devotee_model.dart';

class PostDevoteeAPI extends DioFuctionAPI {
  Future<Map<String, dynamic>> signupDevotee(DevoteeModel devotee) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(devotee.toMap());
    print(encodedata);
    try {
      final response = await signupAPI("devotee", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }
  Future<Map<String, dynamic>> addRelativeDevotee(DevoteeModel devotee) async {
    // Dio dio = Dio();
    var encodedata = jsonEncode(devotee.toMap());
    try {
      final response = await postAPI("devotee/relative", encodedata);
      print("devotee Encooded Data - $encodedata");
      return response;
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }
}
