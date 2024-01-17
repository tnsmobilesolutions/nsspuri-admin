// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_flip_card/controllers/flip_card_controllers.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/viewDevotee/devotee_info.dart';
import 'package:sdp/screen/viewDevotee/preview_delegate.dart';

// ignore: must_be_immutable
class ViewPalia extends StatefulWidget {
  ViewPalia({Key? key, required this.devoteeDetails, this.index})
      : super(key: key);
  final DevoteeModel devoteeDetails;
  int? index;

  @override
  State<ViewPalia> createState() => _ViewPaliaState();
}

class _ViewPaliaState extends State<ViewPalia>
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
      height: 500,
      width: 500,
      child: SelectionArea(
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Column(children: [
                Container(
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
