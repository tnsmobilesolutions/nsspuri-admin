// // ignore_for_file: must_be_immutable

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:sdp/API/get_devotee.dart';
// import 'package:sdp/model/dashboard_card_model.dart';
// import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
// import 'package:sdp/utilities/network_helper.dart';

// class DashboardBody extends StatefulWidget {
//   const DashboardBody({super.key});

//   @override
//   State<DashboardBody> createState() => _DashboardBodyState();
// }

// class _DashboardBodyState extends State<DashboardBody> {
//   late DateTime selectedDate;
//   late List<DashboardStatusModel> todayDateData;
//   late List<DashboardStatusModel> yesterdayDatesData;
//   late List<DashboardStatusModel> dayBeforeYesterdayDatesData;

//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//     todayDateData = [];
//     yesterdayDatesData = [];
//     dayBeforeYesterdayDatesData = [];
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await GetDevoteeAPI().adminDashboard();
//       final allDashboardData = response?["data"];

//       todayDateData = filterDataByDate(allDashboardData, selectedDate);
//       // yesterdayDatesData = filterDataByDate(
//       //     allDashboardData, selectedDate.subtract(const Duration(days: 1)));
//       // dayBeforeYesterdayDatesData = filterDataByDate(
//       //     allDashboardData, selectedDate.subtract(const Duration(days: 2)));
//     } catch (e) {
//       print("Error fetching data: $e");
//     }
//   }

//   List<DashboardStatusModel> filterDataByDate(
//       List<dynamic> allData, DateTime date) {
//     final formattedDate = DateFormat('yyyy-MM-dd').format(date);
//     return allData
//         .map((item) => DashboardStatusModel.fromMap(item))
//         .where((data) => data.title == formattedDate)
//         .toList();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime picked = (await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     ))!;
//     if (picked != selectedDate) {
//       setState(() {
//         selectedDate = picked;
//       });
//       //fetchData();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: GetDevoteeAPI().adminDashboard(),
//       builder: (BuildContext context, AsyncSnapshot snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(
//               child: SizedBox(width: 100, child: LinearProgressIndicator()));
//         } else if (snapshot.hasError) {
//           return const Center(child: CircularProgressIndicator());
//         } else {
//           final allDashboardData = snapshot.data["data"];
//           List<DashboardStatusModel> emptyTitleData = [];
//           List<DashboardStatusModel> todayDateData = [];
//           List<DashboardStatusModel> yesterdayDatesData = [];
//           List<DashboardStatusModel> dayBeforeYesterdayDatesData = [];

//           String todayDate = DateFormat('yyyy-MM-dd').format(selectedDate);
//           String yesterdayDate = DateFormat('yyyy-MM-dd')
//               .format(DateTime.now().subtract(const Duration(days: 1)));
//           String dayBeforeYesterdayDate = DateFormat('yyyy-MM-dd')
//               .format(DateTime.now().subtract(const Duration(days: 2)));
//           for (var item in allDashboardData) {
//             DashboardStatusModel dashboarddata =
//                 DashboardStatusModel.fromMap(item);
//             if (dashboarddata.title == "") {
//               emptyTitleData.add(dashboarddata);
//             } else if (dashboarddata.title == todayDate) {
//               todayDateData.add(dashboarddata);
//               // } else if (dashboarddata.title == yesterdayDate) {
//               //   yesterdayDatesData.add(dashboarddata);
//               // } else {
//               //   dayBeforeYesterdayDatesData.add(dashboarddata);
//             }
//           }
//           return SingleChildScrollView(
//               child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: SizedBox(
//               height: 500,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Expanded(
//                       child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: emptyTitleData.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                           padding: const EdgeInsets.only(right: 8.0),
//                           child: InkWell(
//                             highlightColor: const Color.fromARGB(255, 0, 0, 0),
//                             onTap: Networkhelper().getCurrentDevotee?.role ==
//                                         "Approver" &&
//                                     (index != 1)
//                                 ? null
//                                 : () {
//                                     Navigator.push(context, MaterialPageRoute(
//                                       builder: (context) {
//                                         return DevoteeListPage(
//                                           pageFrom: "Dashboard",
//                                           status:
//                                               emptyTitleData[index].status ??
//                                                   "",
//                                         );
//                                       },
//                                     ));
//                                   },
//                             child: Card(
//                                 color: Networkhelper()
//                                                 .getCurrentDevotee
//                                                 ?.role ==
//                                             "Approver" &&
//                                         (index != 1)
//                                     ? const Color.fromARGB(255, 216, 216, 216)
//                                     : Colors.yellowAccent,
//                                 child: DashBoardData(
//                                     dashBoardDevoteeData:
//                                         emptyTitleData[index])),
//                           ));
//                     },
//                   )),
//                   SizedBox(height: 30),
//                   ElevatedButton(
//                     onPressed: () => _selectDate(context),
//                     child: const Text("Select Date"),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('yyyy-MM-dd').format(selectedDate),
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                   const Divider(
//                     thickness: 3,
//                   ),
//                   buildListView(todayDateData),
//                   // Row(
//                   //   children: [
//                   //     Text(
//                   //       DateFormat('yyyy-MM-dd').format(
//                   //           selectedDate.subtract(const Duration(days: 1))),
//                   //       style: const TextStyle(
//                   //           fontSize: 18, fontWeight: FontWeight.bold),
//                   //     ),
//                   //   ],
//                   // ),
//                   // const Divider(
//                   //   thickness: 3,
//                   // ),
//                   // buildListView(yesterdayDatesData),
//                   // Row(
//                   //   children: [
//                   //     Text(
//                   //       DateFormat('yyyy-MM-dd').format(
//                   //           selectedDate.subtract(const Duration(days: 2))),
//                   //       style: const TextStyle(
//                   //           fontSize: 18, fontWeight: FontWeight.bold),
//                   //     ),
//                   //   ],
//                   // ),
//                   // const Divider(
//                   //   thickness: 3,
//                   // ),
//                   // buildListView(dayBeforeYesterdayDatesData),
//                 ],
//               ),
//             ),
//           ));
//         }
//       },
//     );
//   }

//   Widget buildListView(List<DashboardStatusModel> data) {
//     return SizedBox(
//       height: 200.0, // Adjust the height as needed
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: data.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.only(right: 8.0),
//             child: InkWell(
//               onTap: Networkhelper().getCurrentDevotee?.role == "Approver" &&
//                       (index != 1)
//                   ? null
//                   : () {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return DevoteeListPage(
//                             pageFrom: "Dashboard",
//                             status: data[index].status ?? "",
//                           );
//                         },
//                       ));
//                     },
//               child: Card(
//                 color: Networkhelper().getCurrentDevotee?.role == "Approver" &&
//                         (index != 1)
//                     ? const Color.fromARGB(255, 216, 216, 216)
//                     : Colors.yellowAccent,
//                 child: DashBoardData(dashBoardDevoteeData: data[index]),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

// class DashBoardData extends StatelessWidget {
//   DashBoardData({super.key, required this.dashBoardDevoteeData});
//   DashboardStatusModel dashBoardDevoteeData;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Text(
//             dashBoardDevoteeData.message.toString(),
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             "(${dashBoardDevoteeData.translate.toString()})",
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             dashBoardDevoteeData.count.toString(),
//             style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
//           )
//         ],
//       ),
//     );
//   }
// }
