// ignore_for_file: file_names, must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/firebase/firebase_auth_api.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/appBar/action_widget.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_body_page.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/utilities/network_helper.dart';

class DevoteeListPage extends StatefulWidget {
  DevoteeListPage(
      {Key? key,
      required this.status,
      this.advanceStatus,
      this.pageFrom,
      this.devoteeList,
      this.searchValue,
      this.showClearButton,
      this.searchBy})
      : super(key: key);
  String status;
  String? advanceStatus;
  String? pageFrom;
  List<DevoteeModel>? devoteeList;
  String? searchValue;
  String? searchBy;
  bool? showClearButton;

  @override
  State<DevoteeListPage> createState() => _DevoteeListPageState();
}

class _DevoteeListPageState extends State<DevoteeListPage> {
  List<String>? selectedPalia;

  IconData _getIconForMenuOption(MenuOption option) {
    switch (option) {
      case MenuOption.home:
        return Icons.home;
      case MenuOption.createdByMe:
        return Icons.card_membership_rounded;
      case MenuOption.create:
        return Icons.card_membership_rounded;
      case MenuOption.logout:
        return Icons.logout_rounded;
    }
  }

  MenuOption? selectedMenu;

  MenuOption option = MenuOption.create;

  List<DevoteeModel> allDevoteesCreatedByMe = [];

  Future<void> fetchDelegatesByMe() async {
    var currentUser = NetworkHelper().currentDevotee;
    var allDevotees = await GetDevoteeAPI()
        .devoteeListBycreatedById(currentUser?.createdById.toString() ?? "");
    if (allDevotees != null) {
      print("all devotee by me length: ${allDevotees["data"].length}");
      setState(() {
        for (int i = 0; i < allDevotees["data"].length; i++) {
          allDevoteesCreatedByMe.add(allDevotees["data"][i]);
        }
      });
    } else {
      print("No delegates by me !");
    }
  }

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
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Center(
                  child: AppbarActionButtonWidget(
                    searchBy: widget.searchBy,
                    searchValue: widget.searchValue,
                    showClearButton: widget.showClearButton,
                    advanceStatus: widget.advanceStatus,
                  ),
                ),
              ),
              actions: [
                PopupMenuButton<MenuOption>(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                  ),
                  onSelected: (MenuOption value) async {
                    switch (value) {
                      case MenuOption.home:
                        if (NetworkHelper().currentDevotee?.role != "User") {
                          // change to hide home menu later for userdashboard
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardPage()),
                          );
                        }

                        break;
                      case MenuOption.createdByMe:
                        await fetchDelegatesByMe();
                        if (context.mounted) {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DevoteeListPage(
                                pageFrom: "Dashboard",
                                status: "allDevotee",
                                devoteeList: allDevoteesCreatedByMe,
                              );
                            },
                          ));
                        }
                        break;
                      case MenuOption.create:
                        // ignore: use_build_context_synchronously
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Create Delegate'),
                                    IconButton(
                                        color: Colors.deepOrange,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.deepOrange,
                                        ))
                                  ],
                                ),
                                content: AddPageDilouge(
                                  title: "addDevotee",
                                  devoteeId: "",
                                  role: NetworkHelper().currentDevotee?.role,
                                  //onUpdateDevotee: (allDevotees) {},
                                ));
                          },
                        );
                        break;
                      case MenuOption.logout:
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Thank You'),
                                IconButton(
                                    color: const Color(0XFF3f51b5),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.close))
                              ],
                            ),
                            content: const Text('Do You Want to Logout?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  FirebaseAuthentication().signOut();
                                  //Networkhelper().setCurrentDevotee = DevoteeModel();
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return const EmailSignIn();
                                    },
                                  ));
                                  // Navigator.popUntil(context, (route) => route.isFirst);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      MenuOption.values.map((MenuOption option) {
                    return PopupMenuItem<MenuOption>(
                      value: option,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            _getIconForMenuOption(option),
                            color: Colors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(option.value),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
              // actions: [
              //   AppbarActionButtonWidget(
              // searchBy: widget.searchBy,
              // searchValue: widget.searchValue,
              // showClearButton: widget.showClearButton,
              // advanceStatus: widget.advanceStatus,
              //   ),
              // ],
            ),
            tablet: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: const TitleAppBar(),
              actions: [
                AppbarActionButtonWidget(
                  searchBy: widget.searchBy,
                  searchValue: widget.searchValue,
                  showClearButton: widget.showClearButton,
                  advanceStatus: widget.advanceStatus,
                ),
              ],
            ),
            mobile: ResponsiveAppBar(
              searchBy: widget.searchBy,
              searchValue: widget.searchValue,
              showClearButton: widget.showClearButton,
              advanceStatus: widget.advanceStatus,
            ),
          ),
        ),
        body: SafeArea(
            child: DevoteeListBodyPage(
          status: widget.status,
          pageFrom: widget.pageFrom,
          searchValue: widget.searchValue,
          searchBy: widget.searchBy,
          showClearButton: widget.showClearButton,
          devoteeList: widget.devoteeList,
        )),
      ),
    );
  }
}
