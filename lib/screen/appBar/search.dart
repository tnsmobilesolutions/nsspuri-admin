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
      this.searchBy,
      this.searchValue,
      this.onFieldValueChanged,
      required this.status,
      this.devoteeName})
      : super(key: key);

  int? searchDasboardIndexNumber = 0;
  int? dashboardindexNumber = 0;
  String status;
  String? devoteeName;
  String? searchValue;
  String? searchBy;
  void Function(bool isResultEmpty)? onFieldValueChanged;

  @override
  State<SearchDevotee> createState() => _SearchDevoteeState();
}

class _SearchDevoteeState extends State<SearchDevotee> {
  String? _selectedSearchType;
  List<String> searchBy = [
    "name",
    "sangha",
    "emailId",
    "status",
    "devotee code",
    "mobileNumber",
    "bloodGroup"
  ];
  List<String?> searchSangha = [];
  bool showAllNames = false;
  TextEditingController searchSanghaController = TextEditingController();
  final TextEditingController sdpSearchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _selectedSearchType = widget.searchBy ?? "name";
    sdpSearchController.text = widget.searchValue ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: Row(
          children: [
            DropdownButton(
              style: const TextStyle(
                  color: Color.fromARGB(255, 3, 3, 3), //Font color
                  fontSize: 16 //font size on dropdown button
                  ),
              // focusColor: Colors.white,
              hint: const Text(
                'Search by',
                style: TextStyle(color: Colors.black),
              ),
              borderRadius: BorderRadius.circular(12),
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
                                ? Colors.black
                                : Colors.black),
                      ),
                    ),
                  );
                },
              ).toList(),
              iconEnabledColor: Colors.black,
              iconDisabledColor: Colors.black,
              iconSize: 30,
              icon: const Icon(Icons.arrow_drop_down_outlined,
                  color: Colors.deepOrange),

              underline: const Text(''),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: VerticalDivider(
                thickness: 2,
                color: Color.fromARGB(184, 255, 147, 114),
              ),
            ),
            SizedBox(
              width: 300,
              height: 45,
              child: Padding(
                padding: const EdgeInsets.only(top: 2, bottom: 4),
                child: TextFormField(
                  controller: sdpSearchController,
                  onChanged: (value) {
                    setState(() {
                      // value.isNotEmpty
                      //     ? widget.onFieldValueChanged!(value)
                      //     : null;
                    });
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
                          widget.onFieldValueChanged!(devoteeList.isNotEmpty);
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return PaliaListPage(
                                status: "allDevotee",
                                pageFrom: "Search",
                                searchValue: sdpSearchController.text,
                                searchBy: _selectedSearchType,
                                isResultEmpty: devoteeList.isNotEmpty,
                              );
                            },
                          ));
                        }
                      : null,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 4, top: 2),
                      child: IconButton(
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
                        icon: const Icon(Icons.search),
                        iconSize: 21,
                        autofocus: true,
                        color: Colors.deepOrange,
                      ),
                    ),
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 100, 99, 99),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
