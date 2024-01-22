import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/screen/user/userDashboard.dart';
import 'package:sdp/utilities/network_helper.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final uid = snapshot.data?.uid;
          return FutureBuilder<Map<String, dynamic>?>(
            future: (uid != null) ? GetDevoteeAPI().currentDevotee() : null,
            builder: (context, currentDevoteeSnapshot) {
              if (currentDevoteeSnapshot.connectionState ==
                      ConnectionState.waiting ||
                  currentDevoteeSnapshot.hasError) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (uid != null && currentDevoteeSnapshot.hasData) {
                  DevoteeModel currentDevotee =
                      currentDevoteeSnapshot.data?["data"];
                  NetworkHelper().setCurrentDevotee = currentDevotee;
                  if (currentDevotee.role == "SuperAdmin" ||
                      currentDevotee.role == "Admin" ||
                      currentDevotee.role == "Approver" ||
                      currentDevotee.role == "Viewer") {
                    return DashboardPage();
                  } else if (currentDevotee.role == "User") {
                    return UserDashboard(
                        devoteeId: currentDevotee.devoteeId.toString());
                  } else {
                    return EmailSignIn();
                  }
                } else {
                  return EmailSignIn();
                }
              }
            },
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
