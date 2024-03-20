import 'package:flutter/material.dart';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';

// Define data structure for a bar group
class DataItem {
  final String yearName;
  final double y1;
  final double y2;

  DataItem({required this.yearName, required this.y1, required this.y2});
}

class DelegateReportScreen extends StatelessWidget {
  DelegateReportScreen({Key? key}) : super(key: key);

  // Generate dummy data to feed the chart
  final List<DataItem> _myData = [
    DataItem(
      yearName: '73rd Sammilani',
      y1: Random().nextInt(20) + Random().nextDouble(),
      y2: Random().nextInt(20) + Random().nextDouble(),
    ),
    DataItem(
      yearName: '74th Sammilani',
      y1: Random().nextInt(20) + Random().nextDouble(),
      y2: Random().nextInt(20) + Random().nextDouble(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delegate Report',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(
              border: const Border(
                top: BorderSide.none,
                right: BorderSide.none,
                left: BorderSide(width: 1),
                bottom: BorderSide(width: 1),
              ),
            ),
            groupsSpace: 10,
            barGroups: _myData.map((yearData) {
              return BarChartGroupData(
                x: 73,
                barsSpace: 4,
                barRods: [
                  BarChartRodData(
                      fromY: yearData.y1,
                      color: Colors.blue,
                      width: 70,
                      toY: 10000.00,
                      borderRadius: BorderRadius.zero),
                  BarChartRodData(
                      fromY: yearData.y2,
                      color: Colors.green,
                      width: 70,
                      toY: 10000.00,
                      borderRadius: BorderRadius.zero),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
