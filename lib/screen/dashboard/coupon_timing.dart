// ignore_for_file: use_build_context_synchronously, avoid_print, library_private_types_in_public_api, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/API/put_devotee.dart';
import 'package:sdp/model/coupon_model.dart';
import 'package:sdp/utilities/color_palette.dart';
import 'package:sdp/utilities/network_helper.dart';

class CouponTiming extends StatefulWidget {
  CouponTiming({
    Key? key,
    this.selectedDates,
    required this.fromDashboard,
  }) : super(key: key);
  List<String>? selectedDates;
  bool fromDashboard;

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
  List<String> allDates = [];
  final formKey = GlobalKey<FormState>();
  Map<String, dynamic>? responseData;

  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.fromDashboard) {
        allDates = widget.selectedDates ?? [];
      } else {
        allDates = NetworkHelper().getSelectedPrasadDate;
      }
    });
  }

  @override
  void dispose() {
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
          DataCell(Text(allDates[0])),
          DataCell(formField(firstDayBalya)),
          DataCell(formField(firstDayMadhyanha)),
          DataCell(formField(firstDayRatra)),
        ]),
        DataRow(cells: [
          DataCell(Text(allDates[1])),
          DataCell(formField(secondDayBalya)),
          DataCell(formField(secondDayMadhyanha)),
          DataCell(formField(secondDayRatra)),
        ]),
        DataRow(cells: [
          DataCell(Text(allDates[2])),
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
        content: Column(
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
                Form(
                  key: formKey,
                  child: SizedBox(
                    width: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.datetime,
                      controller: couponCodeController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      validator: (value) {
                        //RegExp numberRegex = RegExp(r'^\d{7}$');
                        if (value?.isEmpty == true) {
                          return "Please enter coupon code !";
                        }
                        // if (!numberRegex.hasMatch(value.toString())) {
                        //   return "Please enter a valid code!";
                        // }
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
                    onPressed: () async {
                      if (formKey.currentState?.validate() == true) {
                        await GetDevoteeAPI().viewCoupon(
                            int.tryParse(couponCodeController.text) ?? 0);
                      }
                    },
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
                onPressed: () async {
                  if (formKey.currentState?.validate() == true) {
                    List<CouponModel> couponList = [];
                    for (int i = 0; i < allDates.length; i++) {
                      int? balyaCount, madhyanaCount, ratraCount;
                      switch (i) {
                        case 0:
                          balyaCount = int.tryParse(firstDayBalya.text);
                          madhyanaCount = int.tryParse(firstDayMadhyanha.text);
                          ratraCount = int.tryParse(firstDayRatra.text);
                          break;
                        case 1:
                          balyaCount = int.tryParse(secondDayBalya.text);
                          madhyanaCount = int.tryParse(secondDayMadhyanha.text);
                          ratraCount = int.tryParse(secondDayRatra.text);
                          break;
                        case 2:
                          balyaCount = int.tryParse(thirdDayBalya.text);
                          madhyanaCount = int.tryParse(thirdDayMadhyanha.text);
                          ratraCount = int.tryParse(thirdDayRatra.text);
                          break;
                        default:
                          balyaCount = 0;
                          break;
                      }
                      couponList.add(CouponModel(
                        date: allDates[i],
                        balyaCount: balyaCount ?? 0,
                        madhyanaCount: madhyanaCount ?? 0,
                        ratraCount: ratraCount ?? 0,
                        balyaTiming: [],
                        madhyanaTiming: [],
                        ratraTiming: [],
                      ));
                    }

                    await PutDevoteeAPI().createCoupon(couponList,
                        int.tryParse(couponCodeController.text) ?? 0);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Coupon created successfully !")));
                    Navigator.pop(context);
                  }
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
