// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LeadingImage extends StatelessWidget {
  const LeadingImage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      child: Image(
          image: AssetImage('assets/images/login.png'),
          fit: BoxFit.cover,
          height: 5.00,
          width: 20.00),
    );
  }
}
