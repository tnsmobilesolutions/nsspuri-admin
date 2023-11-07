// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';

class GotoHomeButton extends StatelessWidget {
  const GotoHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
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
            return DashboardPage();
          },
        ));
      },
      child: const Text('Home'),
    );
  }
}
