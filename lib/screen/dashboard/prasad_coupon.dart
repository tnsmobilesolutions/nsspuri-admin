// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/screen/dashboard/create_coupon.dart';
import 'package:sdp/screen/dashboard/view_all_coupon.dart';
import 'package:sdp/screen/viewDevotee/preview_delegate.dart';

// ignore: must_be_immutable
class PrasadCoupon extends StatefulWidget {
  PrasadCoupon({
    Key? key,
    this.selectedDates,
    required this.fromDashboard,
  }) : super(key: key);
  List<String>? selectedDates;
  bool fromDashboard;

  @override
  State<PrasadCoupon> createState() => _PrasadCouponState();
}

class _PrasadCouponState extends State<PrasadCoupon>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 700,
      child: SelectionArea(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(children: [
            SizedBox(
              height: 40,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.deepOrange,
                labelStyle:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    text: 'Activate',
                  ),
                  Tab(
                    text: 'View All',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CreateCoupon(
                    fromDashboard: widget.fromDashboard,
                    selectedDates: widget.selectedDates,
                  ),
                  const ViewAllCoupon(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
