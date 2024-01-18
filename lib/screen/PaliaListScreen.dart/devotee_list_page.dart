// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/action_widget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_body_page.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

class DevoteeListPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Responsive.isMobile(context) ? 150 : 80),
          child: Responsive(
            desktop: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: const TitleAppBar(),
              actions: [
                AppbarActionButtonWidget(
                  searchBy: searchBy,
                  searchValue: searchValue,
                  showClearButton: showClearButton,
                  advanceStatus: advanceStatus,
                ),
              ],
            ),
            tablet: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: const TitleAppBar(),
              actions: [
                AppbarActionButtonWidget(
                  searchBy: searchBy,
                  searchValue: searchValue,
                  showClearButton: showClearButton,
                  advanceStatus: advanceStatus,
                ),
              ],
            ),
            mobile: ResponsiveAppBar(
              searchBy: searchBy,
              searchValue: searchValue,
              showClearButton: showClearButton,
              advanceStatus: advanceStatus,
            ),
          ),
        ),
        body: SafeArea(
            child: DevoteeListBodyPage(
          status: status,
          pageFrom: pageFrom,
          searchValue: searchValue,
          searchBy: searchBy,
          showClearButton: showClearButton,
          devoteeList: devoteeList,
        )),
      ),
    );
  }
}
