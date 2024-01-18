import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/responsive.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/utilities/network_helper.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  void fetchUser() async {
    await fetchCurrentuser();
  }

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return uid != null
        ? Responsive(
            desktop: DashboardPage(),
            tablet: DashboardPage(),
            mobile: DashboardPage(),
          )
        : const EmailSignIn();
  }
}
