// ignore_for_file: must_be_immutable, unnecessary_null_comparison, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/constant/print_image.dart';
import 'package:sdp/model/dashboard_card_model.dart';
import 'package:sdp/model/update_timing_model.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/leadingImage.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/utilities/network_helper.dart';

class PuneSammilaniDetails extends StatefulWidget {
  const PuneSammilaniDetails({super.key, this.onTap});

  final void Function(List<String> dates)? onTap;

  @override
  State<PuneSammilaniDetails> createState() => _PuneSammilaniDetailsState();
}

String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
String yesterdayDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().subtract(const Duration(days: 1)));
String dayBeforeYesterdayDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().subtract(const Duration(days: 2)));

class _PuneSammilaniDetailsState extends State<PuneSammilaniDetails> {
  DateTime? selectedDate1;
  DateTime? selectedDate2;
  DateTime? selectedDate3;
  bool ispressed = false;
  List<DashboardStatusModel> allDevotees = [];
  List<DashboardStatusModel> prasadCountData1 = [],
      prasadCountData2 = [],
      prasadCountData3 = [];
  List<DashboardStatusModel> emptyTitleData = [];
  List<DashboardStatusModel> data = [];
  bool isLoading = true;
  String? prasadTiming;
  Map<String, dynamic>? responseData;
  @override
  void initState() {
    super.initState();
    adminData();
    timingData();
  }

  Future<void> _selectToday(
    BuildContext context,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // Check if the picked date is not equal to selectedDate1 and data[9].title
      if (picked != selectedDate1 &&
          picked != DateTime.parse(data[11].title ?? '') &&
          picked != selectedDate2 &&
          picked != selectedDate3 &&
          picked != DateTime.parse(data[10].title ?? '') &&
          picked != DateTime.parse(data[9].title ?? '')) {
        setState(() {
          selectedDate1 = picked;
          ispressed = true;
          NetworkHelper().setSelectedPrasadDate = DateFormat('yyyy-MM-dd')
              .format(selectedDate1 as DateTime)
              .toString();
        });
        await selectDateCount(
          DateFormat('yyyy-MM-dd').format(selectedDate1 as DateTime),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Please select a different date.'),
          ),
        );
      }
    }
  }

  Future<void> _selectYesterday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 1)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // Check if the picked date is not equal to selectedDate1 and data[9].title
      if (picked != selectedDate2 &&
          picked != DateTime.parse(data[11].title ?? '') &&
          picked != selectedDate1 &&
          picked != selectedDate3 &&
          picked != DateTime.parse(data[10].title ?? '') &&
          picked != DateTime.parse(data[9].title ?? '')) {
        setState(() {
          selectedDate2 = picked;
          ispressed = true;
          NetworkHelper().setSelectedPrasadDate = DateFormat('yyyy-MM-dd')
              .format(selectedDate2 as DateTime)
              .toString();
        });
        await selectDateCount(
          DateFormat('yyyy-MM-dd').format(selectedDate2 as DateTime),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Please select a different date.'),
          ),
        );
      }
    }
  }

  Future<void> _selectDayBeforeYesterday(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 2)),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      // Check if the picked date is not equal to selectedDate1 and data[9].title
      if (picked != selectedDate2 &&
          picked != DateTime.parse(data[11].title ?? '') &&
          picked != selectedDate1 &&
          picked != selectedDate3 &&
          picked != DateTime.parse(data[10].title ?? '') &&
          picked != DateTime.parse(data[9].title ?? '')) {
        setState(() {
          selectedDate3 = picked;
          NetworkHelper().setSelectedPrasadDate = DateFormat('yyyy-MM-dd')
              .format(selectedDate3 as DateTime)
              .toString();
          ispressed = true;
        });
        await selectDateCount(
          DateFormat('yyyy-MM-dd').format(selectedDate3 as DateTime),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.blue,
            content: Text('Please select a different date.'),
          ),
        );
      }
    }
  }

  adminData() async {
    try {
      setState(() {
        isLoading = true;
      });

      Map<String, dynamic>? response = await GetDevoteeAPI().adminDashboard();

      final responseData = response?["data"] as List<dynamic>;

      for (int i = 0; i < responseData.length; i++) {
        data.add(DashboardStatusModel.fromMap(responseData[i]));
      }

      for (var dashboardData in data) {
        if (dashboardData.title == "") {
          emptyTitleData.add(dashboardData);
        } else if (dashboardData.title == data[9].title) {
          prasadCountData1.add(dashboardData);
        } else if (dashboardData.title == data[10].title) {
          prasadCountData2.add(dashboardData);
        } else if (dashboardData.title == data[11].title) {
          prasadCountData3.add(dashboardData);
        }
      }
      NetworkHelper().setSelectedPrasadDate =
          prasadCountData1[0].title.toString();
      NetworkHelper().setSelectedPrasadDate =
          prasadCountData2[0].title.toString();
      NetworkHelper().setSelectedPrasadDate =
          prasadCountData3[0].title.toString();
      print("network helper date: ${NetworkHelper().getSelectedPrasadDate}");
      widget.onTap!(NetworkHelper().getSelectedPrasadDate);
    } catch (error) {
      print("Error fetching data: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  timingData() async {
    try {
      Map<String, dynamic>? response = await GetDevoteeAPI().updateTiming();
      responseData = response["data"];
    } catch (error) {
      // Handle errors
      print("Error fetching data: $error");
    } finally {}
  }

  selectDateCount(String date) async {
    List<DashboardStatusModel> data = [];
    Map<String, dynamic> response =
        await GetDevoteeAPI().prasadCountBySelectdate(date);

    setState(() {
      for (int i = 0; i < response["data"].length; i++) {
        data.add(DashboardStatusModel.fromMap(response["data"][i]));
      }

      if (data[0].title ==
          DateFormat('yyyy-MM-dd').format(selectedDate1 as DateTime)) {
        prasadCountData1 = data;
      } else if (data[0].title ==
          DateFormat('yyyy-MM-dd').format(selectedDate2 as DateTime)) {
        prasadCountData2 = data;
      } else {
        prasadCountData3 = data;
      }
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: isLoading == true
  //         ? const Center(
  //             child: CircularProgressIndicator(
  //               color: Colors.blue,
  //             ),
  //           )
  //         : SingleChildScrollView(
  //             scrollDirection: Axis.vertical,
  //             child: Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: SizedBox(
  //                 height: MediaQuery.of(context).size.height,
  //                 width: MediaQuery.of(context).size.width,
  //                 child: Column(
  //                   children: [
  //                     Expanded(
  //                         child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount: emptyTitleData.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Padding(
  //                             padding: const EdgeInsets.only(right: 8.0),
  //                             child: InkWell(
  //                               highlightColor:
  //                                   const Color.fromARGB(255, 0, 0, 0),
  //                               onTap:
  //                                   (NetworkHelper().getCurrentDevotee?.role ==
  //                                                   "Approver" &&
  //                                               (index != 1) ||
  //                                           NetworkHelper()
  //                                                   .getCurrentDevotee
  //                                                   ?.role ==
  //                                               "Viewer")
  //                                       ? null
  //                                       : () {
  //                                           Navigator.push(context,
  //                                               MaterialPageRoute(
  //                                             builder: (context) {
  //                                               return DevoteeListPage(
  //                                                 pageFrom: "Dashboard",
  //                                                 status: emptyTitleData[index]
  //                                                         .status ??
  //                                                     "",
  //                                               );
  //                                             },
  //                                           ));
  //                                         },
  //                               child: Card(
  //                                   color: (NetworkHelper()
  //                                                       .getCurrentDevotee
  //                                                       ?.role ==
  //                                                   "Approver" &&
  //                                               (index != 1) ||
  //                                           NetworkHelper()
  //                                                   .getCurrentDevotee
  //                                                   ?.role ==
  //                                               "Viewer")
  //                                       ? const Color.fromARGB(
  //                                           255, 216, 216, 216)
  //                                       : Colors.yellowAccent,
  //                                   child: DashBoardData(
  //                                       dashBoardDevoteeData:
  //                                           emptyTitleData[index])),
  //                             ));
  //                       },
  //                     )),
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.start,
  //                       children: [
  //                         NetworkHelper().getCurrentDevotee?.role ==
  //                                 "SuperAdmin"
  //                             ? ElevatedButton(
  //                                 onPressed: () => _selectToday(context),
  //                                 style: ElevatedButton.styleFrom(
  //                                   backgroundColor:
  //                                       Colors.yellowAccent, // Background color
  //                                   foregroundColor: Colors.black, // Text color
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                 ),
  //                                 child: const Text(
  //                                   "Select Date",
  //                                   style:
  //                                       TextStyle(fontWeight: FontWeight.bold),
  //                                 ),
  //                               )
  //                             : const SizedBox(),
  //                         const SizedBox(width: 10),
  //                         Text(
  //                           "${prasadCountData1[0].title}",
  //                           style: const TextStyle(
  //                               fontSize: 18,
  //                               color: Colors.black,
  //                               fontWeight: FontWeight.bold),
  //                         ),
  //                       ],
  //                     ),
  //                     const Divider(thickness: 1),
  //                     Expanded(
  //                       child: ListView.builder(
  //                         scrollDirection: Axis.horizontal,
  //                         itemCount: prasadCountData1.length,
  //                         itemBuilder: (BuildContext context, int index) {
  //                           return Padding(
  //                             padding: const EdgeInsets.all(
  //                                 5.0), // Adjust spacing between items
  //                             child: Card(
  //                               color: Colors.yellowAccent,
  //                               child: SizedBox(
  //                                 height: 500,
  //                                 width: 400,
  //                                 child: DashBoardPrasadData(
  //                                     dashBoardDevoteeData:
  //                                         prasadCountData1[index]),
  //                               ),
  //                             ),
  //                           );
  //                         },
  //                       ),
  //                     ),
  //                     Row(
  //                       children: [
  //                         NetworkHelper().getCurrentDevotee?.role ==
  //                                 "SuperAdmin"
  //                             ? ElevatedButton(
  //                                 onPressed: () => _selectYesterday(context),
  //                                 style: ElevatedButton.styleFrom(
  //                                   backgroundColor:
  //                                       Colors.yellowAccent, // Background color
  //                                   foregroundColor: Colors.black, // Text color
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                 ),
  //                                 child: const Text(
  //                                   "Select Date",
  //                                   style:
  //                                       TextStyle(fontWeight: FontWeight.bold),
  //                                 ),
  //                               )
  //                             : const SizedBox(),
  //                         const SizedBox(width: 10),
  //                         Text(
  //                           "${prasadCountData2[0].title}",
  //                           style: const TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ],
  //                     ),
  //                     const Divider(thickness: 1),
  //                     Expanded(
  //                         child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount: prasadCountData2.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Padding(
  //                             padding: const EdgeInsets.only(
  //                                 right: 8.0), // Adjust spacing between items
  //                             child: InkWell(
  //                               highlightColor:
  //                                   const Color.fromARGB(255, 0, 0, 0),
  //                               onTap: null,
  //                               child: Card(
  //                                   color: Colors.yellowAccent,
  //                                   child: DashBoardPrasadData(
  //                                       dashBoardDevoteeData:
  //                                           prasadCountData2[index])),
  //                             ));
  //                       },
  //                     )),
  //                     Row(
  //                       children: [
  //                         NetworkHelper().getCurrentDevotee?.role ==
  //                                 "SuperAdmin"
  //                             ? ElevatedButton(
  //                                 onPressed: () =>
  //                                     _selectDayBeforeYesterday(context),
  //                                 style: ElevatedButton.styleFrom(
  //                                   backgroundColor:
  //                                       Colors.yellowAccent, // Background color
  //                                   foregroundColor: Colors.black, // Text color
  //                                   shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(10.0),
  //                                   ),
  //                                 ),
  //                                 child: const Text(
  //                                   "Select Date",
  //                                   style:
  //                                       TextStyle(fontWeight: FontWeight.bold),
  //                                 ),
  //                               )
  //                             : const SizedBox(),
  //                         const SizedBox(width: 10),
  //                         Text(
  //                           "${prasadCountData3[0].title}",
  //                           style: const TextStyle(
  //                               fontSize: 18, fontWeight: FontWeight.bold),
  //                         ),
  //                       ],
  //                     ),
  //                     const Divider(thickness: 1),
  //                     Expanded(
  //                         child: ListView.builder(
  //                       scrollDirection: Axis.horizontal,
  //                       itemCount: prasadCountData3.length,
  //                       itemBuilder: (BuildContext context, int index) {
  //                         return Padding(
  //                             padding: const EdgeInsets.only(
  //                                 right: 8.0), // Adjust spacing between items
  //                             child: InkWell(
  //                               highlightColor:
  //                                   const Color.fromARGB(255, 0, 0, 0),
  //                               onTap: null,
  //                               child: Card(
  //                                   color: Colors.yellowAccent,
  //                                   child: DashBoardPrasadData(
  //                                       dashBoardDevoteeData:
  //                                           prasadCountData3[index])),
  //                             ));
  //                       },
  //                     )),
  //                     ispressed == true
  //                         ? ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                               backgroundColor: Colors.deepOrange,
  //                               foregroundColor: Colors.white,
  //                               shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(10.0),
  //                               ),
  //                             ),
  //                             onPressed: () async {
  //                               UpadateTimeModel updateDate = UpadateTimeModel(
  //                                 balyaStartTime:
  //                                     responseData?["balyaStartTime"],
  //                                 balyaEndTime: responseData?["balyaEndTime"],
  //                                 madhyanaStartTime:
  //                                     responseData?["madhyanaStartTime"],
  //                                 madhyanaEndTime:
  //                                     responseData?["madhyanaEndTime"],
  //                                 ratraStartTime:
  //                                     responseData?["ratraStartTime"],
  //                                 ratraEndTime: responseData?["ratraEndTime"],
  //                                 prasadFirstDate: selectedDate1 != null
  //                                     ? DateFormat('yyyy-MM-dd')
  //                                         .format(selectedDate1 as DateTime)
  //                                     : prasadCountData1[0].title,
  //                                 prasadSecondDate: selectedDate2 != null
  //                                     ? DateFormat('yyyy-MM-dd')
  //                                         .format(selectedDate2 as DateTime)
  //                                     : prasadCountData2[0].title,
  //                                 prasadThirdDate: selectedDate3 != null
  //                                     ? DateFormat('yyyy-MM-dd')
  //                                         .format(selectedDate3 as DateTime)
  //                                     : prasadCountData3[0].title,
  //                               );

  //                               //print("query : $updateDate");

  //                               await PutDevoteeAPI().updateTiming(updateDate);

  //                               ScaffoldMessenger.of(context).showSnackBar(
  //                                 const SnackBar(
  //                                   content:
  //                                       Text('Date selected successfully!'),
  //                                   duration: Duration(seconds: 2),
  //                                 ),
  //                               );

  //                               Navigator.push(
  //                                 context,
  //                                 MaterialPageRoute(
  //                                     builder: (context) => DashboardPage()),
  //                               );
  //                             },
  //                             child: const Text("Confirm"),
  //                           )
  //                         : const SizedBox()
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: emptyTitleData.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: InkWell(
                                highlightColor:
                                    const Color.fromARGB(255, 0, 0, 0),
                                onTap:
                                    (NetworkHelper().getCurrentDevotee?.role ==
                                                    "Approver" &&
                                                (index != 1) ||
                                            NetworkHelper()
                                                    .getCurrentDevotee
                                                    ?.role ==
                                                "Viewer")
                                        ? null
                                        : () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                              builder: (context) {
                                                return DevoteeListPage(
                                                  pageFrom: "Dashboard",
                                                  status: emptyTitleData[index]
                                                          .status ??
                                                      "",
                                                );
                                              },
                                            ));
                                          },
                                child: Card(
                                    color: (NetworkHelper()
                                                        .getCurrentDevotee
                                                        ?.role ==
                                                    "Approver" &&
                                                (index != 1) ||
                                            NetworkHelper()
                                                    .getCurrentDevotee
                                                    ?.role ==
                                                "Viewer")
                                        ? const Color.fromARGB(
                                            255, 216, 216, 216)
                                        : Colors.yellowAccent,
                                    child: DashBoardData(
                                        dashBoardDevoteeData:
                                            emptyTitleData[index])),
                              ));
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        NetworkHelper().getCurrentDevotee?.role == "SuperAdmin"
                            ? ElevatedButton(
                                onPressed: () => _selectToday(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.yellowAccent, // Background color
                                  foregroundColor: Colors.black, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  "Select Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 10),
                        Text(
                          "${prasadCountData1[0].title}",
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prasadCountData1.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(
                                5.0), // Adjust spacing between items
                            child: Card(
                              color: Colors.yellowAccent,
                              child: SizedBox(
                                width: 230,
                                child: DashBoardPrasadData(
                                    dashBoardDevoteeData:
                                        prasadCountData1[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      children: [
                        NetworkHelper().getCurrentDevotee?.role == "SuperAdmin"
                            ? ElevatedButton(
                                onPressed: () => _selectYesterday(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.yellowAccent, // Background color
                                  foregroundColor: Colors.black, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  "Select Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 10),
                        Text(
                          "${prasadCountData2[0].title}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prasadCountData2.length,
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
                                    child: SizedBox(
                                      width: 230,
                                      child: DashBoardPrasadData(
                                          dashBoardDevoteeData:
                                              prasadCountData2[index]),
                                    )),
                              ));
                        },
                      ),
                    ),
                    Row(
                      children: [
                        NetworkHelper().getCurrentDevotee?.role == "SuperAdmin"
                            ? ElevatedButton(
                                onPressed: () =>
                                    _selectDayBeforeYesterday(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.yellowAccent, // Background color
                                  foregroundColor: Colors.black, // Text color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Text(
                                  "Select Date",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            : const SizedBox(),
                        const SizedBox(width: 10),
                        Text(
                          "${prasadCountData3[0].title}",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(thickness: 1),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: prasadCountData3.length,
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
                                    child: SizedBox(
                                      width: 230,
                                      child: DashBoardPrasadData(
                                          dashBoardDevoteeData:
                                              prasadCountData3[index]),
                                    )),
                              ));
                        },
                      ),
                    ),
                    ispressed == true
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            onPressed: () async {
                              UpadateTimeModel updateDate = UpadateTimeModel(
                                balyaStartTime: responseData?["balyaStartTime"],
                                balyaEndTime: responseData?["balyaEndTime"],
                                madhyanaStartTime:
                                    responseData?["madhyanaStartTime"],
                                madhyanaEndTime:
                                    responseData?["madhyanaEndTime"],
                                ratraStartTime: responseData?["ratraStartTime"],
                                ratraEndTime: responseData?["ratraEndTime"],
                                prasadFirstDate: selectedDate1 != null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(selectedDate1 as DateTime)
                                    : prasadCountData1[0].title,
                                prasadSecondDate: selectedDate2 != null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(selectedDate2 as DateTime)
                                    : prasadCountData2[0].title,
                                prasadThirdDate: selectedDate3 != null
                                    ? DateFormat('yyyy-MM-dd')
                                        .format(selectedDate3 as DateTime)
                                    : prasadCountData3[0].title,
                              );

                              //print("query : $updateDate");

                              await PutDevoteeAPI().updateTiming(updateDate);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Date selected successfully!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashboardPage()),
                              );
                            },
                            child: const Text("Confirm"),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
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
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            "(${dashBoardDevoteeData.translate.toString()})",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Text(
            dashBoardDevoteeData.count.toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class DashBoardPrasadData extends StatelessWidget {
  DashBoardPrasadData({super.key, required this.dashBoardDevoteeData});

  DashboardStatusModel dashBoardDevoteeData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: 50),
          Text(
            "${dashBoardDevoteeData.message}   (${dashBoardDevoteeData.translate})",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          //
          Text(
            dashBoardDevoteeData.count.toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const Text(
            "------------------------",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Text(
                    "Online",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //
                  Text(
                    "${dashBoardDevoteeData.online}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  const Text(
                    "Offline",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  //
                  Text(
                    "${dashBoardDevoteeData.offline}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
          const SizedBox(width: 50),
        ],
      ),
    );
  }
}
