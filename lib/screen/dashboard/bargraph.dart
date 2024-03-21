import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sdp/screen/dashboard/appcolors.dart';

class Bargraph extends StatefulWidget {
  Bargraph({super.key});

  final Color dark = Colors.purple;
  final Color normal = Colors.yellow;

  @override
  State<StatefulWidget> createState() => BargraphState();
}

class BargraphState extends State<Bargraph> {
  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(fontSize: 10);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '73th Sammilani';
        break;
      case 1:
        text = '74th Sammilani';
        break;

      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    const style = TextStyle(
      fontSize: 10,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 700,
      height: 700,
      child: AspectRatio(
        aspectRatio: 2,
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final barsSpace = 4.0 * constraints.maxWidth / 400;
              final barsWidth = 40.0 * constraints.maxWidth / 400;
              return BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barTouchData: BarTouchData(
                    enabled: true,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        getTitlesWidget: bottomTitles,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: leftTitles,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(
                    show: true,
                    checkToShowHorizontalLine: (value) => value % 10 == 0,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: AppColors.borderColor.withOpacity(0.1),
                      strokeWidth: 1,
                    ),
                    drawVerticalLine: false,
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  groupsSpace: barsSpace,
                  barGroups: getData(barsWidth, barsSpace),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 2000000,
            rodStackItems: [
              BarChartRodStackItem(0, 600000, widget.dark),
              BarChartRodStackItem(70000, 180000, widget.normal),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: 2000000,
            rodStackItems: [
              BarChartRodStackItem(0, 1100000, widget.dark),
              BarChartRodStackItem(1100000, 1800000, widget.normal),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
  }
}
