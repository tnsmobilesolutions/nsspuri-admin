// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaScreenBody.dart';

class PaliaListPage extends StatefulWidget {
  PaliaListPage(
      {Key? key,
      required this.status,
      required this.pageFrom,
      this.devoteeList,
      this.searchValue,
      this.isResultEmpty,
      this.searchBy})
      : super(key: key);
  String status;
  String pageFrom;
  List<DevoteeModel>? devoteeList;
  String? searchValue;
  String? searchBy;
  bool? isResultEmpty;

  @override
  State<PaliaListPage> createState() => _PaliaListPageState();
}

class _PaliaListPageState extends State<PaliaListPage> {
  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 70,
          automaticallyImplyLeading: false,
          title: const TitleAppBar(),
          actions: [
            AppbarActionButtonWidget(
              searchBy: widget.searchBy,
              searchValue: widget.searchValue,
              isResultEmpty: widget.isResultEmpty,
            ),
          ],
        ),
        body: SafeArea(
            child: PaliaListBodyPage(
          status: widget.status,
          pageFrom: widget.pageFrom,
          searchValue: widget.searchValue,
          searchBy: widget.searchBy,
        )),
      ),
    );
  }
}
