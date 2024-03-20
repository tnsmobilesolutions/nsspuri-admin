// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/constant/enums.dart';
import 'package:sdp/firebase/firebase_auth_api.dart';
import 'package:sdp/firebase/firebase_remote_config.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/appBar/action_widget.dart';
import 'package:sdp/screen/appBar/addPageDialouge.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/appBar/responsive_action_widget.dart';
import 'package:sdp/screen/dashboard/change_time.dart';
import 'package:sdp/screen/dashboard/dashboardBody.dart';
import 'package:sdp/screen/dashboard/delegate_report.dart';
import 'package:sdp/screen/dashboard/prasad_coupon.dart';
import 'package:sdp/utilities/network_helper.dart';

extension MenuOptionExtension on MenuOption {
  String get value {
    switch (this) {
      case MenuOption.home:
        return 'Home';
      case MenuOption.createdByMe:
        return 'Created By Me';
      case MenuOption.prasadCoupon:
        return 'Prasad Coupon';
      case MenuOption.create:
        return 'Create Delegate';
      case MenuOption.delegateReport:
        return 'Delegate Report';
      case MenuOption.settings:
        return 'Settings';
      case MenuOption.logout:
        return 'Logout';
    }
  }
}

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<DevoteeModel> allDevoteesCreatedByMe = [];
  MenuOption option = MenuOption.create;
  MenuOption? selectedMenu;
  List<String>? selectedPalia, selectedDates;
  int totalPages = 0, dataCount = 0, currentPage = 1;

  Future<void> fetchDelegatesByMe() async {
    // print("is ascending: ${NetworkHelper().getNameAscending}");
    // print("created by: ${NetworkHelper().currentDevotee}");
    var currentUser = NetworkHelper().currentDevotee;
    var allDevotees = await GetDevoteeAPI().devoteeListBycreatedById(
      currentUser?.devoteeId.toString() ?? "",
      1,
      RemoteConfigHelper().getDataCountPerPage,
      isAscending: NetworkHelper().getNameAscending,
    );
    if (allDevotees != null) {
      setState(() {
        for (int i = 0; i < allDevotees["data"].length; i++) {
          allDevoteesCreatedByMe.add(allDevotees["data"][i]);
        }
        print("all devotee : $allDevoteesCreatedByMe");

        totalPages = allDevotees["totalPages"];
        dataCount = allDevotees["count"];
        currentPage = allDevotees["currentPage"];
      });
      print("created by me from dashboard: ${allDevoteesCreatedByMe.length}");
    } else {
      print("No delegates by me !");
    }
  }

  IconData _getIconForMenuOption(MenuOption option) {
    switch (option) {
      case MenuOption.home:
        return Icons.home_outlined;
      case MenuOption.createdByMe:
        return Icons.card_membership_rounded;
      case MenuOption.prasadCoupon:
        return Icons.confirmation_num_outlined;
      case MenuOption.create:
        return Icons.card_membership_rounded;
      case MenuOption.delegateReport:
        return Icons.report_off_rounded;
      case MenuOption.settings:
        return Icons.settings_outlined;
      case MenuOption.logout:
        return Icons.logout_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(Responsive.isMobile(context) ? 150 : 70),
          child: Responsive(
            desktop: AppBar(
              toolbarHeight: 80,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: const Responsive(
                desktop: TitleAppBar(),
                tablet: TitleAppBar(),
                mobile: TitleAppBarMobile(),
              ),
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Center(
                  child: AppbarActionButtonWidget(
                    pageFrom: "Dashboard",
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardPage()),
                          );
                        }

                        break;
                      case MenuOption.createdByMe:
                        await fetchDelegatesByMe();
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return DevoteeListPage(
                              pageFrom: "Dashboard",
                              status: "allDevotee",
                              devoteeList: allDevoteesCreatedByMe,
                              totalPages: totalPages,
                              currentPage: currentPage,
                              dataCount: dataCount,
                            );
                          },
                        ));
                        break;
                      case MenuOption.prasadCoupon:
                        bool showCoupon = NetworkHelper()
                                    .currentDevotee
                                    ?.role ==
                                "PrasadScan" ||
                            NetworkHelper().currentDevotee?.role ==
                                "SecurityScan" ||
                            NetworkHelper().currentDevotee?.role ==
                                "PrasadAndSecurityScan" ||
                            NetworkHelper().currentDevotee?.role == "Admin" ||
                            NetworkHelper().currentDevotee?.role ==
                                "SuperAdmin";
                        if (context.mounted &&
                            showCoupon &&
                            selectedDates != null) {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.white,
                              icon: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      color: Colors.deepOrange,
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.deepOrange,
                                      )),
                                ],
                              ),
                              content: PrasadCoupon(
                                fromDashboard: true,
                                selectedDates: selectedDates,
                              ),
                            ),
                          );
                        }
                        break;
                      case MenuOption.create:
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
                      case MenuOption.delegateReport:
                        showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return DelegateReportScreen();
                          },
                        );
                        break;
                      case MenuOption.settings:
                        if (context.mounted &&
                            NetworkHelper().currentDevotee?.role ==
                                "SuperAdmin") {
                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Change Timing'),
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
                                content: const UpdateTime(),
                              );
                            },
                          );
                        }
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
                            color: option == MenuOption.prasadCoupon &&
                                    selectedDates == null
                                ? Colors.grey
                                : Colors.deepOrange,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            option.value,
                            style: TextStyle(
                              color: option == MenuOption.prasadCoupon &&
                                      selectedDates == null
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            tablet: ResponsiveAppBar(),
            mobile: ResponsiveAppBar(),
          ),
        ),
        body: SafeArea(
          child: DashboardBody(
            onTap: (dates) {
              setState(() {
                selectedDates = dates;
              });
            },
          ),
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

  String? advanceStatus;
  String? role;
  String? searchBy;
  String? searchValue;
  bool? showClearButton;

  @override
  State<ResponsiveAppBar> createState() => _ResponsiveAppBarState();
}

class _ResponsiveAppBarState extends State<ResponsiveAppBar> {
  List<DevoteeModel> allDevoteesCreatedByMe = [];
  MenuOption option = MenuOption.create;
  MenuOption? selectedMenu;
  int totalPages = 0, dataCount = 0, currentPage = 1;

  Future<void> fetchDelegatesByMe() async {
    var currentUser = NetworkHelper().currentDevotee;
    var allDevotees = await GetDevoteeAPI().devoteeListBycreatedById(
      currentUser?.devoteeId.toString() ?? "",
      1,
      RemoteConfigHelper().getDataCountPerPage,
      isAscending: NetworkHelper().getNameAscending,
    );
    if (allDevotees != null) {
      setState(() {
        for (int i = 0; i < allDevotees["data"].length; i++) {
          allDevoteesCreatedByMe.add(allDevotees["data"][i]);
        }
        totalPages = allDevotees["totalPages"];
        dataCount = allDevotees["count"];
        currentPage = allDevotees["currentPage"];
      });
      print("created by me from dashboard: ${allDevoteesCreatedByMe.length}");
    } else {
      print("No delegates by me !");
    }
  }

  IconData _getIconForMenuOption(MenuOption option) {
    switch (option) {
      case MenuOption.home:
        return Icons.home_outlined;
      case MenuOption.createdByMe:
        return Icons.card_membership_rounded;
      case MenuOption.prasadCoupon:
        return Icons.confirmation_num_outlined;
      case MenuOption.create:
        return Icons.card_membership_rounded;
      case MenuOption.delegateReport:
        return Icons.report_off_outlined;
      case MenuOption.settings:
        return Icons.settings_outlined;
      case MenuOption.logout:
        return Icons.logout_rounded;
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
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DevoteeListPage(
                      pageFrom: "Dashboard",
                      status: "allDevotee",
                      devoteeList: allDevoteesCreatedByMe,
                      totalPages: totalPages,
                      currentPage: currentPage,
                      dataCount: dataCount,
                    );
                  },
                ));
                break;
              case MenuOption.prasadCoupon:
                await fetchDelegatesByMe();
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return DevoteeListPage(
                      pageFrom: "Dashboard",
                      status: "allDevotee",
                      devoteeList: allDevoteesCreatedByMe,
                      totalPages: totalPages,
                      currentPage: currentPage,
                      dataCount: dataCount,
                    );
                  },
                ));
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
                          //onUpdateDevotee: (allDevotees) {},
                        ));
                  },
                );
                break;
              case MenuOption.delegateReport:
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return DelegateReportScreen();
                  },
                );
                break;
              case MenuOption.settings:
                if (context.mounted &&
                    NetworkHelper().currentDevotee?.role == "SuperAdmin") {
                  showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Change Timing'),
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
                          content: const UpdateTime());
                    },
                  );
                }
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
                    color: Colors.deepOrange,
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
}
