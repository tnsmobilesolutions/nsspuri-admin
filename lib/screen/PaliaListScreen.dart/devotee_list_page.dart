// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_body_page.dart';

class DevoteeListPage extends StatefulWidget {
  DevoteeListPage(
      {Key? key,
      required this.status,
      this.advanceStatus,
      required this.pageFrom,
      this.devoteeList,
      this.searchValue,
      this.showClearButton,
      this.searchBy})
      : super(key: key);
  String status;
  String? advanceStatus;
  String pageFrom;
  List<DevoteeModel>? devoteeList;
  String? searchValue;
  String? searchBy;
  bool? showClearButton;

  @override
  State<DevoteeListPage> createState() => _DevoteeListPageState();
}

class _DevoteeListPageState extends State<DevoteeListPage> {
  @override
  void initState() {
    super.initState();

    setState(() {
      if (widget.advanceStatus != null) {
        print("inside palia list page init state - success");
      } else {
        print("nside palia list page init state - failure");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          // toolbarHeight: Responsive.isDesktop(context)
          //     ? 150
          //     : Responsive.isLargeMobile(context)
          //         ? 150
          //         : 120,
          toolbarHeight: 120,
          automaticallyImplyLeading: false,
          title: const TitleAppBar(),
          actions: [
            AppbarActionButtonWidget(
              searchBy: widget.searchBy,
              searchValue: widget.searchValue,
              showClearButton: widget.showClearButton,
              advanceStatus: widget.advanceStatus ?? "dataSubmitted",
            ),
          ],
          // actions: !Responsive.isLargeMobile(context)
          //     ? [
          //         AppbarActionButtonWidget(
          //           searchBy: widget.searchBy,
          //           searchValue: widget.searchValue,
          //           showClearButton: widget.showClearButton,
          //         ),
          //       ]
          //     : [],
          // bottom: PreferredSize(
          //   preferredSize: Responsive.isLargeMobile(context)
          //       ? const Size.fromHeight(50)
          //       : const Size.fromHeight(50),
          //   child: Responsive.isLargeMobile(context)
          //       ? Padding(
          //           padding: const EdgeInsets.only(bottom: 20),
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               AppbarActionButtonWidget(
          //                 searchBy: widget.searchBy,
          //                 searchValue: widget.searchValue,
          //                 showClearButton: widget.showClearButton,
          //                 advanceStatus: widget.advanceStatus,
          //               ),
          //             ],
          //           ),
          //         )
          //       : const SizedBox(),
          // ),
        ),
        body: SafeArea(
            child: DevoteeListBodyPage(
          status: widget.status,
          pageFrom: widget.pageFrom,
          searchValue: widget.searchValue,
          searchBy: widget.searchBy,
          devoteeList: widget.devoteeList,
        )),
      ),
    );
  }
}
