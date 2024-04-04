// ignore_for_file: must_be_immutable, unnecessary_null_comparison, avoid_print, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/constant/print_image.dart';
import 'package:sdp/model/dashboard_card_model.dart';
import 'package:sdp/model/update_timing_model.dart';
import 'package:sdp/screen/PaliaListScreen.dart/devotee_list_page.dart';
import 'package:sdp/screen/dashboard/Pune_sammilani_dashboard.dart';
import 'package:sdp/screen/dashboard/attendee_table.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/screen/dashboard/pune_sammilani.dart';
import 'package:sdp/screen/dashboard/puri_event.dart';
import 'package:sdp/utilities/network_helper.dart';

class DashboardBody extends StatefulWidget {
  const DashboardBody({super.key, this.onTap});

  final void Function(List<String> dates)? onTap;

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
String yesterdayDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().subtract(const Duration(days: 1)));
String dayBeforeYesterdayDate = DateFormat('yyyy-MM-dd')
    .format(DateTime.now().subtract(const Duration(days: 2)));

class _DashboardBodyState extends State<DashboardBody> {
  List<DashboardStatusModel> allDevotees = [];

  List<DashboardStatusModel> emptyTitleData = [];
  List<DashboardStatusModel> data = [];
  bool isLoading = true;
  String? prasadTiming;
  Map<String, dynamic>? responseData;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 400,
                    width: 400,
                    color: Colors.yellow,
                    child: InkWell(
                      highlightColor: const Color.fromARGB(255, 0, 0, 0),
                      onTap: (NetworkHelper().getCurrentDevotee?.role ==
                                  "Approver" &&
                              NetworkHelper().getCurrentDevotee?.role ==
                                  "Viewer")
                          ? null
                          : () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return PuneSammilaniDashboard();
                                },
                              ));
                            },
                      child: const Center(
                        child: Center(
                          child: Text(
                            'Pune Sammilani Details',
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Container(
                    height: 400,
                    width: 400,
                    color: Colors.yellow,
                    child: InkWell(
                      highlightColor: const Color.fromARGB(255, 0, 0, 0),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AttendeeTableScreen();
                          },
                        ));
                      },
                      child: const Center(
                        child: Center(
                          child: Text(
                            'Centenary Celebration At Puri On 14th April',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
