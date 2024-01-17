// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/PaliaListScreen.dart/export_to_excel.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/appBar/search.dart';
import 'package:sdp/utilities/network_helper.dart';

class AppbarActionButtonWidget extends StatefulWidget {
  AppbarActionButtonWidget({
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
  State<AppbarActionButtonWidget> createState() =>
      _AppbarActionButtonWidgetState();
}

class _AppbarActionButtonWidgetState extends State<AppbarActionButtonWidget> {
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
  @override
  void initState() {
    super.initState();
    // data = [
    //   for (final item in statusList)
    //     for (final value in item.values)
    //       if (value is List)
    //         for (final listValue in value) {'value': listValue, 'bold': false}
    //       else
    //         {'value': value, 'bold': true}
    // ];
    setState(() {
      selectedStatus = widget.advanceStatus ?? "dataSubmitted";
      userRole = Networkhelper().currentDevotee?.role;
    });
  }

  Padding advanceSearchDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          side: const BorderSide(color: Colors.white),
        ),
        child: DropdownButton<String>(
          iconEnabledColor: Colors.deepOrange,
          value: selectedStatus,
          hint: const Text("Status"),
          disabledHint: const Text("not status"),
          dropdownColor: Colors.blue,
          borderRadius: BorderRadius.circular(20),
          onChanged: (String? newValue) async {
            setState(() {
              selectedStatus = newValue!;
            });
            devoteeList.clear();
            await GetDevoteeAPI()
                .advanceSearchDevotee(
                    widget.searchValue.toString(), widget.searchBy.toString(),
                    status: selectedStatus)
                .then((value) {
              devoteeList.addAll(value["data"]);
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
                  );
                },
              ));
            }
          },
          underline: const SizedBox(),
          style: const TextStyle(color: Colors.white),
          // items: [
          //   for (final item in data)
          //     item['bold'] == true
          //         ? DropdownMenuItem(
          //             enabled: false,
          //             child: Text(item['value'],
          //                 style: const TextStyle(fontWeight: FontWeight.bold)))
          //         : DropdownMenuItem(
          //             value: item['value'],
          //             child: Padding(
          //               padding: const EdgeInsets.only(left: 8),
          //               child: Text(item['value']),
          //             ))
          // ],
          items: statusOptions.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          // items: Map.fromIterables(statusOptionsUI, statusOptions)
          //     .entries
          //     .map<DropdownMenuItem<String>>(
          //       (MapEntry<String, String> entry) => DropdownMenuItem<String>(
          //         value: entry.value,
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text(entry.key),
          //         ),
          //       ),
          //     )
          //     .toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const GotoHomeButton(),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchDevotee(
              status: "allDevotee",
              searchBy: widget.searchBy,
              searchStatus: selectedStatus,
              searchValue: widget.searchValue,
              onFieldValueChanged: (isEmpty) {},
            )),
        widget.showClearButton == true
            ? advanceSearchDropdown(context)
            : const SizedBox(),
        SearchClearButton(widget: widget),
        CreateDelegateButton(),
        // userRole == "SuperAdmin" ||
        //         userRole == "Admin" ||
        //         userRole == "Approver"
        //     ? OutlinedButton(
        //         style: OutlinedButton.styleFrom(
        //             side:
        //                 const BorderSide(width: 1.5, color: Colors.deepOrange),
        //             foregroundColor: Colors.black),
        //         onPressed: () {
        //           ExportToExcel().exportToExcel(allPaliaList);
        //         },
        //         child: const Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //           children: [
        //             Text('Export'),
        //             SizedBox(width: 10),
        //             Icon(
        //               Icons.upload_rounded,
        //               color: Colors.blue,
        //             )
        //           ],
        //         ),
        //       )
        //     : const SizedBox(),
        const SizedBox(width: 10),
        const LogoutButton(),
        const SizedBox(width: 10),
      ],
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     if (Responsive.isDesktop(context)) {
//       return Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: SearchDevotee(
//                     status: "allDevotee",
//                     searchBy: widget.searchBy,
//                     searchStatus: selectedStatus,
//                     searchValue: widget.searchValue,
//                     onFieldValueChanged: (isEmpty) {},
//                   )),
//               widget.showClearButton == true
//                   ? advanceSearchDropdown(context)
//                   : const SizedBox(),
//             ],
//           ),
//           SearchClearButton(widget: widget),
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 const GotoHomeButton(),
//                 CreateDelegateButton(),
//                 const LogoutButton(),
//               ],
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SearchDevotee(
//               status: "allDevotee",
//               searchBy: widget.searchBy,
//               searchValue: widget.searchValue,
//               onFieldValueChanged: (isEmpty) {},
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 const GotoHomeButton(),
//                 const SizedBox(width: 10),
//                 widget.showClearButton == true
//                     ? advanceSearchDropdown(context)
//                     : const SizedBox(),
//                 const SizedBox(width: 10),
//                 SearchClearButton(widget: widget),
//                 CreateDelegateButton(),
//                 const SizedBox(width: 10),
//                 const LogoutButton(),
//               ],
//             ),
//           ),
//         ],
//       );
//     }
//   }

class SearchClearButton extends StatelessWidget {
  const SearchClearButton({
    super.key,
    required this.widget,
  });

  final AppbarActionButtonWidget widget;

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
