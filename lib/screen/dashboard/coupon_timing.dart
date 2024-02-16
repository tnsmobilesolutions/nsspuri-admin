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
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController firstDayBalya = TextEditingController();
  TextEditingController secondDayBalya = TextEditingController();
  TextEditingController thirdDayBalya = TextEditingController();
  TextEditingController firstDayMadhyanha = TextEditingController();
  TextEditingController secondDayMadhyanha = TextEditingController();
  TextEditingController thirdDayMadhyanha = TextEditingController();
  TextEditingController firstDayRatra = TextEditingController();
  TextEditingController secondDayRatra = TextEditingController();
  TextEditingController thirdDayRatra = TextEditingController();
  List<String> allDates = [];
  List<String> firstDayBalyaTiming = [],
      firstDayMadhyanaTiming = [],
      firstDayRatraTiming = [],
      secondDayBalyaTiming = [],
      secondDayMadhyanaTiming = [],
      secondDayRatraTiming = [],
      thirdDayBalyaTiming = [],
      thirdDayMadhyanaTiming = [],
      thirdDayRatraTiming = [];
  final formKey = GlobalKey<FormState>();
  String buttonTitle = "Activate";
  bool showErrorMessage = false;
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

  Future<void> fetchCouponData() async {
    if (formKey.currentState?.validate() == true) {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );

      var response = await GetDevoteeAPI().viewCoupon(
        int.tryParse(couponCodeController.text) ?? 0,
      );

      if (response?["data"]["existingCoupon"] != null) {
        var data = response?["data"]["existingCoupon"];
        setState(() {
          List<CouponModel> allCoupons = [];
          buttonTitle = "Update";
          for (var coupon in data["couponPrasad"]) {
            allCoupons.add(CouponModel.fromMap(coupon));
          }
          List<String> datesFromAPI = [];
          for (var coupon in allCoupons) {
            datesFromAPI.add(coupon.date.toString());
          }
          if (datesFromAPI[0] == allDates[0]) {
            firstDayBalya.text = allCoupons[0].balyaCount == 0
                ? ""
                : allCoupons[0].balyaCount.toString();
            firstDayMadhyanha.text = allCoupons[0].madhyanaCount == 0
                ? ""
                : allCoupons[0].madhyanaCount.toString();
            firstDayRatra.text = allCoupons[0].ratraCount == 0
                ? ""
                : allCoupons[0].ratraCount.toString();
          }
          if (datesFromAPI[1] == allDates[1]) {
            secondDayBalya.text = allCoupons[1].balyaCount == 0
                ? ""
                : allCoupons[1].balyaCount.toString();
            secondDayMadhyanha.text = allCoupons[1].madhyanaCount == 0
                ? ""
                : allCoupons[1].madhyanaCount.toString();
            secondDayRatra.text = allCoupons[1].ratraCount == 0
                ? ""
                : allCoupons[1].ratraCount.toString();
          }
          if (datesFromAPI[2] == allDates[2]) {
            thirdDayBalya.text = allCoupons[2].balyaCount == 0
                ? ""
                : allCoupons[2].balyaCount.toString();
            thirdDayMadhyanha.text = allCoupons[2].madhyanaCount == 0
                ? ""
                : allCoupons[2].madhyanaCount.toString();
            thirdDayRatra.text = allCoupons[2].ratraCount == 0
                ? ""
                : allCoupons[2].ratraCount.toString();
          }
          firstDayBalyaTiming = allCoupons[0].balyaTiming ?? [];
          firstDayBalyaTiming = allCoupons[0].madhyanaTiming ?? [];
          firstDayBalyaTiming = allCoupons[0].ratraTiming ?? [];
          secondDayBalyaTiming = allCoupons[1].balyaTiming ?? [];
          secondDayBalyaTiming = allCoupons[1].madhyanaTiming ?? [];
          secondDayBalyaTiming = allCoupons[1].ratraTiming ?? [];
          thirdDayBalyaTiming = allCoupons[2].balyaTiming ?? [];
          thirdDayBalyaTiming = allCoupons[2].madhyanaTiming ?? [];
          thirdDayBalyaTiming = allCoupons[2].ratraTiming ?? [];
        });
      } else {
        setState(() {
          buttonTitle = "Activate";
          showErrorMessage = true;
        });
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
            showErrorMessage = false;
          });
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("No active coupon found !")),
        // );
      }
      Navigator.pop(context);
    }
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
                      onChanged: (couponCode) {
                        if (couponCode.isEmpty) {
                          setState(() {
                            buttonTitle = "Activate";
                          });
                        }
                      },
                      onFieldSubmitted: (value) async {
                        await fetchCouponData();
                      },
                      validator: (value) {
                        if (value?.isEmpty == true) {
                          return "Please enter coupon code !";
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
                      await fetchCouponData();
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
            showErrorMessage
                ? const Text(
                    "No active coupon found !",
                    style: TextStyle(color: Colors.deepOrange),
                  )
                : const SizedBox(),
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        });
                    List<CouponModel> couponList = [];

                    couponList = [
                      CouponModel(
                        date: allDates[0],
                        balyaCount: int.tryParse(firstDayBalya.text) ?? 0,
                        madhyanaCount:
                            int.tryParse(firstDayMadhyanha.text) ?? 0,
                        ratraCount: int.tryParse(firstDayRatra.text) ?? 0,
                        balyaTiming: firstDayBalyaTiming,
                        madhyanaTiming: firstDayMadhyanaTiming,
                        ratraTiming: firstDayRatraTiming,
                      ),
                      CouponModel(
                        date: allDates[1],
                        balyaCount: int.tryParse(secondDayBalya.text) ?? 0,
                        madhyanaCount:
                            int.tryParse(secondDayMadhyanha.text) ?? 0,
                        ratraCount: int.tryParse(secondDayRatra.text) ?? 0,
                        balyaTiming: secondDayBalyaTiming,
                        madhyanaTiming: secondDayMadhyanaTiming,
                        ratraTiming: secondDayRatraTiming,
                      ),
                      CouponModel(
                        date: allDates[2],
                        balyaCount: int.tryParse(thirdDayBalya.text) ?? 0,
                        madhyanaCount:
                            int.tryParse(thirdDayMadhyanha.text) ?? 0,
                        ratraCount: int.tryParse(thirdDayRatra.text) ?? 0,
                        balyaTiming: thirdDayBalyaTiming,
                        madhyanaTiming: thirdDayMadhyanaTiming,
                        ratraTiming: thirdDayRatraTiming,
                      ),
                    ];

                    await PutDevoteeAPI().createCoupon(couponList,
                        int.tryParse(couponCodeController.text) ?? 0);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Coupon created successfully !")));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  buttonTitle,
                  style: const TextStyle(
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
