import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

import 'package:sdp/screen/user/user_tableview.dart';

class UserDashboard extends StatefulWidget {
  UserDashboard({Key? key, required this.devoteeId});
  String devoteeId;
  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  List<DevoteeModel> allDevotee = [];

  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
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
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: CreateDelegateButton(role: "User"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(18.0),
                    child: LogoutButton(),
                  )
                ]),
            tablet: ResponsiveAppBar(role: "User"),
            mobile: ResponsiveAppBar(role: "User"),
          ),
        ),
        body: FutureBuilder(
          future: GetDevoteeAPI().devoteeListBycreatedById(
            widget.devoteeId,
            1,
            RemoteConfigHelper().getDataCountPerPage,
          ),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if ((snapshot.connectionState == ConnectionState.waiting) ||
                snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              List<DevoteeModel> devotees = snapshot.data["data"];
              return UserTableView(
                devoteeList: devotees,
              );
            }
          },
        ),
        //drawer: const AppDrawer(),
      ),
    );
  }
}
