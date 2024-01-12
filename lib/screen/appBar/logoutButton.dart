// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:sdp/Login/EmailSignIn.dart';
import 'package:sdp/firebase/firebase_auth_api.dart';
import 'package:sdp/model/devotee_model.dart';
import 'package:sdp/utilities/network_helper.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

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
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Thank You'),
                IconButton(
                    color: const Color(0XFF3f51b5),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close))
              ],
            ),
            content: const Text('Do You Want to Logout?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  FirebaseAuthentication().signOut();
                  //Networkhelper().setCurrentDevotee = DevoteeModel();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const EmailSignIn();
                    },
                  ));
                  // Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
      child: const Text('Logout'),
    );
  }
}
