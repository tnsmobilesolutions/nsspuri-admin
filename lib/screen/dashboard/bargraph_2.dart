import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/dashboard/appcolors.dart';
import 'package:sdp/screen/dashboard/bargraph.dart';
import 'package:sdp/screen/dashboard/report_table.dart';

class Bargraph2 extends StatefulWidget {
  Bargraph2({super.key});
  final Color leftBarColor = Colors.blue;
  final Color rightBarColor = Colors.green;
  final Color avgColor = AppColors.contentColorRed;
  @override
  State<StatefulWidget> createState() => Bargraph2State();
}

class Bargraph2State extends State<Bargraph2> {
  final double width = 70;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);

    final items = [
      barGroup1,
      barGroup2,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        width: 38,
                      ),
                      Text(
                        'Delegate Pranami',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      SizedBox(
                        width: 38,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 38,
                      ),
                      Text(
                        'Prasad Coupon',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      SizedBox(
                        width: 38,
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.green,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: 20,
                        //                           // barTouchData: BarTouchData(
                        //                           //   touchTooltipData: BarTouchTooltipData(
                        //                           //     tooltipBgColor: Colors.grey,
                        //                           //     getTooltipItem: (a, b, c, d) => null,
                        //                           //   ),
                        //                           //   touchCallback: (FlTouchEvent event, response) {
                        //                           //     if (response == null || response.spot == null) {
                        //                           //       setState(() {
                        //                           //         touchedGroupIndex = -1;
                        //                           //         showingBarGroups = List.of(rawBarGroups);
                        //                           //       });
                        //                           //       return;
                        //                           //     }

                        //                           //     touchedGroupIndex =
                        //                           //         response.spot!.touchedBarGroupIndex;

                        //                           //     setState(() {
                        //                           //       if (!event.isInterestedForInteractions) {
                        //                           //         touchedGroupIndex = -1;
                        //                           //         showingBarGroups = List.of(rawBarGroups);
                        //                           //         return;
                        //                           //       }
                        //                           //       showingBarGroups = List.of(rawBarGroups);
                        //                           //       if (touchedGroupIndex != -1) {
                        //                           //         var sum = 0.0;
                        //                           //         for (final rod
                        //                           //             in showingBarGroups[touchedGroupIndex]
                        //                           //                 .barRods) {
                        //                           //           sum += rod.toY;
                        //                           //         }
                        //                           //         final avg = sum /
                        //                           //             showingBarGroups[touchedGroupIndex]
                        //                           //                 .barRods
                        //                           //                 .length;

                        //                           //         showingBarGroups[touchedGroupIndex] =
                        //                           //             showingBarGroups[touchedGroupIndex]
                        //                           //                 .copyWith(
                        //                           //           barRods: showingBarGroups[touchedGroupIndex]
                        //                           //               .barRods
                        //                           //               .map((rod) {
                        //                           //             return rod.copyWith(
                        //                           //                 toY: avg, color: widget.avgColor);
                        //                           //           }).toList(),
                        //                           //         );
                        //                           //       }
                        //                           //     });
                        //                           //   },
                        //                           // ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitles,
                              reservedSize: 42,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: true,
                        ),
                        barGroups: showingBarGroups,
                        gridData: const FlGridData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff7589a2),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0) {
      text = '1K';
    } else if (value == 10) {
      text = '5K';
    } else if (value == 19) {
      text = '10K';
    } else {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>['73rd Sammilani', '74th Sammilani'];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Color(0xff7589a2),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16, //margin top
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      barsSpace: 4,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          borderRadius: BorderRadius.zero,
          color: widget.leftBarColor,
          width: width,
        ),
        BarChartRodData(
          toY: y2,
          borderRadius: BorderRadius.zero,
          color: widget.rightBarColor,
          width: width,
        ),
      ],
    );
  }
}
