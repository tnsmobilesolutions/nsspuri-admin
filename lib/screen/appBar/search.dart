// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';

class SearchDevotee extends StatefulWidget {
  SearchDevotee(
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
  State<SearchDevotee> createState() => _SearchDevoteeState();
}

class _SearchDevoteeState extends State<SearchDevotee> {
  String? _selectedSearchType;
  List<String> searchBy = [
    "name",
    "sangha",
    "emailId",
    "mobileNumber",
    "bloodGroup"
  ];
  List<String?> searchSangha = [];
  bool showAllNames = false;
  TextEditingController searchSanghaController = TextEditingController();
  final TextEditingController sdpSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white, // Set the border color here
              width: 2.0, // Set the border width here
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
            child: Row(
              children: [
                SizedBox(
                  width: 180,
                  height: 45,
                  child: DropdownButton(
                    style: const TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3), //Font color
                        fontSize: 16 //font size on dropdown button
                        ),
                    // focusColor: Colors.white,
                    hint: const Text(
                      'Search By',
                      style: TextStyle(color: Colors.white),
                    ),
                    borderRadius: BorderRadius.circular(20),
                    value: _selectedSearchType,
                    onChanged: (value) {
                      setState(() {
                        _selectedSearchType = value;
                      });
                    },
                    items: searchBy.map(
                      (val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              val,
                              style: TextStyle(
                                color: _selectedSearchType == val
                                    ? Colors.white
                                    : Color(0XFF3f51b5),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    iconEnabledColor: Colors.white,
                    iconDisabledColor: Colors.black,
                    iconSize: 40,
                    icon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Color.fromARGB(255, 254, 255, 255),
                    ),

                    underline: const Text(''),
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextFormField(
                    controller: sdpSearchController,
                    onChanged: (value) {
                      setState(() {});
                    },
                    onSaved: (newValue) {
                      sdpSearchController.text.isNotEmpty
                          ? () async {
                              List<DevoteeModel> devoteeList = [];
                              await GetDevoteeAPI()
                                  .searchDevotee(
                                      sdpSearchController.text, "devoteeName")
                                  .then((value) {
                                devoteeList.addAll(value["data"]);
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
                          : null;
                    },
                    onFieldSubmitted: (sdpSearchController.text.isNotEmpty &&
                            _selectedSearchType?.toLowerCase() != null)
                        ? (value) async {
                            List<DevoteeModel> devoteeList = [];
                            await GetDevoteeAPI()
                                .advanceSearchDevotee(
                              sdpSearchController.text,
                              _selectedSearchType.toString(),
                            )
                                .then((value) {
                              devoteeList.addAll(value["data"]);
                            });
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PaliaListPage(
                                  status: "allDevotee",
                                  pageFrom: "Search",
                                  searchValue: sdpSearchController.text,
                                  searchBy: _selectedSearchType,
                                );
                              },
                            ));
                          }
                        : null,
                    decoration: InputDecoration(
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.deepOrange, // Set the background color
                            ),
                            onPressed: (sdpSearchController.text.isNotEmpty &&
                                    _selectedSearchType?.toLowerCase() != null)
                                ? () async {
                                    List<DevoteeModel> devoteeList = [];
                                    await GetDevoteeAPI()
                                        .advanceSearchDevotee(
                                      sdpSearchController.text,
                                      _selectedSearchType.toString(),
                                    )
                                        .then((value) {
                                      devoteeList.addAll(value["data"]);
                                    });
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return PaliaListPage(
                                          status: "allDevotee",
                                          pageFrom: "Search",
                                          searchValue: sdpSearchController.text,
                                          searchBy: _selectedSearchType,
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
            ),
          ),
        )
      ],
    );
  }
}
