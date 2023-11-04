// ignore_for_file: use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';

import 'package:sdp/API/paliaaAPI.dart';
import 'package:sdp/sammilani_list.dart';
import 'package:sdp/sanghalist.dart';
import 'package:sdp/screen/searchResult/searchResultScreen.dart';

class SearchSDP extends StatefulWidget {
  SearchSDP({
    Key? key,
    this.dashboardindexNumber,
    this.searchDasboardIndexNumber,
    required this.onSubmitPress,
  }) : super(key: key);

  int? searchDasboardIndexNumber = 0;
  int? dashboardindexNumber = 0;
  final Function onSubmitPress;

  @override
  State<SearchSDP> createState() => _SearchSDPState();
}

class _SearchSDPState extends State<SearchSDP> {
  List<String?> searchSangha = [];
  bool showAllNames = false;
  TextEditingController searchSanghaController = TextEditingController();
  List<String> searchBy = [
    'Name',
    'Sangha',
    'Pali Date',
    'Sammilani Number',
    'Sammilani Year',
    'Sammilani Place',
    'Receipt Date',
    'Receipt Number',
  ];
  final TextEditingController sdpSearchController = TextEditingController();
  String _selectedSearchType = 'Name';
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0XFF3f51b5),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        DropdownButton(
                          style: const TextStyle(
                              color: Color(0XFF3f51b5), //Font color
                              fontSize: 16 //font size on dropdown button
                              ),
                          // focusColor: Colors.white,
                          hint: const Text('Search By'),

                          borderRadius: BorderRadius.circular(20),
                          value: _selectedSearchType,
                          onChanged: (value) {
                            if (value != "Sammilani Number" &&
                                value != "Sammilani Year" &&
                                value != "Sammilani Place") {
                              setState(() {
                                showAllNames = false;
                              });
                            }
                            setState(() {
                              _selectedSearchType = value.toString();
                            });
                          },
                          items: searchBy.map(
                            (val) {
                              return DropdownMenuItem(
                                value: val,
                                child: Text(val),
                              );
                            },
                          ).toList(),
                          iconEnabledColor: Colors.white,

                          iconDisabledColor: Colors.black,
                          iconSize: 40,
                          icon: const Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Color(0XFF3f51b5),
                          ),
                          underline: const Text(''),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  _selectedSearchType == 'Sangha'
                      ? SizedBox(
                          width: 200,
                          height: 50,
                          child: TypeAheadField(
                            textFieldConfiguration: TextFieldConfiguration(
                                onSubmitted: (value) async {
                                  final result = await PaliaAPI().searchSDP(
                                      _selectedSearchType,
                                      sdpSearchController.text,
                                      searchSanghaController.text);
                                  widget.onSubmitPress(
                                      result,
                                      _selectedSearchType,
                                      sdpSearchController.text);
                                },
                                controller: sdpSearchController,
                                decoration: InputDecoration(
                                  labelText: 'Search Sangha Names',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                )),
                            suggestionsCallback: (pattern) async {
                              final sanghaList =
                                  SanghaUtility.getAllSanghaName();
                              return sanghaList.where((element) => element!
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()));

                              // return await BackendService.getSuggestions(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                title: Text(suggestion.toString()),
                              );
                            },
                            getImmediateSuggestions: true,
                            hideOnEmpty: false,
                            noItemsFoundBuilder: (context) => const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('No Sangha Name Found'),
                            ),
                            onSuggestionSelected: (suggestion) {
                              sdpSearchController.text = suggestion.toString();
                            },
                          ),
                        )
                      : _selectedSearchType == 'Sammilani Number'
                          ? SizedBox(
                              width: 200,
                              height: 50,
                              child: TypeAheadField(
                                textFieldConfiguration: TextFieldConfiguration(
                                    controller: sdpSearchController,
                                    decoration: const InputDecoration(
                                        labelText: 'Search Sammilani Number',
                                        border: OutlineInputBorder()
                                        // OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(15.0),
                                        // ),
                                        )),
                                suggestionsCallback: (pattern) async {
                                  final sammilaniNumber =
                                      SammilaniUtility.getAllSammilaniName();
                                  return sammilaniNumber.where((element) =>
                                      element.sammilaniNumber!
                                          .contains(pattern.toLowerCase()));

                                  // return await BackendService.getSuggestions(pattern);
                                },
                                itemBuilder: (context, suggestion) {
                                  return ListTile(
                                    title: Text(
                                        suggestion.sammilaniNumber.toString()),
                                  );
                                },
                                getImmediateSuggestions: true,
                                hideOnEmpty: false,
                                noItemsFoundBuilder: (context) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('No Sammilani Number Found'),
                                ),
                                onSuggestionSelected: (value) {
                                  sdpSearchController.text =
                                      value.sammilaniNumber.toString();
                                },
                              ),
                            )
                          : _selectedSearchType == 'Sammilani Year'
                              ? SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: TypeAheadField(
                                    textFieldConfiguration:
                                        TextFieldConfiguration(
                                            controller: sdpSearchController,
                                            decoration: const InputDecoration(
                                                labelText: 'Add Sammilani Year',
                                                border: OutlineInputBorder()
                                                // OutlineInputBorder(
                                                //   borderRadius: BorderRadius.circular(15.0),
                                                // ),
                                                )),
                                    suggestionsCallback: (pattern) async {
                                      final sammilanimodelist = SammilaniUtility
                                          .getAllSammilaniName();
                                      return sammilanimodelist.where(
                                          (element) => element.sammilaniYear!
                                              .contains(pattern.toLowerCase()));

                                      // return await BackendService.getSuggestions(pattern);
                                    },
                                    itemBuilder: (context, suggestion) {
                                      return ListTile(
                                        title: Text(suggestion.sammilaniYear
                                            .toString()),
                                      );
                                    },
                                    getImmediateSuggestions: true,
                                    hideOnEmpty: false,
                                    noItemsFoundBuilder: (context) =>
                                        const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('No Sammilani Year Found'),
                                    ),
                                    onSuggestionSelected: (value) {
                                      sdpSearchController.text =
                                          value.sammilaniYear.toString();
                                    },
                                  ),
                                )
                              : _selectedSearchType == 'Sammilani Place'
                                  ? SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: TypeAheadField(
                                        textFieldConfiguration:
                                            TextFieldConfiguration(
                                                controller: sdpSearchController,
                                                decoration: const InputDecoration(
                                                    labelText:
                                                        'Add Sammilani Place',
                                                    border: OutlineInputBorder()
                                                    // OutlineInputBorder(
                                                    //   borderRadius: BorderRadius.circular(15.0),
                                                    // ),
                                                    )),
                                        suggestionsCallback: (pattern) async {
                                          final sammilaniNumber =
                                              SammilaniUtility
                                                  .getAllSammilaniName();
                                          return sammilaniNumber.where(
                                              (element) => element
                                                  .sammilaniPlace!
                                                  .toLowerCase()
                                                  .contains(
                                                      pattern.toLowerCase()));

                                          // return await BackendService.getSuggestions(pattern);
                                        },
                                        itemBuilder: (context, suggestion) {
                                          return ListTile(
                                            title: Text(suggestion
                                                .sammilaniPlace
                                                .toString()),
                                          );
                                        },
                                        getImmediateSuggestions: true,
                                        hideOnEmpty: false,
                                        noItemsFoundBuilder: (context) =>
                                            const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('No Sangha Name Found'),
                                        ),
                                        onSuggestionSelected: (value) {
                                          sdpSearchController.text =
                                              value.sammilaniPlace.toString();
                                        },
                                      ),
                                    )
                                  : SizedBox(
                                      width: 200,
                                      height: 50,
                                      child: TextFormField(
                                        onFieldSubmitted: (value) async {
                                          final result = await PaliaAPI()
                                              .searchSDP(
                                                  _selectedSearchType,
                                                  sdpSearchController.text,
                                                  searchSanghaController.text);
                                          widget.onSubmitPress(
                                              result,
                                              _selectedSearchType,
                                              sdpSearchController.text);
                                        },

                                        autofocus: false,
                                        controller: sdpSearchController,
                                        // keyboardType: TextInputType.datetime,
                                        // },

                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(15),
                                            // border: InputBorder.none,
                                            hintText: 'Search item',
                                            hintStyle: const TextStyle(
                                              color: Color(0XFF3f51b5),
                                            ),
                                            suffixIcon: _selectedSearchType ==
                                                    'Pali Date'
                                                ? IconButton(
                                                    onPressed: () async {
                                                      DateTime? selectedDate =
                                                          await showDatePicker(
                                                              context: context,
                                                              initialDate:
                                                                  DateTime.parse(
                                                                      '2024-02-01'),
                                                              firstDate:
                                                                  DateTime(
                                                                      1947),
                                                              lastDate:
                                                                  DateTime(
                                                                      2050));
                                                      if (selectedDate !=
                                                          null) {
                                                        setState(() {
                                                          sdpSearchController
                                                              .text = DateFormat(
                                                                  'dd-MMM-yyyy')
                                                              .format(
                                                                  selectedDate);
                                                        });
                                                      } else {
                                                        sdpSearchController
                                                            .text = '';
                                                      }
                                                    },
                                                    icon: const Icon(
                                                      Icons
                                                          .calendar_month_rounded,
                                                      color: Color(0XFF3f51b5),
                                                    ))
                                                : null),
                                        onTap: _selectedSearchType ==
                                                'Pali Date'
                                            ? () async {
                                                DateTime? selectedDate =
                                                    await showDatePicker(
                                                        context: context,
                                                        initialDate:
                                                            DateTime.now(),
                                                        firstDate:
                                                            DateTime(1947),
                                                        lastDate:
                                                            DateTime(2050));
                                                if (selectedDate != null) {
                                                  setState(() {
                                                    sdpSearchController
                                                        .text = DateFormat(
                                                            'dd-MMM-yyyy')
                                                        .format(selectedDate);
                                                  });
                                                } else {
                                                  sdpSearchController.text = '';
                                                }
                                              }
                                            : () {},
                                      ),
                                    ),
                ],
              ),
              if (_selectedSearchType == 'Sammilani Number' ||
                  _selectedSearchType == 'Sammilani Year' ||
                  _selectedSearchType == 'Sammilani Place')
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TypeAheadField(
                    textFieldConfiguration: TextFieldConfiguration(
                        controller: searchSanghaController,
                        decoration: InputDecoration(
                          labelText: 'Search Sangha Names',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        )),
                    suggestionsCallback: (pattern) async {
                      final sanghaList = SanghaUtility.getAllSanghaName();
                      return sanghaList.where((element) => element!
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));

                      // return await BackendService.getSuggestions(pattern);
                    },
                    itemBuilder: (context, suggestion) {
                      return ListTile(
                        title: Text(suggestion.toString()),
                      );
                    },
                    getImmediateSuggestions: true,
                    hideOnEmpty: false,
                    noItemsFoundBuilder: (context) => const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No Sangha Name Found'),
                    ),
                    onSuggestionSelected: (suggestion) {
                      searchSanghaController.text = suggestion.toString();
                    },
                  ),
                ),
              if (showAllNames == true)
                SizedBox(
                  height: 300,
                  width: 300,
                  child: ListView.builder(
                      itemCount: searchSangha.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: InkWell(
                            onTap: () {
                              setState(() {
                                searchSanghaController.text =
                                    (searchSangha[index]?.toLowerCase())
                                        .toString();
                              });
                            },
                            child: Text(
                              (searchSangha[index]).toString(),
                            ),
                          ),
                        );
                      }),
                )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: ElevatedButton(
              onPressed: () async {
                widget.searchDasboardIndexNumber = 0;
                widget.dashboardindexNumber = 0;
                final result = await PaliaAPI().searchSDP(_selectedSearchType,
                    sdpSearchController.text, searchSanghaController.text);
                widget.onSubmitPress(
                    result, _selectedSearchType, sdpSearchController.text);

                if (result != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SearchResultPage(searchReslt: result),
                      ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please put some Data to Search'),
                      action: SnackBarAction(
                        label: 'Exit',
                        onPressed: () {
                          // Code to execute.
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  );
                }
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
              ),
              child: const Text('Search'),
            ),
          )
        ],
      ),
    );
  }
}
