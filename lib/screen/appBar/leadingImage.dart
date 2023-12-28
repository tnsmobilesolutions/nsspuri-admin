// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TitleAppBar extends StatelessWidget {
  const TitleAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
              image: AssetImage('assets/images/login.png'),
              fit: BoxFit.cover,
              height: 60.00,
              width: 60.00),
          Spacer(),
          Text(
            'Sammilani Delegate Admin',
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
