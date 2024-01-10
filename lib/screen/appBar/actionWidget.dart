// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:sdp/screen/PaliaListScreen.dart/paliaList.dart';
import 'package:sdp/screen/appBar/create_delegate_buton.dart.dart';
import 'package:sdp/screen/appBar/goto_home_button.dart';
import 'package:sdp/screen/appBar/logoutButton.dart';
import 'package:sdp/screen/appBar/search.dart';

class AppbarActionButtonWidget extends StatefulWidget {
  AppbarActionButtonWidget({
    super.key,
    this.searchBy,
    this.searchValue,
    this.isResultEmpty,
  });
  String? searchValue;
  String? searchBy;
  bool? isResultEmpty;

  @override
  State<AppbarActionButtonWidget> createState() =>
      _AppbarActionButtonWidgetState();
}

class _AppbarActionButtonWidgetState extends State<AppbarActionButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.all(8.0), child: GotoHomeButton()),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: SearchDevotee(
            status: "allDevotee",
            searchBy: widget.searchBy,
            searchValue: widget.searchValue,
            onFieldValueChanged: (isEmpty) {},
          ),
        ),

        Visibility(
          visible: widget.isResultEmpty == true,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                width: 1.0,
                color: Colors.white,
              ),
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return PaliaListPage(
                    pageFrom: "Dashboard",
                    status: "allDevotee",
                  );
                },
              ));
            },
            child: const Text(
              'Clear',
              style: TextStyle(color: Colors.white),
            ),
          ),
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
