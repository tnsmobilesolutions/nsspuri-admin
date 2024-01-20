// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/dashboard_card_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/utilities/network_helper.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key});

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
String yesterdayDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().subtract(const Duration(days: 1)));
String dayBeforeYesterdayDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().subtract(const Duration(days: 2)));

class _DashboardBodyState extends State<DashboardBody> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetDevoteeAPI().adminDashboard(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: SizedBox(width: 100, child: LinearProgressIndicator()));
        } else if (snapshot.hasError) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final allDashboardData = snapshot.data["data"];
          List<DashboardStatusModel> emptyTitleData = [];
          List<DashboardStatusModel> todayDateData = [];
          List<DashboardStatusModel> yesterdayDatesData = [];
          List<DashboardStatusModel> dayBeforeYesterdayDatesData = [];

          String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
          String yesterdayDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(const Duration(days: 1)));
          String dayBeforeYesterdayDate = DateFormat('yyyy-MM-dd')
              .format(DateTime.now().subtract(const Duration(days: 2)));
          for (var item in allDashboardData) {
            DashboardStatusModel dashboarddata =
                DashboardStatusModel.fromMap(item);
            if (dashboarddata.title == "") {
              emptyTitleData.add(dashboarddata);
            } else if (dashboarddata.title == todayDate) {
              todayDateData.add(dashboarddata);
            } else if (dashboarddata.title == yesterdayDate) {
              yesterdayDatesData.add(dashboarddata);
            } else {
              dayBeforeYesterdayDatesData.add(dashboarddata);
            }
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: emptyTitleData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              highlightColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              onTap: NetworkHelper().getCurrentDevotee?.role ==
                                          "Approver" &&
                                      (index != 1)
                                  ? null
                                  : () {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return DevoteeListPage(
                                            pageFrom: "Dashboard",
                                            status:
                                                emptyTitleData[index].status ??
                                                    "",
                                          );
                                        },
                                      ));
                                    },
                              child: Card(
                                  color: NetworkHelper()
                                                  .getCurrentDevotee
                                                  ?.role ==
                                              "Approver" &&
                                          (index != 1)
                                      ? const Color.fromARGB(255, 216, 216, 216)
                                      : Colors.yellowAccent,
                                  child: DashBoardData(
                                      dashBoardDevoteeData:
                                          emptyTitleData[index])),
                            ));
                      },
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          todayDate,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis
                          .horizontal, // Set the scroll direction to horizontal
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0), // Adjust spacing between items
                            child: InkWell(
                              highlightColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              onTap: null,
                              child: Card(
                                  color: Colors.yellowAccent,
                                  child: DashBoardData(
                                      dashBoardDevoteeData:
                                          todayDateData[index])),
                            ));
                      },
                    )),
                    Row(
                      children: [
                        Text(
                          yesterdayDate,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis
                          .horizontal, // Set the scroll direction to horizontal
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0), // Adjust spacing between items
                            child: InkWell(
                              highlightColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              onTap: null,
                              child: Card(
                                  color: Colors.yellowAccent,
                                  child: DashBoardData(
                                      dashBoardDevoteeData:
                                          yesterdayDatesData[index])),
                            ));
                      },
                    )),
                    Row(
                      children: [
                        Text(
                          dayBeforeYesterdayDate,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis
                          .horizontal, // Set the scroll direction to horizontal
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0), // Adjust spacing between items
                            child: InkWell(
                              highlightColor:
                                  const Color.fromARGB(255, 0, 0, 0),
                              onTap: null,
                              child: Card(
                                  color: Colors.yellowAccent,
                                  child: DashBoardData(
                                      dashBoardDevoteeData:
                                          dayBeforeYesterdayDatesData[index])),
                            ));
                      },
                    )),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class DashBoardData extends StatelessWidget {
  DashBoardData({super.key, required this.dashBoardDevoteeData});
  DashboardStatusModel dashBoardDevoteeData;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            dashBoardDevoteeData.message.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "(${dashBoardDevoteeData.translate.toString()})",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            dashBoardDevoteeData.count.toString(),
            style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
