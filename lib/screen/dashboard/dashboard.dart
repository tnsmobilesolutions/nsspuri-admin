// ignore_for_file: must_be_immutable, avoid_print

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
          //backgroundColor: const Color(0xff0064B4),
          toolbarHeight: 80,
          // toolbarHeight: Responsive.isDesktop(context)
          //     ? 150
          //     : Responsive.isLargeMobile(context)
          //         ? 150
          //         : 120,
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: const TitleAppBar(),
          actions: [
            // PopupMenuButton<String>(
            //   icon: const Icon(
            //     Icons.more_vert,
            //     color: Colors.white,
            //   ),
            //   onSelected: (value) {
            //     // Handle the selected menu item
            //     print('Selected: $value');
            //   },
            //   itemBuilder: (BuildContext context) => [
            //     const PopupMenuItem<String>(
            //       value: 'Home',
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Text(
            //             'Home',
            //             //textAlign: TextAlign.right,
            //           ),
            //         ],
            //       ),
            //     ),
            //     const PopupMenuItem<String>(
            //       value: 'Create Delegate',
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Text('Create Delegate'),
            //         ],
            //       ),
            //     ),
            //     const PopupMenuItem<String>(
            //       value: 'Logout',
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.end,
            //         children: [
            //           Text('Logout'),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Responsive.isLargeMobile(context)
            //     ? const SizedBox()
            //     :
            AppbarActionButtonWidget(
              advanceStatus: null,
            ),
          ],
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
          //               AppbarActionButtonWidget(),
          //             ],
          //           ),
          //         )
          //       : const SizedBox(),
          // ),
        ),
        body: const SafeArea(
          child: DashboardBody(),
        ),
      ),
    );
  }
}
