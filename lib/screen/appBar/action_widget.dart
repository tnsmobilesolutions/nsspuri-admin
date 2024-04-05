// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/appBar/search.dart';
import 'package:sdp/utilities/network_helper.dart';

class AppbarActionButtonWidget extends StatefulWidget {
  AppbarActionButtonWidget({
    super.key,
    this.searchBy,
    this.pageFrom,
    this.searchValue,
    this.advanceStatus,
    this.showClearButton,
    this.pageNumber,
  });

  String? advanceStatus;
  String? searchBy;
  String? pageFrom;
  String? searchValue;
  bool? showClearButton;
  int? pageNumber;

  @override
  State<AppbarActionButtonWidget> createState() =>
      _AppbarActionButtonWidgetState();
}

class _AppbarActionButtonWidgetState extends State<AppbarActionButtonWidget> {

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
      padding: const EdgeInsets.all(10),
      child: DropdownMenu<String>(
        width: 200,
        label: selectedStatus != null
            ? Text(
                selectedStatus!,
                style: const TextStyle(
                  fontSize: 12,
                ),
              )
            : const Text("Status"),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
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
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
          await GetDevoteeAPI()
              .advanceSearchDevotee(
            widget.searchValue.toString(),
            widget.searchBy.toString(),
            1,
            dataCountPerPage,
            status: selectedStatus,
            isAscending: NetworkHelper().getNameAscending,
          )
              .then((response) {
            devoteeList.addAll(response["data"]);
            totalPages = response["totalPages"];
            dataCount = response["count"];
            currentPage = response["currentPage"];
          });
          if (context.mounted) {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DevoteeListPage(
                  status: "allDevotee",
                  advanceStatus: selectedStatus,
                  //pageFrom: "Search",
                  devoteeList: devoteeList,
                  searchValue: widget.searchValue.toString(),
                  searchBy: widget.searchBy,
                  showClearButton: widget.showClearButton,
                  currentPage: currentPage,
                  dataCount: dataCount,
                  totalPages: totalPages,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SearchDevotee(
          status: "allDevotee",
          searchBy: widget.searchBy,
          searchStatus: selectedStatus,
          searchValue: widget.searchValue,
          pageNumber: widget.pageNumber ?? 1,
          onFieldValueChanged: (isEmpty) {},
        ),
        widget.showClearButton == true
            ? advanceSearchDropdown(context)
            : const SizedBox(),
        SearchClearButton(widget: widget),
      ],
    );
  }
}

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
