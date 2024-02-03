// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/constant/pagination_value.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/appBar/search.dart';
import 'package:sdp/utilities/network_helper.dart';

class ResponsiveAppbarActionButtonWidget extends StatefulWidget {
  ResponsiveAppbarActionButtonWidget({
    super.key,
    this.searchBy,
    this.searchValue,
    this.advanceStatus,
    this.showClearButton,
  });

  String? advanceStatus;
  String? searchBy;
  String? searchValue;
  bool? showClearButton;

  @override
  State<ResponsiveAppbarActionButtonWidget> createState() =>
      _ResponsiveAppbarActionButtonWidgetState();
}

class _ResponsiveAppbarActionButtonWidgetState
    extends State<ResponsiveAppbarActionButtonWidget> {
  bool dataSubmitted = false,
      paid = false,
      rejected = false,
      approved = false,
      printed = false,
      withdrawn = false,
      lost = false,
      reissued = false,
      blackListed = false;

  List<DevoteeModel> devoteeList = [];
  String? selectedStatus;
  List<String> statusOptions = [
    'dataSubmitted',
    'paid',
    'rejected',
    'approved',
    'printed',
    'withdrawn',
    'lost',
    'reissued',
    "blacklisted"
  ];

  String? userRole;
  int totalPages = 0, dataCount = 0, currentPage = 1;
  late int dataCountPerPage;

  @override
  void initState() {
    super.initState();
    dataCountPerPage = RemoteConfigHelper().getDataCountPerPage;
    setState(() {
      if (widget.advanceStatus != null) {
        selectedStatus = widget.advanceStatus ?? "dataSubmitted";
      }
      userRole = NetworkHelper().currentDevotee?.role;
    });
  }

  Padding advanceSearchDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, bottom: 10),
      child: DropdownMenu<String>(
        width: 180,
        label: selectedStatus != null
            ? Text(selectedStatus!)
            : const Text("Status"), //selectedStatus ??
        textStyle: const TextStyle(color: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Colors.white),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        trailingIcon: const Icon(
          Icons.arrow_drop_down_rounded,
          color: Colors.white,
          size: 30,
        ),
        selectedTrailingIcon: const Icon(
          Icons.arrow_drop_up_rounded,
          color: Colors.white,
          size: 30,
        ),
        menuStyle: MenuStyle(
            backgroundColor:
                MaterialStateProperty.resolveWith((state) => Colors.white),
            shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  // Return a different shape when the button is pressed
                  return RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: const BorderSide(color: Colors.deepOrange),
                  );
                }
                // Return the default shape for other states
                return RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.white),
                );
              },
            )),
        enableFilter: true,
        enableSearch: true,
        onSelected: (String? newValue) async {
          setState(() {
            selectedStatus = newValue!;
          });
          devoteeList.clear();
          await GetDevoteeAPI()
              .advanceSearchDevotee(widget.searchValue.toString(),
                  widget.searchBy.toString(), 1, dataCountPerPage,
                  status: selectedStatus)
              .then((response) {
            devoteeList.addAll(response["data"]);
            totalPages = response["totalPages"];
            dataCount = response["count"];
            currentPage = response["currentPage"];
          });
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DevoteeListPage(
                  status: "allDevotee",
                  advanceStatus: selectedStatus,
                  pageFrom: "Search",
                  devoteeList: devoteeList,
                  searchValue: widget.searchValue.toString(),
                  searchBy: widget.searchBy,
                  showClearButton: widget.showClearButton,
                  //       currentPage: currentPage,
                  // dataCount: dataCount,
                  // totalPages: totalPages,
                );
              },
            ));
          }
        },
        dropdownMenuEntries:
            statusOptions.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: SearchDevotee(
              status: "allDevotee",
              searchBy: widget.searchBy,
              searchStatus: selectedStatus,
              searchValue: widget.searchValue,
              onFieldValueChanged: (isEmpty) {},
            )),
        widget.showClearButton == true
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  advanceSearchDropdown(context),
                  SearchClearButton(widget: widget),
                  const GotoHomeButton(),
                  // Column(
                  //   children: [
                  //     SearchClearButton(widget: widget),
                  //     const SizedBox(height: 5),
                  //     const GotoHomeButton(),
                  //   ],
                  // ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }
}

class SearchClearButton extends StatelessWidget {
  const SearchClearButton({
    super.key,
    required this.widget,
  });

  final ResponsiveAppbarActionButtonWidget widget;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.showClearButton == true,
      child: Row(
        children: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return DevoteeListPage(
                    pageFrom: "Dashboard",
                    status: "allDevotee",
                  );
                },
              ));
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}























  // List<String> statusOptionsUI = [
  //   'Data Submitted',
  //   'Paid',
  //   'Rejected',
  //   'Approved',
  //   'Printed',
  //   'Withdrawn',
  //   'Lost',
  //   'Reissued',
  //   "Blacklisted"
  // ];

  // List<Map<String, dynamic>> statusList = [
  //   {
  //     "label": "Status",
  //     "status": [
  //       'dataSubmitted',
  //       'paid',
  //       'rejected',
  //       'approved',
  //       'printed',
  //       'withdrawn',
  //       'lost',
  //       'reissued',
  //       "blacklisted"
  //     ]
  //   },
  // ];
  // late final List data;




 // Padding advanceSearchDropdown(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(10),
  //     child: OutlinedButton(
  //       onPressed: () {},
  //       style: OutlinedButton.styleFrom(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         side: const BorderSide(color: Colors.white),
  //       ),
  //       child: DropdownButton<String>(
  //         iconEnabledColor: Colors.deepOrange,
  //         value: selectedStatus,
  //         hint: const Text("Status"),
  //         disabledHint: const Text("not status"),
  //         dropdownColor: Colors.blue,
  //         borderRadius: BorderRadius.circular(20),
  //         onChanged: (String? newValue) async {
  //           setState(() {
  //             selectedStatus = newValue!;
  //           });
  //           devoteeList.clear();
  //           await GetDevoteeAPI()
  //               .advanceSearchDevotee(
  //                   widget.searchValue.toString(), widget.searchBy.toString(),
  //                   status: selectedStatus)
  //               .then((value) {
  //             devoteeList.addAll(value["data"]);
  //           });
  //           if (context.mounted) {
  //             Navigator.push(context, MaterialPageRoute(
  //               builder: (context) {
  //                 return DevoteeListPage(
  //                   status: "allDevotee",
  //                   advanceStatus: selectedStatus,
  //                   pageFrom: "Search",
  //                   devoteeList: devoteeList,
  //                   searchValue: widget.searchValue.toString(),
  //                   searchBy: widget.searchBy,
  //                   showClearButton: widget.showClearButton,
  //                 );
  //               },
  //             ));
  //           }
  //         },
  //         underline: const SizedBox(),
  //         style: const TextStyle(color: Colors.white),
  //         // items: [
  //         //   for (final item in data)
  //         //     item['bold'] == true
  //         //         ? DropdownMenuItem(
  //         //             enabled: false,
  //         //             child: Text(item['value'],
  //         //                 style: const TextStyle(fontWeight: FontWeight.bold)))
  //         //         : DropdownMenuItem(
  //         //             value: item['value'],
  //         //             child: Padding(
  //         //               padding: const EdgeInsets.only(left: 8),
  //         //               child: Text(item['value']),
  //         //             ))
  //         // ],
  //         items: statusOptions.map<DropdownMenuItem<String>>((String value) {
  //           return DropdownMenuItem<String>(
  //             value: value,
  //             child: Text(value),
  //           );
  //         }).toList(),
  //         // items: Map.fromIterables(statusOptionsUI, statusOptions)
  //         //     .entries
  //         //     .map<DropdownMenuItem<String>>(
  //         //       (MapEntry<String, String> entry) => DropdownMenuItem<String>(
  //         //         value: entry.value,
  //         //         child: Padding(
  //         //           padding: const EdgeInsets.all(8.0),
  //         //           child: Text(entry.key),
  //         //         ),
  //         //       ),
  //         //     )
  //         //     .toList(),
  //       ),
  //     ),
  //   );
  // }