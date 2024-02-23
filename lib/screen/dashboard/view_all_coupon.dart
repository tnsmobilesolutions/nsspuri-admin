import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/utilities/color_palette.dart';

class ViewAllCoupon extends StatefulWidget {
  const ViewAllCoupon({Key? key}) : super(key: key);

  @override
  State<ViewAllCoupon> createState() => _ViewAllCouponState();
}

class _ViewAllCouponState extends State<ViewAllCoupon> {
  List<Map<String, dynamic>> allCoupons = [];
  bool isLoading = false;

  Future<void> fetchAllCoupons() async {
    setState(() {
      isLoading = true;
    });

    var response = await GetDevoteeAPI().viewAllCoupon();

    print("all coupon response: $response");

    if (response?["statusCode"] == 200) {
      setState(() {
        allCoupons = List<Map<String, dynamic>>.from(response?["data"]);
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 190,
            height: 40,
            margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return ButtonColor;
                  }
                  return ButtonColor;
                }),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              onPressed: isLoading ? null : fetchAllCoupons,
              child: const Text(
                "View All",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : allCoupons.isNotEmpty
                  ? DataTable(
                      columns: [
                        DataColumn(label: Text('Coupon Code')),
                        DataColumn(label: Text("Amount(₹)")),
                        DataColumn(label: Text('Created Date')),
                      ],
                      rows: allCoupons.map((coupon) {
                        return DataRow(cells: [
                          DataCell(Text(coupon["couponCode"].toString())),
                          DataCell(Text(coupon["amount"] != null
                              ? coupon["amount"].toString()
                              : "")),
                          DataCell(Text(coupon["couponCreatedDate"] != null
                              ? coupon["couponCreatedDate"].toString()
                              : "")),
                        ]);
                      }).toList(),
                    )
                  : const SizedBox(),
        ],
      ),
    );
  }
}