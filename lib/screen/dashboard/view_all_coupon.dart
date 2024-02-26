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
    // Calculate sum of total coupons
    int totalCoupons = allCoupons.length;

    // Calculate sum of total amount
    int totalAmount = 0;
    for (var coupon in allCoupons) {
      totalAmount += int.tryParse(coupon["amount"].toString()) ?? 0;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Coupon List'),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 190,
                  height: 40,
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
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
                    ],
                  ),
                ),
                isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : allCoupons.isNotEmpty
                        ? Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: Text(
                                      "Coupon Code",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(
                                      width: 160,
                                    ),
                                    Expanded(
                                        child: Text("Amount",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold))),
                                    SizedBox(
                                      width: 160,
                                    ),
                                    Expanded(
                                      child: Text("Created Date",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                              const Divider(thickness: 3),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: allCoupons.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                      "${allCoupons[index]["couponCode"]}")),
                                              const SizedBox(
                                                width: 160,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                      "Rs.${allCoupons[index]["amount"] ?? "0"}")),
                                              const SizedBox(
                                                width: 160,
                                              ),
                                              Expanded(
                                                child: Text(
                                                    "${allCoupons[index]["couponCreatedDate"] ?? ""}"),
                                              )
                                            ],
                                          ),
                                          const Divider(thickness: 1),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(height: 10),
                            ],
                          )
                        : const SizedBox(),
              ],
            ),
          ),
          allCoupons.isNotEmpty
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: Colors.grey[200],
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Coupons: $totalCoupons",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Total Amount: Rs.$totalAmount",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
