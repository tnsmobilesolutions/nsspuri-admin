// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/dashboard/dashboardBody.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  List<String>? selectedPalia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xff0064B4),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: const TitleAppBar(),
        actions: const [ActionWidget()],
      ),
      body: const SafeArea(
        child: DashboardBody(),
      ),
    );
  }
}
