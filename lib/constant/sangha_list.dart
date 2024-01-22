import 'package:sdp/API/get_devotee.dart';

class SanghaList {
  Future<List<String>> getSuggestions(String query) async {
    List<String> matches = [];
    final sanghaList = await GetDevoteeAPI().getAllSangha();
    sanghaList?.forEach((element) {
      matches.add(element.sanghaName.toString());
    });
    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    print("match ________-------_______$matches");
    return matches;
  }
}
