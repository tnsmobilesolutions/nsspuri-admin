// ignore_for_file: use_build_context_synchronously, must_be_immutable, avoid_print
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/constant/sangha_list.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/utilities/color_palette.dart';

class SearchDevotee extends StatefulWidget {
  SearchDevotee(
      {Key? key,
      this.dashboardindexNumber,
      this.searchDasboardIndexNumber,
      this.searchBy,
      this.searchValue,
      this.onFieldValueChanged,
      this.searchStatus,
      this.devoteeList,
      required this.status,
      this.devoteeName})
      : super(key: key);

  int? searchDasboardIndexNumber = 0;
  int? dashboardindexNumber = 0;
  String status;
  String? devoteeName;
  String? searchStatus;
  String? searchValue;
  String? searchBy;
  List<DevoteeModel>? devoteeList;
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
    "devoteeCode",
    "mobileNumber",
    "bloodGroup"
  ];
  List<String?> searchSangha = [];
  bool showClearButton = false;
  String? trackSearchType;
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
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
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
                if (_selectedSearchType != value) {
                  sdpSearchController.clear();
                }
                _selectedSearchType = trackSearchType = value;
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
            width: Responsive.isMobile(context) ? 180 : 250,
            child: _selectedSearchType != "sangha"
                ? TextFormField(
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
                                  return DevoteeListPage(
                                    status: "allDevotee",
                                    pageFrom: "Search",
                                    devoteeList: devoteeList,
                                    searchValue: sdpSearchController.text,
                                    showClearButton: devoteeList.isNotEmpty,
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
                            setState(() {
                              showClearButton = !showClearButton;
                            });
                            widget.onFieldValueChanged!(devoteeList.isNotEmpty);
                            print(
                                "search devotee count: ${devoteeList.length}");
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DevoteeListPage(
                                  status: "allDevotee",
                                  pageFrom: "Search",
                                  devoteeList: devoteeList,
                                  searchValue: sdpSearchController.text,
                                  searchBy: _selectedSearchType,
                                  showClearButton:
                                      showClearButton, // devoteeList.isNotEmpty,
                                );
                              },
                            ));
                          }
                        : null,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      suffixIcon: IconButton(
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
                                    return DevoteeListPage(
                                      status: "allDevotee",
                                      pageFrom: "Search",
                                      devoteeList: devoteeList,
                                      searchValue: sdpSearchController.text,
                                      searchBy: _selectedSearchType,
                                      showClearButton: devoteeList.isNotEmpty,
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
                      border: InputBorder.none,
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 100, 99, 99),
                      ),
                    ),
                  )
                : TypeAheadFormField(
                    noItemsFoundBuilder: (context) => const SizedBox(
                      height: 70,
                      child: Center(
                        child: Text('No Item Found'),
                      ),
                    ),
                    suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                        color: SuggestionBoxColor,
                        elevation: 5,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        )),
                    debounceDuration: const Duration(milliseconds: 400),
                    onSaved: (sangha) {
                      sdpSearchController.text = sangha.toString();
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      controller: sdpSearchController,
                      decoration: InputDecoration(
                        labelText: "Sangha Name",
                        focusColor: Colors.white,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 0, style: BorderStyle.none)),
                      ),
                    ),
                    suggestionsCallback: (value) async {
                      List<String> sanghas = [];
                      if (value.isNotEmpty) {
                        sanghas = await SanghaList().getSuggestions(value);
                      }
                      return sanghas;
                    },
                    itemBuilder: (context, String suggestion) {
                      return Row(
                        children: [
                          const SizedBox(
                            width: 10,
                            height: 50,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                suggestion,
                                maxLines: 6,
                              ),
                            ),
                          )
                        ],
                      );
                    },
                    onSuggestionSelected: (String sangha) async {
                      if (sangha.isNotEmpty) {
                        List<DevoteeModel> devoteeList = [];
                        await GetDevoteeAPI()
                            .advanceSearchDevotee(
                          sangha,
                          _selectedSearchType.toString(),
                        )
                            .then((value) {
                          devoteeList.addAll(value["data"]);
                        });
                        setState(() {
                          showClearButton = !showClearButton;
                        });
                        widget.onFieldValueChanged!(devoteeList.isNotEmpty);
                        print("search devotee count: ${devoteeList.length}");
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DevoteeListPage(
                              status: "allDevotee",
                              pageFrom: "Search",
                              devoteeList: devoteeList,
                              searchValue: sangha,
                              searchBy: _selectedSearchType,
                              showClearButton:
                                  showClearButton, // devoteeList.isNotEmpty,
                            );
                          },
                        ));
                        setState(() {
                          sdpSearchController.text = sangha;
                        });
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
