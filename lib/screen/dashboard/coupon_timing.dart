// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/utilities/color_palette.dart';

class CouponTiming extends StatefulWidget {
  const CouponTiming({Key? key}) : super(key: key);

  @override
  _CouponTimingState createState() => _CouponTimingState();
}

class _CouponTimingState extends State<CouponTiming> {
  final couponCodeController = TextEditingController();
  final firstDayBalya = TextEditingController();
  final secondDayBalya = TextEditingController();
  final thirdDayBalya = TextEditingController();
  final firstDayMadhyanha = TextEditingController();
  final secondDayMadhyanha = TextEditingController();
  final thirdDayMadhyanha = TextEditingController();
  final firstDayRatra = TextEditingController();
  final secondDayRatra = TextEditingController();
  final thirdDayRatra = TextEditingController();

  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? responseData;

  List<TextEditingController> balyaControllers = [],
      madhyanhaControllers = [],
      ratraControllers = [];

  @override
  void initState() {
    super.initState();
    timingData();
  }

  timingData() async {
    try {
      // Call the first API
      Map<String, dynamic>? timingResponse =
          await GetDevoteeAPI().updateTiming();
      responseData = timingResponse["data"];
      // showTiming();

      // Call the second API
    } catch (error) {
      // Handle errors
      print("Error fetching data: $error");
    }
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    firstDayBalya.dispose();
    firstDayMadhyanha.dispose();
    firstDayRatra.dispose();
    secondDayBalya.dispose();
    secondDayMadhyanha.dispose();
    secondDayRatra.dispose();
    thirdDayBalya.dispose();
    thirdDayMadhyanha.dispose();
    thirdDayRatra.dispose();
    super.dispose();
  }

  // showTiming() {
  //   if (responseData != null) {
  //     setState(() {
  //       1stDayBalya.text = responseData?["1stDayBalya"] ?? "";
  //       balyaEndTime.text = responseData?["balyaEndTime"] ?? "";
  //       madhyanStartTime.text = responseData?["madhyanaStartTime"] ?? "";
  //       madhyanEndTime.text = responseData?["madhyanaEndTime"] ?? "";
  //       ratraStartTime.text = responseData?["ratraStartTime"] ?? "";
  //       ratraEndTime.text = responseData?["ratraEndTime"] ?? "";
  //     });
  //   }
  // }

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

  Widget formField(TextEditingController controller) {
    return SizedBox(
      height: 300,
      width: 80,
      child: TextFormField(
        keyboardType: TextInputType.datetime,
        controller: controller,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        ],
        validator: (value) {
          RegExp numberRegex = RegExp(r'^\d{7}$');
          if (value?.isEmpty == true) {
            return "Please enter coupon code !";
          }
          if (!numberRegex.hasMatch(value.toString())) {
            return "Please enter a valid code!";
          }
          return null;
        },
        decoration: InputDecoration(
          //labelText: "Coupon Code",
          //labelStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
          filled: true,
          //floatingLabelBehavior: FloatingLabelBehavior.auto,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.solid,
            ),
          ),
        ),
      ),
    );
  }

  Widget couponTable() {
    return DataTable(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      dividerThickness: 0.1,
      columnSpacing: 50,
      dataRowMaxHeight: 80,
      columns: [
        dataColumn(context, "Date"),
        dataColumn(context, "Balya"),
        dataColumn(context, "Madhyanha"),
        dataColumn(context, "Ratra"),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text("23/02/2024")),
          DataCell(formField(firstDayBalya)),
          DataCell(formField(firstDayMadhyanha)),
          DataCell(formField(firstDayRatra)),
        ]),
        DataRow(cells: [
          const DataCell(Text("24/02/2024")),
          DataCell(formField(secondDayBalya)),
          DataCell(formField(secondDayMadhyanha)),
          DataCell(formField(secondDayRatra)),
        ]),
        DataRow(cells: [
          const DataCell(Text("25/02/2024")),
          DataCell(formField(thirdDayBalya)),
          DataCell(formField(thirdDayMadhyanha)),
          DataCell(formField(thirdDayRatra)),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
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
        content: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Coupon No.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: couponCodeController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        RegExp numberRegex = RegExp(r'^\d{7}$');
                        if (value?.isEmpty == true) {
                          return "Please enter coupon code !";
                        }
                        if (!numberRegex.hasMatch(value.toString())) {
                          return "Please enter a valid code!";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Coupon Code",
                        labelStyle:
                            TextStyle(color: Colors.grey[600], fontSize: 15),
                        filled: true,
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 0,
                            style: BorderStyle.solid,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    width: 150,
                    height: 40,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith((states) {
                            if (states.contains(MaterialState.pressed)) {
                              return ButtonColor;
                            }
                            return ButtonColor;
                          }),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)))),
                      onPressed: () {},
                      child: const Text(
                        "view",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              couponTable(),
            ],
          ),
        ),
        actions: [
          Center(
            child: Container(
              width: 200,
              height: 50,
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return ButtonColor;
                      }
                      return ButtonColor;
                    }),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)))),
                onPressed: () {
                  String date = DateFormat("yyyy-MM-dd").format(DateTime.now()),
                      time = DateFormat("HH:mm").format(DateTime.now());
                },
                child: const Text(
                  "Activate",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
