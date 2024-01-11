// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/appBar/search.dart';

class AppbarActionButtonWidget extends StatefulWidget {
  AppbarActionButtonWidget({
    super.key,
    this.searchBy,
    this.searchValue,
    this.advanceStatus,
    this.showClearButton,
  });

  String? searchBy;
  String? advanceStatus;
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

  List<String> statusOptionsUI = [
    'Data Submitted',
    'Paid',
    'Rejected',
    'Approved',
    'Printed',
    'Withdrawn',
    'Lost',
    'Reissued',
    "Blacklisted"
  ];
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
  List<DevoteeModel> devoteeList = [];
  String? selectedStatus;
  // String selectedStatus = 'Data Submitted';
  @override
  void initState() {
    super.initState();
    setState(() {
      selectedStatus = widget.advanceStatus ?? "dataSubmitted";
    });
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      // MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.white;
  }

  Row statusCheckBox(String title, bool selectedValue) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('isGruhasanaApproved'),
        Checkbox(
          checkColor: Colors.deepOrange,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: selectedValue,
          onChanged: (bool? value) {
            setState(() {
              selectedValue = value!;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: Responsive.isDesktop(context),
      replacement: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SearchDevotee(
              status: "allDevotee",
              searchBy: widget.searchBy,
              searchValue: widget.searchValue,
              onFieldValueChanged: (isEmpty) {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const GotoHomeButton(),
                const SizedBox(width: 10),
                Visibility(
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
                              return PaliaListPage(
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
                ),
                CreateDelegateButton(),
                const SizedBox(width: 10),
                const LogoutButton(),
              ],
            ),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: GotoHomeButton(),
          ),
          Column(
            children: [
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
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: DropdownButton<String>(
                        iconEnabledColor: Colors.deepOrange,
                        value: selectedStatus,
                        dropdownColor: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                        onChanged: (String? newValue) async {
                          setState(() {
                            selectedStatus = newValue!;
                          });
                          devoteeList.clear();
                          await GetDevoteeAPI()
                              .advanceSearchDevotee(
                                  widget.searchValue.toString(),
                                  widget.searchBy.toString(),
                                  status: selectedStatus)
                              .then((value) {
                            devoteeList.addAll(value["data"]);
                          });
                          if (context.mounted) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return PaliaListPage(
                                  status: "allDevotee",
                                  advanceStatus:
                                      selectedStatus ?? widget.advanceStatus,
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
                        items: Map.fromIterables(statusOptionsUI, statusOptions)
                            .entries
                            .map<DropdownMenuItem<String>>(
                              (MapEntry<String, String> entry) =>
                                  DropdownMenuItem<String>(
                                value: entry.value,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(entry.key),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          Visibility(
            visible: widget.showClearButton == true,
            child: OutlinedButton(
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
                    return PaliaListPage(
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
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CreateDelegateButton(),
                const LogoutButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
