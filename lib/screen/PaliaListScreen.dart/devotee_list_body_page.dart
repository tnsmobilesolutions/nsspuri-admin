// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/export_to_excel.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaTableRow.dart';
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

class _DevoteeListBodyPageState extends State<DevoteeListBodyPage> {
  bool? allCheck;
  List<DevoteeModel> allPaliaList = [];
  bool checkedValue = false;
  bool editpaliDate = false;
  bool showMenu = false;
  bool isAscending = false;
  String? userRole;

  @override
  void initState() {
    super.initState();
    widget.devoteeList != null
        ? allPaliaList = widget.devoteeList!
        : fetchAllDevotee();
    setState(() {
      userRole = Networkhelper().currentDevotee?.role;
    });
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side:
                        const BorderSide(width: 1.5, color: Colors.deepOrange),
                    foregroundColor: Colors.black),
                onPressed: () {
                  setState(() {
                    showMenu = !showMenu;
                  });
                },
                child: showMenu ? const Text('Print') : const Text('Select'),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side:
                        const BorderSide(width: 1.5, color: Colors.deepOrange),
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                headingText('Sl No.'),
                headingText('Profile Image'),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Devotee Name",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 10),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isAscending = !isAscending;
                          });
                          _sortList(isAscending);
                        },
                        icon: Icon(
                          isAscending
                              ? Ionicons.arrow_down
                              : Icons.arrow_upward,
                          color: Colors.deepOrange,
                        ),
                      ),
                    ],
                  ),
                ),
                headingText('Sangha'),
                headingText('DOB'),
                headingText('Status'),
                if (showMenu == true) headingText('View'),
                if (showMenu == true) headingText('Edit'),
                // if (showMenu == true) headingText('Delete'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Flexible(
            child: ListView.builder(
              itemCount: allPaliaList.length,
              itemBuilder: (BuildContext context, int index) {
                //Table firebase Data
                return PaliaTableRow(
                  showMenu: showMenu,
                  slNo: index + 1,
                  devoteeDetails: allPaliaList[index],
                  devoteeList: widget.devoteeList,
                  pageFrom: widget.pageFrom,
                  showClearButton: widget.showClearButton,
                  status: widget.status,
                  searchBy: widget.searchBy,
                  searchValue: widget.searchValue,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
