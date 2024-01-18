// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print
import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/export_to_excel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/printpdf.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/viewDevotee/viewDevotee.dart';
import 'package:sdp/utilities/network_helper.dart';

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
  List<DevoteeModel> allPaliaList = [];
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

  @override
  void initState() {
    super.initState();
    _controller = AnimateIconController();

    widget.devoteeList != null
        ? allPaliaList = widget.devoteeList!
        : fetchAllDevotee();
    setState(() {
      userRole = NetworkHelper().currentDevotee?.role;
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
          allPaliaList.add(allDevotee?["data"][i]);
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
                    //fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ));
  }

  Widget devoteeTable(BuildContext context) {
    return DataTable(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      columnSpacing: 10,
      dataRowMaxHeight: 80,
      columns: [
        dataColumn(context, 'Checkbox'),
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
                        //fontWeight: FontWeight.bold,
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
        dataColumn(context, 'DOB'),
        dataColumn(context, 'Status'),
        dataColumn(context, 'View'),
        dataColumn(context, 'Edit'),
        // Add more DataColumn widgets as needed
      ],
      rows: List.generate(
        allPaliaList.length,
        (index) {
          return DataRow(
            cells: [
              // Inside the DataRow, add a DataCell for the checkbox
              DataCell(
                Visibility(
                  visible: isChecked,
                  child: Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    },
                  ),
                ),
              ),
              DataCell(Text("${index + 1}")),
              DataCell(SizedBox(
                height: 50,
                width: 50,
                child: allPaliaList[index].profilePhotoUrl != null &&
                        allPaliaList[index].profilePhotoUrl!.isNotEmpty == true
                    ? Image.network(
                        allPaliaList[index].profilePhotoUrl ?? '',
                        height: 80,
                        width: 80,
                      )
                    : const Image(
                        image: AssetImage('assets/images/profile.jpeg')),
              )),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      allPaliaList[index].name != null
                          ? '${allPaliaList[index].name}'
                          : "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      allPaliaList[index].devoteeCode.toString(),
                    ),
                  ],
                ),
              ),
              DataCell(Text(allPaliaList[index].sangha ?? '_')),
              DataCell(
                Text(
                  formatDate(allPaliaList[index].dob ?? ""),
                  textAlign: TextAlign.center,
                ),
              ),
              DataCell(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${allPaliaList[index].status}'),
                    allPaliaList[index].paidAmount != null
                        ? Text('₹${allPaliaList[index].paidAmount}')
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
                                Text(allPaliaList[index].name.toString()),
                                IconButton(
                                    color: Colors.deepOrange,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            Text(allPaliaList[index].sangha.toString()),
                          ],
                        ),
                        content:
                            ViewDevotee(devoteeDetails: allPaliaList[index]),
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
                              allPaliaList[index].status == "paid"
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
                                      content: AddPageDilouge(
                                        devoteeId: allPaliaList[index]
                                            .devoteeId
                                            .toString(),
                                        title: "edit",
                                        showClearButton: widget.showClearButton,
                                        searchBy: widget.searchBy,
                                        searchValue: widget.searchValue,
                                      ));
                                },
                              );
                            },
                  icon: Icon(
                    Icons.edit,
                    color: NetworkHelper().currentDevotee?.role == "Approver" &&
                            allPaliaList[index].status == "paid"
                        ? const Color.fromARGB(255, 206, 206, 206)
                        : Colors.deepOrange,
                  ),
                ),
              ),
              // Add more DataCell widgets as needed
            ],
          );
        },
      ),
    );
  }

  void _sortList(bool isAscending) {
    setState(() {
      allPaliaList.sort((a, b) {
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
                ? SizedBox(
                    // height: 40,
                    width: 120,
                    child: Row(
                      children: [
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              width: 1.5,
                              color: Colors.deepOrange,
                            ),
                            foregroundColor: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              isChecked = !isChecked;
                              if (isChecked) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PrintPdfScreen(),
                                  ),
                                );
                              }
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(isChecked ? 'Print' : 'Select'),
                              // SizedBox(width: 10),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  width: 1.5, color: Colors.deepOrange),
                              foregroundColor: Colors.black),
                          onPressed: () {
                            ExportToExcel().exportToExcel(allPaliaList);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Export'),
                              // SizedBox(width: 10),
                              Icon(
                                Icons.upload_rounded,
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
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
