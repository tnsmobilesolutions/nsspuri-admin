// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/screen/appBar/addPaliaButton.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/appBar/searchButton.dart';

class ActionWidget extends StatelessWidget {
  const ActionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Padding(padding: EdgeInsets.all(8.0), child: GotoHomeButton()),
        const Padding(padding: EdgeInsets.all(8.0), child: SearchButton()),

        Padding(padding: const EdgeInsets.all(8.0), child: AddPaliaButton()),
        // const SizedBox(width: 20),
        const Padding(
          padding: EdgeInsets.only(right: 20),
          child: Padding(padding: EdgeInsets.all(8.0), child: LogoutButton()),
        ),
      ],
    );
  }
}
