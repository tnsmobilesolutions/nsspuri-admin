// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print

import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/viewDevotee/viewDevotee.dart';
import 'package:sdp/utilities/network_helper.dart';

class UserTableView extends StatefulWidget {
  UserTableView({
    Key? key,
    required this.devoteeList,
  }) : super(key: key);

  List<DevoteeModel> devoteeList;

  @override
  State<UserTableView> createState() => _UserTableViewState();
}

class _UserTableViewState extends State<UserTableView>
    with TickerProviderStateMixin {
  bool editpaliDate = false;
  bool isAscending = false;
  bool showMenu = false;
  bool isLoading = true;
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

  List<bool> selectedList = [];

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

  Widget devoteeTable(BuildContext context) {
    List<DevoteeModel> allDevotees = widget.devoteeList;
    return DataTable(
      showBottomBorder: true,
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
              // AnimateIcons(
              //   startIcon: Ionicons.arrow_up,
              //   endIcon: Ionicons.arrow_down,
              //   startIconColor: Colors.deepOrange,
              //   endIconColor: Colors.deepOrange,
              //   controller: _controller,
              //   duration: const Duration(milliseconds: 800),
              //   size: 20.0,
              //   onStartIconPress: () {
              //     isAscending = !isAscending;
              //     _sortList(isAscending);
              //     return true;
              //   },
              //   onEndIconPress: () {
              //     isAscending = !isAscending;
              //     _sortList(isAscending);
              //     return true;
              //   },
              // ),
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
            cells: [
              DataCell(Text("${index + 1}")),
              const DataCell(SizedBox(
                height: 50,
                width: 50,
                child: Image(image: AssetImage('assets/images/profile.jpeg')),
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
              DataCell(Text(allDevotees[index].sangha ?? '_')),
              DataCell(
               
                    Text(
                        formatDate(allDevotees[index].dob ?? ""),
                        textAlign: TextAlign.center,
                      ),
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
                  onPressed: NetworkHelper().currentDevotee?.role ==
                              "Approver" &&
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
                                  content: AddPageDilouge(
                                    devoteeId:
                                        allDevotees[index].devoteeId.toString(),
                                    title: "edit",
                                    role: "User",
                                  ));
                            },
                          );
                        },
                  icon: Icon(
                    Icons.edit,
                    color: NetworkHelper().currentDevotee?.role == "Approver" &&
                            allDevotees[index].status == "paid"
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
      widget.devoteeList.sort((a, b) {
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
