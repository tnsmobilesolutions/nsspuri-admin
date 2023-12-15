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
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 6, 36, 61),
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
