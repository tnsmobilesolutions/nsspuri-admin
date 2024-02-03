import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive({
    super.key,
    this.extraLargeScreen,
    required this.desktop,
    required this.tablet,
    this.largeMobile,
    required this.mobile,
  });
  final Widget? extraLargeScreen;
  final Widget desktop;
  final Widget? tablet;
  final Widget? largeMobile;
  final Widget mobile;

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 1400;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width > 1150;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 1080;
  }

  static bool isLargeMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width <= 700;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width <= 500;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (size.width > 1400 && extraLargeScreen != null) {
      return extraLargeScreen!;
    } else if (size.width >= 1080) {
      return desktop;
    } else if (size.width >= 700 && tablet != null) {
      return tablet!;
    } else if (size.width >= 500 && largeMobile != null) {
      return largeMobile!;
    } else {
      return mobile;
    }
  }
}
