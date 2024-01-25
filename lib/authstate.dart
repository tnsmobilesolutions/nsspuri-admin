import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
    return FutureBuilder<Map<String, dynamic>?>(
      future: GetDevoteeAPI().currentDevotee(),
      builder: (context, currentDevoteeSnapshot) {
        if (currentDevoteeSnapshot.connectionState == ConnectionState.waiting ||
            currentDevoteeSnapshot.hasError) {
          print(
              "Error fetching current devotee: ${currentDevoteeSnapshot.error}");
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          String uid = FirebaseAuth.instance.currentUser?.uid ?? "";
          if (uid.isNotEmpty && currentDevoteeSnapshot.hasData) {
            print("API Response: ${currentDevoteeSnapshot.data}");

            final DevoteeModel currentDevotee =
                currentDevoteeSnapshot.data?["data"] ?? DevoteeModel();

            print(
                "Current Devotee Data: ${currentDevoteeSnapshot.data?["data"]}");

            print("authstate-------$currentDevotee");
            if (currentDevotee.devoteeId != null &&
                currentDevotee.devoteeId != "") {
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
                return const EmailSignIn();
              }
            }
          } else {
            return const EmailSignIn();
          }
        }
        return const EmailSignIn();
      },
    );
  }
}
