// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print
import 'dart:typed_data';

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/export_to_excel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/printpdf.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/viewDevotee/viewDevotee.dart';
import 'package:sdp/utilities/network_helper.dart';
import 'package:pdf/widgets.dart' as pw;

class DevoteeListBodyPage extends StatefulWidget {
  DevoteeListBodyPage(
      {Key? key,
      required this.status,
      required this.pageFrom,
      this.devoteeList,
      this.showClearButton,
      this.searchValue,
      this.searchBy})
      : super(key: key);

  List<DevoteeModel>? devoteeList;
  String pageFrom;
  String? searchBy;
  String? searchValue;
  bool? showClearButton;
  String status;

  @override
  State<DevoteeListBodyPage> createState() => _DevoteeListBodyPageState();
}

class _DevoteeListBodyPageState extends State<DevoteeListBodyPage>
    with TickerProviderStateMixin {
  bool? allCheck;
  List<DevoteeModel> allDevotees = [], selectedDevotees = [];
  bool checkedValue = false;
  bool editpaliDate = false;
  bool isAscending = false;
  bool showMenu = false;
  bool isLoading = true;
  bool isSelected = false;
  String? userRole;
  bool isChecked = false;
  List<String> monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  late AnimateIconController _controller;
  List<bool> selectedList = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimateIconController();

    widget.devoteeList != null
        ? allDevotees = widget.devoteeList!
        : fetchAllDevotee();
    setState(() {
      userRole = NetworkHelper().currentDevotee?.role;
      selectedList =
          List<bool>.generate(allDevotees.length, (int index) => false);
    });
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  String formatDate(String inputDate) {
    if (inputDate.isNotEmpty) {
      DateTime dateTime = DateFormat('yyyy-MM-dd', 'en_US').parse(inputDate);

      int day = dateTime.day;
      String month = monthNames[dateTime.month - 1];
      int year = dateTime.year;

      String formattedDate = '$day-$month-$year';

      return formattedDate;
    }
    return "";
  }

  void fetchAllDevotee() async {
    Map<String, dynamic>? allDevotee;

    if (widget.status == "allDevotee" && widget.pageFrom == "Dashboard") {
      allDevotee = await GetDevoteeAPI().allDevotee();
    } else if (widget.status != "allDevotee" &&
        widget.pageFrom == "Dashboard") {
      allDevotee = await GetDevoteeAPI().searchDevotee(widget.status, "status");
    } else if (widget.pageFrom == "Search") {
      allDevotee = await GetDevoteeAPI().advanceSearchDevotee(
        widget.searchValue.toString(),
        widget.searchBy.toString(),
      );
    }

    if (allDevotee != null) {
      setState(() {
        for (int i = 0; i < allDevotee?["data"].length; i++) {
          allDevotees.add(allDevotee?["data"][i]);
        }
      });
    } else {
      print("Error fetching data");
    }
    setState(() => isLoading = false);
  }

  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  DataColumn dataColumn(BuildContext context, String header,
      [Function(int, bool)? onSort]) {
    return DataColumn(
        onSort: onSort,
        label: Flexible(
          flex: 1,
          child: Text(
            header,
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium?.merge(
                  const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
          ),
        ));
  }

  String getAgeGroup(DevoteeModel? devotee) {
    if (devotee?.ageGroup?.isNotEmpty == true || devotee?.ageGroup != null) {
      if (devotee?.ageGroup == "Child") {
        return "0 to 12";
      } else if (devotee?.ageGroup == "Adult") {
        return "13 to 70";
      } else if (devotee?.ageGroup == "Elder") {
        return "70 Above";
      }
    }
    return "";
  }

  Widget devoteeTable(BuildContext context) {
    return DataTable(
      showBottomBorder: true,
      showCheckboxColumn: true,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      columnSpacing: 10,
      dataRowMaxHeight: 80,
      columns: [
        dataColumn(context, 'Sl. No.'),
        dataColumn(context, 'Profile Image'),
        DataColumn(
          label: Row(
            children: [
              Text(
                'Devotee Name',
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.merge(
                      const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
              ),
              AnimateIcons(
                startIcon: Ionicons.arrow_up,
                endIcon: Ionicons.arrow_down,
                startIconColor: Colors.deepOrange,
                endIconColor: Colors.deepOrange,
                controller: _controller,
                duration: const Duration(milliseconds: 800),
                size: 20.0,
                onStartIconPress: () {
                  isAscending = !isAscending;
                  _sortList(isAscending);
                  return true;
                },
                onEndIconPress: () {
                  isAscending = !isAscending;
                  _sortList(isAscending);
                  return true;
                },
              ),
            ],
          ),
        ),
        dataColumn(context, 'Sangha'),
        dataColumn(context, 'DOB/Age'),
        dataColumn(context, 'Status'),
        dataColumn(context, 'View'),
        dataColumn(context, 'Edit'),
      ],
      rows: List.generate(
        allDevotees.length,
        (index) {
          return DataRow(
            // selected: selectedList[index],
            // onSelectChanged: (bool? value) {
            //   setState(() {
            //     selectedList[index] = value!;
            //     if (value) {
            //       if (selectedDevotees.length < 6) {
            //         selectedDevotees.add(allDevotees[index]);
            //       } else {
            //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //           elevation: 6,
            //           behavior: SnackBarBehavior.floating,
            //           content: Text(
            //             'You can only select up to 6 devotees !',
            //           ),
            //         ));
            //         selectedList[index] = false;
            //       }
            //     } else {
            //       selectedDevotees.remove(allDevotees[index]);
            //     }
            //   });
            // },
            cells: [
              DataCell(Text("${index + 1}")),
              const DataCell(SizedBox(
                height: 50,
                width: 50,
                child:
                    //  allDevotees[index].profilePhotoUrl != null &&
                    //         allDevotees[index].profilePhotoUrl!.isNotEmpty == true
                    //     ? Image.network(
                    //         allDevotees[index].profilePhotoUrl ?? '',
                    //         height: 80,
                    //         width: 80,
                    //       )
                    //     :
                    Image(image: AssetImage('assets/images/profile.jpeg')),
              )),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allDevotees[index].name != null
                          ? '${allDevotees[index].name}'
                          : "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      allDevotees[index].devoteeCode.toString(),
                    ),
                  ],
                ),
              ),
              DataCell(Text(allDevotees[index].sangha ?? "")),
              DataCell(
                allDevotees[index].dob?.isNotEmpty == true
                    ? Text(
                        formatDate(allDevotees[index].dob ?? ""),
                        textAlign: TextAlign.center,
                      )
                    : (allDevotees[index].ageGroup?.isNotEmpty == true ||
                            allDevotees[index].ageGroup != null)
                        ? Text(
                            getAgeGroup(allDevotees[index]),
                            textAlign: TextAlign.center,
                          )
                        : const Text(""),
              ),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${allDevotees[index].status}'),
                    allDevotees[index].paidAmount != null
                        ? Text('₹${allDevotees[index].paidAmount}')
                        : const SizedBox(),
                  ],
                ),
              ),
              DataCell(
                IconButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(allDevotees[index].name.toString()),
                                IconButton(
                                    color: Colors.deepOrange,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            Text(allDevotees[index].sangha.toString()),
                          ],
                        ),
                        content:
                            ViewDevotee(devoteeDetails: allDevotees[index]),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info, color: Colors.deepOrange),
                ),
              ),
              DataCell(
                IconButton(
                  color: Colors.deepOrange,
                  onPressed:
                      NetworkHelper().currentDevotee?.role == "Approver" &&
                              allDevotees[index].status == "paid"
                          ? null
                          : () {
                              showDialog<void>(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('Edit Devotee Details'),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.deepOrange,
                                              ))
                                        ],
                                      ),
                                      content: (NetworkHelper()
                                                  .getCurrentDevotee
                                                  ?.role !=
                                              "Viewer")
                                          ? AddPageDilouge(
                                              devoteeId: allDevotees[index]
                                                  .devoteeId
                                                  .toString(),
                                              title: "edit",
                                              showClearButton:
                                                  widget.showClearButton,
                                              searchBy: widget.searchBy,
                                              searchValue: widget.searchValue,
                                            )
                                          : null);
                                },
                              );
                            },
                  icon: Icon(
                    Icons.edit,
                    color:
                        ((NetworkHelper().currentDevotee?.role == "Approver" &&
                                    allDevotees[index].status == "paid" ||
                                (NetworkHelper().getCurrentDevotee?.role ==
                                    "Viewer")))
                            ? const Color.fromARGB(255, 206, 206, 206)
                            : Colors.deepOrange,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _sortList(bool isAscending) {
    setState(() {
      allDevotees.sort((a, b) {
        final nameA = (a.name ?? '').toLowerCase();
        final nameB = (b.name ?? '').toLowerCase();
        return isAscending ? nameA.compareTo(nameB) : nameB.compareTo(nameA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            userRole == "SuperAdmin" ||
                    userRole == "Admin" ||
                    userRole == "Approver"
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.5, color: Colors.deepOrange),
                            foregroundColor: Colors.black),
                        onPressed: (NetworkHelper().getCurrentDevotee?.role !=
                                "Viewer")
                            ? () {}
                            : null,
                        child: const Text('Print'),
                      ),
                      const SizedBox(width: 12),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                width: 1.5, color: Colors.deepOrange),
                            foregroundColor: Colors.black),
                        onPressed: (NetworkHelper().getCurrentDevotee?.role !=
                                "Viewer")
                            ? () {
                                ExportToExcel().exportToExcel(allDevotees);
                              }
                            : null,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text('Export'),
                            Icon(
                              Icons.upload_rounded,
                              color: Colors.deepOrange,
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: Responsive(
                    desktop: devoteeTable(context),
                    tablet: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: devoteeTable(context),
                    ),
                    mobile: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: devoteeTable(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
