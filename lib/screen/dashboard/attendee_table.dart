import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sdp/constant/sangha_list.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/dashboard/attendee_list.dart';
import 'package:sdp/utilities/color_palette.dart';
import 'package:sdp/utilities/network_helper.dart';

class AttendeeTableScreen extends StatefulWidget {
  const AttendeeTableScreen({Key? key});

  @override
  State<AttendeeTableScreen> createState() => _AttendeeTableScreenState();
}

class _AttendeeTableScreenState extends State<AttendeeTableScreen> {
  String? _selectedSearchType;
  TextEditingController sdpSearchController = TextEditingController();
  String dataToShow = 'allData';
  String? searchByData;
  String? searchKeyWord;
  List<String> searchBy = [
    "name",
    "sangha",
    "emailId",
    "status",
    "devoteeCode",
    "mobileNumber",
    "bloodGroup"
  ];
  String? trackSearchType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Row(
          children: [
            Image.asset('assets/images/login.png',
                fit: BoxFit.cover, height: 60.00, width: 60.00),
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  width: 300,
                  child: Text(
                    'Sammilani Delegate',
                    style: TextStyle(color: Colors.white),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Text(
                    "${NetworkHelper().getCurrentDevotee?.name} (${NetworkHelper().getCurrentDevotee?.role})",
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    softWrap: true,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ],
        ),
        flexibleSpace: Padding(
          padding: const EdgeInsets.only(right: 50, top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton(
                      padding: EdgeInsets.only(left: 8),
                      style: const TextStyle(
                        color: Color.fromARGB(255, 3, 3, 3),
                        fontSize: 16,
                      ),
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
                                      : Colors.black,
                                ),
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
                    Expanded(
                      child: _selectedSearchType != "sangha"
                          ? TextFormField(
                              controller: sdpSearchController,
                              onFieldSubmitted: (value) {
                                setState(() {
                                  dataToShow = 'search';
                                  searchByData = _selectedSearchType;
                                  searchKeyWord = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: 'Search',
                                suffixIcon: IconButton(
                                  onPressed: () async {
                                    setState(() {
                                      dataToShow = 'search';
                                      searchByData = _selectedSearchType;
                                      searchKeyWord = sdpSearchController.text;
                                    });
                                  },
                                  icon: const Icon(Icons.search),
                                  iconSize: 21,
                                  color: Colors.deepOrange,
                                ),
                                border: InputBorder.none,
                                hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 100, 99, 99),
                                ),
                              ),
                            )
                          : TypeAheadFormField(
                              noItemsFoundBuilder: (_) => const SizedBox(
                                height: 70,
                                child: Center(child: Text('No Item Found')),
                              ),
                              suggestionsBoxDecoration:
                                  const SuggestionsBoxDecoration(
                                color: SuggestionBoxColor,
                                elevation: 5,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              debounceDuration:
                                  const Duration(milliseconds: 400),
                              onSaved: (sangha) {
                                sdpSearchController.text = sangha.toString();
                                setState(() {
                                  dataToShow = 'search';
                                  searchByData = _selectedSearchType;
                                  searchKeyWord = sangha;
                                });
                              },
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: sdpSearchController,
                                decoration: InputDecoration(
                                  labelText: "Sangha Name",
                                  focusColor: Colors.white,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                    borderSide: const BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                ),
                              ),
                              suggestionsCallback: (value) async {
                                List<String> sanghas = [];
                                if (value.isNotEmpty) {
                                  sanghas =
                                      await SanghaList().getSuggestions(value);
                                }
                                return sanghas;
                              },
                              itemBuilder: (_, String suggestion) {
                                return Row(
                                  children: [
                                    const SizedBox(width: 10, height: 50),
                                    Expanded(
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
                                  setState(() {
                                    sdpSearchController.text = sangha;
                                    dataToShow = 'search';
                                    searchByData = _selectedSearchType;
                                    searchKeyWord = sangha;
                                  });
                                }
                              },
                            ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              const GotoHomeButton(),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'List of Devotees Coming to Centenary Event',
                style: TextStyle(fontSize: 28),
              ),
              AttendeeListPage(
                dataToShow: dataToShow,
                searchBy: searchByData,
                searchKeyword: searchKeyWord,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
