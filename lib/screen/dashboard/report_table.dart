// ignore_for_file: file_names, depend_on_referenced_packages, must_be_immutable, iterable_contains_unrelated_type, avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/responsive.dart';

class ReportTable extends StatefulWidget {
  ReportTable({
    Key? key,
  }) : super(key: key);

  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable>
    with TickerProviderStateMixin {
  bool editpaliDate = false;
  bool isAscending = false;
  bool showMenu = false;
  bool isLoading = true;

  List<bool> selectedList = [];

  Expanded headingText(String text) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }

  DataColumn dataColumn(BuildContext context, String header,
      [Function(int, bool)? onSort]) {
    return DataColumn(
        onSort: onSort,
        label: Flexible(
          flex: 1,
          child: Text(
            header,
            softWrap: true,
            style: Theme.of(context).textTheme.titleMedium?.merge(
                  const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
          ),
        ));
  }

  Widget devoteeTable(BuildContext context) {
    return DataTable(
      showBottomBorder: true,
      columnSpacing: 30,
      dataRowMaxHeight: 80,
      columns: [
        dataColumn(context, 'Event'),
        dataColumn(context, 'Total Delegate'),
        dataColumn(context, 'Total Amount'),
        dataColumn(context, 'Online paid number'),
        dataColumn(context, 'Online paid amount'),
        dataColumn(context, 'Cash paid numbers'),
        dataColumn(context, 'Cash paid amount'),
        dataColumn(context, 'Prasad coupon numbers'),
        dataColumn(context, 'Prasad coupon amount'),
      ],
      rows: const [
        DataRow(cells: [
          DataCell(Text('73rd Sammilani')),
          DataCell(Text('8000')),
          DataCell(Text('\Rs.3200000')),
          DataCell(Text('50')),
          DataCell(Text('\Rs.500')),
          DataCell(Text('30')),
          DataCell(Text('\Rs.300')),
          DataCell(Text('20')),
          DataCell(Text('\Rs.200')),
        ]),
        DataRow(cells: [
          DataCell(Text('74th Sammilani')),
          DataCell(Text('0')),
          DataCell(Text('\Rs.0')),
          DataCell(Text('0')),
          DataCell(Text('\Rs.0')),
          DataCell(Text('0')),
          DataCell(Text('\Rs.0')),
          DataCell(Text('0')),
          DataCell(Text('\Rs.0')),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Responsive(
                    desktop: devoteeTable(context),
                    tablet: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: devoteeTable(context),
                    ),
                    mobile: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: devoteeTable(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
