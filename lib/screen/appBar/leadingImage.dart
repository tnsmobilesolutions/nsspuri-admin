// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/responsive.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Image(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
              height: 80.00,
              width: 90.00),
          const SizedBox(width: 20),
          SizedBox(
            width: Responsive.isLargeMobile(context) ? 300 : screenWidth / 7,
            child: const Text(
              'Sammilani Delegate Admin',
              style: TextStyle(color: Colors.white),
              softWrap: true,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
