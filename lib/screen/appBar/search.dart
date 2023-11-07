// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';

class SearchSDP extends StatefulWidget {
  SearchSDP(
      {Key? key,
      this.dashboardindexNumber,
      this.searchDasboardIndexNumber,
      required this.status,
      this.devoteeName})
      : super(key: key);

  int? searchDasboardIndexNumber = 0;
  int? dashboardindexNumber = 0;
  String status;
  String? devoteeName;

  @override
  State<SearchSDP> createState() => _SearchSDPState();
}

class _SearchSDPState extends State<SearchSDP> {
  List<String?> searchSangha = [];
  bool showAllNames = false;
  TextEditingController searchSanghaController = TextEditingController();
  final TextEditingController sdpSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 300,
              height: 45,
              child: TextFormField(
                controller: sdpSearchController,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: sdpSearchController.text.isNotEmpty
                            ? () async {
                                List<DevoteeModel> devoteeList = [];
                                await GetDevoteeAPI()
                                    .searchDevotee(
                                        sdpSearchController.text, "devoteeName")
                                    .then((value) {
                                  devoteeList.addAll(value?["data"]);
                                });
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return PaliaListPage(
                                      status: "allDevotee",
                                      pageFrom: "Search",
                                      searchValue: sdpSearchController.text,
                                    );
                                  },
                                ));
                              }
                            : null,
                        child: const Text('Search')),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Search Devotee",
                  fillColor: Colors.white,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
