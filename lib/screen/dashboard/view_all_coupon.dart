import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/model/coupon_model.dart';
import 'package:sdp/utilities/color_palette.dart';

class ViewAllCoupon extends StatefulWidget {
  const ViewAllCoupon({super.key});

  @override
  State<ViewAllCoupon> createState() => _ViewAllCouponState();
}

class _ViewAllCouponState extends State<ViewAllCoupon> {
  List<dynamic> allCoupons = [];
  bool isLoading = false;
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
  final formKey = GlobalKey<FormState>();
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

  Future<void> fetchAllCoupons() async {
    var response = await GetDevoteeAPI().viewAllCoupon();
    if (response?["statusCode"] == 200) {
      setState(() {
        allCoupons = response?["data"];
      });
    }
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
      
        });
        Future.delayed(const Duration(seconds: 5), () {
          setState(() {
          
          });
        });

        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text("No active coupon found !")),
        // );
      }
      Navigator.pop(context);
    }
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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
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
                          borderRadius: BorderRadius.circular(5)))),
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await fetchAllCoupons();
                setState(() {
                  isLoading = false;
                });
              },
              child: const Text(
                "view all",
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
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: allCoupons.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Column(
                              children: [
                                Text("${allCoupons[index]}"),
                                Row(
                                  children: [
                                    Text('Balya'),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: TextFormField(
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
                                    ),
                                     Text('Madhyahna'),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: TextFormField(
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
                                    ),
                                     Text('Ratra'),
                                    SizedBox(
                                      height: 50,
                                      width: 50,
                                      child: TextFormField(
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
                                    ),

                                  ],
                                )
    //                             DataTable(
    //   decoration: const BoxDecoration(
    //     borderRadius: BorderRadius.only(
    //       topLeft: Radius.circular(20),
    //       topRight: Radius.circular(20),
    //     ),
    //   ),
    //   dividerThickness: 0.1,
    //   columnSpacing: 50,
    //   dataRowMaxHeight: 80,
    //   columns: [
    //     dataColumn(context, "Date"),
    //     dataColumn(context, "Balya"),
    //     dataColumn(context, "Madhyanha"),
    //     dataColumn(context, "Ratra"),
    //   ],
    //   rows: [
    //     DataRow(cells: [
    //       DataCell(Text(allDates[0])),
    //       DataCell(formField(firstDayBalya)),
    //       DataCell(formField(firstDayMadhyanha)),
    //       DataCell(formField(firstDayRatra)),
    //     ]),
    //     DataRow(cells: [
    //       DataCell(Text(allDates[1])),
    //       DataCell(formField(secondDayBalya)),
    //       DataCell(formField(secondDayMadhyanha)),
    //       DataCell(formField(secondDayRatra)),
    //     ]),
    //     DataRow(cells: [
    //       DataCell(Text(allDates[2])),
    //       DataCell(formField(thirdDayBalya)),
    //       DataCell(formField(thirdDayMadhyanha)),
    //       DataCell(formField(thirdDayRatra)),
    //     ]),
    //   ],
    // )
                              ],
                            ),
                          ),
                        );
                      })
                  : const SizedBox()
        ],
      ),
    );
  }
}
