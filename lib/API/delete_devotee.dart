import 'package:sdp/API/dio_fuction.dart';

class DeleteDevoteeAPI extends DioFuctionAPI {
   deleteSingleDevotee( String devoteeId) async {
    // Dio dio = Dio();
    try {
    await deleteAPI("devotee/$devoteeId");
    } catch (e) {
      print("Post Error....");
      print(e);
      return {"statusCode": 500, "error": e};
    }
  }

}