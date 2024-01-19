import 'package:flutter/material.dart';

class BackArrowButton {
  static IconButton backArrowIcon(
      BuildContext context, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        Icons.arrow_back_ios_new_rounded,
        size: Theme.of(context).iconTheme.size,
        color: Colors.black,
      ),
    );
  }
}
