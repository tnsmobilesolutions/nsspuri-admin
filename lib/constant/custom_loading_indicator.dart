import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatefulWidget {
  const CustomLoadingIndicator({super.key});

  @override
  State<CustomLoadingIndicator> createState() => _CustomLoadingIndicatorState();
}

class _CustomLoadingIndicatorState extends State<CustomLoadingIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white54, // Set the background color
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15), // Same radius as the container
        child: const LinearProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}
