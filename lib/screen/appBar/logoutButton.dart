// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sdp/API/userAPI.dart';
import 'package:sdp/Login/EmailSignIn.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      // style: ButtonStyle(
      //   shape: MaterialStateProperty.all(RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(15.0))),
      // ),
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
                  UserAPI().logout();
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const EmailSignIn();
                    },
                  ));
                  Navigator.popUntil(context, (route) => route.isFirst);
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
