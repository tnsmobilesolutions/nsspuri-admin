// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/constant/custom_loading_indicator.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/export_to_excel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/viewDevotee.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/utilities/network_helper.dart';
import 'package:animate_icons/animate_icons.dart';

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
  //bool isLoading = true;
  String? userRole;

  late AnimateIconController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimateIconController();

    widget.devoteeList != null
        ? allPaliaList = widget.devoteeList!
        : fetchAllDevotee();
    setState(() {
      userRole = Networkhelper().currentDevotee?.role;
    });
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

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
    //setState(() => isLoading = false);
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
                      fontWeight: FontWeight.bold),
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
                          fontWeight: FontWeight.bold),
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
        if (showMenu) dataColumn(context, 'View'),
        if (showMenu) dataColumn(context, 'Edit'),
      ],
      rows: List.generate(
        allPaliaList.length,
        (index) {
          return DataRow(
            cells: [
              DataCell(Text("${index + 1}")),
              const DataCell(SizedBox(
                height: 50,
                width: 50,
                child:
                    // allPaliaList[index].profilePhotoUrl != null &&
                    //         allPaliaList[index].profilePhotoUrl!.isNotEmpty == true
                    //     ? Image.network(
                    //         allPaliaList[index].profilePhotoUrl ?? '',
                    //         cacheWidth: 50,
                    //         cacheHeight: 50,
                    //       )
                    //     :
                    Image(image: AssetImage('assets/images/profile.jpeg')),
              )),
              DataCell(Text(allPaliaList[index].name ?? '_')),
              DataCell(Text(allPaliaList[index].sangha ?? '_')),
              DataCell(Text(allPaliaList[index].dob ?? '_')),
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
              if (showMenu)
                DataCell(IconButton(
                    onPressed: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                              ViewPalia(devoteeDetails: allPaliaList[index]),
                        ),
                      );
                    },
                    icon: const Icon(Icons.info, color: Colors.deepOrange))),
              if (showMenu)
                DataCell(
                  IconButton(
                    color: Colors.deepOrange,
                    onPressed: Networkhelper().currentDevotee?.role ==
                                "Approver" &&
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
                      color:
                          Networkhelper().currentDevotee?.role == "Approver" &&
                                  allPaliaList[index].status == "paid"
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
      child:
          //  isLoading
          //     ? const Center(child: CustomLoadingIndicator())
          //     :
          SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          width: 1.5, color: Colors.deepOrange),
                      foregroundColor: Colors.black),
                  onPressed: () {
                    setState(() {
                      showMenu = !showMenu;
                    });
                  },
                  child: showMenu
                      ? const Text('Close Action Menu')
                      : const Text('Show Action Menu'),
                ),
                const SizedBox(
                  width: 10,
                ),
                userRole == "SuperAdmin" ||
                        userRole == "Admin" ||
                        userRole == "Approver"
                    ? OutlinedButton(
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
                            SizedBox(width: 10),
                            Icon(
                              Icons.upload_rounded,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: devoteeTable(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
