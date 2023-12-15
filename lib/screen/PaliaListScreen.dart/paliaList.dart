// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaScreenBody.dart';


class PaliaListPage extends StatefulWidget {
  PaliaListPage({Key? key, required this.status, required this.pageFrom, this.searchValue}) : super(key: key);
 String status;
  String pageFrom;
  String? searchValue;
  @override
  State<PaliaListPage> createState() => _PaliaListPageState();
}

class _PaliaListPageState extends State<PaliaListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        title: TitleAppBar(),
        actions: const [ActionWidget()],
      ),
      body: SafeArea(child: PaliaListBodyPage(status: widget.status,pageFrom: widget.pageFrom,searchValue: widget.searchValue,)),
    );
  }
}
