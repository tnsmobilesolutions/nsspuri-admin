// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/viewDevotee/devotee_info.dart';
import 'package:sdp/screen/viewDevotee/preview_delegate.dart';
import 'package:sdp/utilities/network_helper.dart';

// ignore: must_be_immutable
class ViewDevotee extends StatefulWidget {
  ViewDevotee({Key? key, required this.devoteeDetails, this.index})
      : super(key: key);
  final DevoteeModel devoteeDetails;
  int? index;

  @override
  State<ViewDevotee> createState() => _ViewDevoteeState();
}

class _ViewDevoteeState extends State<ViewDevotee>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final con = FlipCardController();

  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1000,
      width: 500,
      child: SelectionArea(
        child: Scaffold(
          body: SafeArea(
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
                    tabs: const [
                      Tab(
                        text: 'Devotee Info',
                      ),
                      Tab(
                        text: 'Preview Delegate',
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      DevoteeInfoTab(devoteeDetails: widget.devoteeDetails),
                      PreviewDelegateTab(devoteeDetails: widget.devoteeDetails),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
