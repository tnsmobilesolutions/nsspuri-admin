// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/actionWidget.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/dashboard/dashboardBody.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  List<String>? selectedPalia;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff0064B4),
          toolbarHeight: Responsive.isDesktop(context)
              ? 120
              : Responsive.isLargeMobile(context)
                  ? 150
                  : 120,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const TitleAppBar(),
          actions: [
            Responsive.isLargeMobile(context)
                ? const SizedBox()
                : AppbarActionButtonWidget(),
          ],
          bottom: PreferredSize(
            preferredSize: Responsive.isLargeMobile(context)
                ? const Size.fromHeight(50)
                : const Size.fromHeight(0),
            child: Responsive.isLargeMobile(context)
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppbarActionButtonWidget(),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        body: const SafeArea(
          child: DashboardBody(),
        ),
      ),
    );
  }
}
