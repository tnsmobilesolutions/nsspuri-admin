// ignore_for_file: must_be_immutable, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/firebase/firebase_auth_api.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/appBar/action_widget.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/appBar/responsive_action_widget.dart';
import 'package:sdp/screen/dashboard/dashboardBody.dart';
import 'package:sdp/utilities/network_helper.dart';

enum MenuOption {
  home,
  createdByMe,
  create,
  logout,
}

extension MenuOptionExtension on MenuOption {
  String get value {
    switch (this) {
      case MenuOption.home:
        return 'Home';
      case MenuOption.createdByMe:
        return 'Created By Me';
      case MenuOption.create:
        return 'Create Delegate';
      case MenuOption.logout:
        return 'Logout';
    }
  }
}

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  List<String>? selectedPalia;

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
              actions: [AppbarActionButtonWidget()],
            ),
            tablet: ResponsiveAppBar(),
            mobile: ResponsiveAppBar(),
          ),
        ),
        body: const SafeArea(
          child: DashboardBody(),
        ),
        //drawer: const AppDrawer(),
      ),
    );
  }
}

class ResponsiveAppBar extends StatefulWidget {
  ResponsiveAppBar(
      {super.key,
      this.advanceStatus,
      this.searchBy,
      this.searchValue,
      this.role,
      this.showClearButton});
  String? searchValue;
  String? searchBy;
  String? advanceStatus;
  String? role;
  bool? showClearButton;

  @override
  State<ResponsiveAppBar> createState() => _ResponsiveAppBarState();
}

class _ResponsiveAppBarState extends State<ResponsiveAppBar> {
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
    return AppBar(
      toolbarHeight: 200,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: widget.showClearButton == true
          ? const SizedBox()
          : const TitleAppBarMobile(),
      actions: [
        PopupMenuButton<MenuOption>(
          icon: const Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          onSelected: (MenuOption value) async {
            switch (value) {
              case MenuOption.home:
                if (widget.role != "User") {
                  // change to hide home menu later for userdashboard
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardPage()),
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
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          role: widget.role,
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
                        onPressed: () => Navigator.pop(context, 'Cancel'),
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
      bottom: widget.role != "User"
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: ResponsiveAppbarActionButtonWidget(
                advanceStatus: widget.advanceStatus,
                searchBy: widget.searchBy,
                searchValue: widget.searchValue,
                showClearButton: widget.showClearButton,
              ),
            )
          : null,
    );
  }

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
}

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text(
//               'App Drawer',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 24,
//               ),
//             ),
//           ),
//           ListTile(
//             leading: const Icon(Icons.home),
//             title: const Text('Home'),
//             onTap: () {
//               // Handle the Home option
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.settings),
//             title: const Text('Create Delegate'),
//             onTap: () {
//               // Handle the Settings option
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.help),
//             title: const Text('Logout'),
//             onTap: () {
//               // Handle the Help option
//               Navigator.pop(context); // Close the drawer
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
