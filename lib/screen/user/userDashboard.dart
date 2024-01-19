import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_body_page.dart';
import 'package:sdp/screen/appBar/action_widget.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/screen/dashboard/dashboardBody.dart';
import 'package:sdp/screen/user/user_tableview.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({
    Key? key,
    this.status,
    this.devoteeList,
  });

  List<DevoteeModel>? devoteeList;
  bool? status;

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Responsive.isMobile(context) ? 150 : 80),
        child: Responsive(
          desktop: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: const TitleAppBar(),
              actions: [CreateDelegateButton(), LogoutButton()]),
          tablet: ResponsiveAppBar(),
          mobile: ResponsiveAppBar(),
        ),
      ),
      body: UserTableView(
        status: "allDevotee",
        pageFrom: 'Dashboard',
      ),
      //drawer: const AppDrawer(),
    );
  }
}
