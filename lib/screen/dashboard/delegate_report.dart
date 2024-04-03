import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/dashboard/appcolors.dart';
import 'package:sdp/screen/dashboard/bargraph.dart';
import 'package:sdp/screen/dashboard/bargraph_2.dart';
import 'package:sdp/screen/dashboard/report_table.dart';

class DelegateReportScreen extends StatefulWidget {
  DelegateReportScreen({super.key});

  @override
  State<StatefulWidget> createState() => DelegateReportScreenState();
}

class DelegateReportScreenState extends State<DelegateReportScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Delegate Report',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'In Table view'),
                Tab(text: 'In Graph Visualisation'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Contents of Tab 1
                  Center(
                    child: ReportTable(),
                  ),
                  // Contents of Tab 2
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          // Expanded(child: Bargraph2()),
                          // Expanded(child: Bargraph()),
                          Container(
                            height: 700,
                            width: 800,
                            child: Expanded(child: Bargraph2()),
                          ),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                width: 38,
                              ),
                              Text(
                                'Online Delegate Pranami',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              SizedBox(
                                width: 38,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                color: Color.fromARGB(255, 198, 9, 211),
                              ),
                              SizedBox(
                                width: 38,
                              ),
                              Text(
                                'Cash Delegate Pranami',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ),
                              SizedBox(
                                width: 38,
                              ),
                              Container(
                                height: 50,
                                width: 50,
                                color: Color.fromARGB(255, 239, 88, 98),
                              ),
                            ],
                          ),
                          Container(
                            height: 700,
                            width: 800,
                            child: Expanded(child: Bargraph()),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
