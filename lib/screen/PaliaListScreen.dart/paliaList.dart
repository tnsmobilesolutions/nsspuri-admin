// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaScreenBody.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

class PaliaListPage extends StatefulWidget {
  PaliaListPage({Key? key, required this.status}) : super(key: key);
  String status;
  @override
  State<PaliaListPage> createState() => _PaliaListPageState();
}

class _PaliaListPageState extends State<PaliaListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const LeadingImage(),
        automaticallyImplyLeading: false,
        title: TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DashboardPage();
              },
            ));
          },
          child: const Text(
            'nsspuri-admin',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        actions: const [ActionWidget()],
      ),
      body: SafeArea(child: PaliaListBodyPage(status: widget.status)),
    );
  }
}
