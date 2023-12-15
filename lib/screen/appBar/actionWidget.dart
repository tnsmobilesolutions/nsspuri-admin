// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/appBar/search.dart';
import 'package:sdp/screen/appBar/searchButton.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.all(8.0), child: GotoHomeButton()),
        Padding(
            padding: EdgeInsets.all(10.0),
            child: SearchSDP(status: "allDevotee")

            // SearchButton(
            //   status: 'allDevotee',
            // ),
            ),

        Padding(
            padding: const EdgeInsets.all(8.0), child: CreateDelegateButton()),
        // const SizedBox(width: 20),
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Padding(padding: EdgeInsets.all(8.0), child: LogoutButton()),
        ),
      ],
    );
  }
}
