// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:sdp/API/dio_fuction.dart';
import 'package:sdp/model/coupon_model.dart';
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

  Future<Map<String, dynamic>> createCoupon(
      List<CouponModel> coupon, int couponCode) async {
    var data = {
      "couponDevotee": true,
      "couponCode": couponCode,
      "couponPrasad": coupon.map((coupon) => coupon.toMap()).toList(),
    };
    var encodedData = jsonEncode(data);
    try {
      // Map<String, dynamic> response = {};
      final response = await putAPI("createCoupon", encodedData);
      print("coupon encooded data - $encodedData");
      return response;
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }
}
