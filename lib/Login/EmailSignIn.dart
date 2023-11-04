// ignore_for_file: file_names, use_build_context_synchronously

import 'package:authentication/EmailLogin/authentication_widget.dart';
import 'package:flutter/material.dart';
import 'package:sdp/API/userAPI.dart';

import 'package:sdp/screen/dashboard/dashboard.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({super.key});

  @override
  State<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: AuthenticationWidget(
                shouldEmailAuthentication: true,
                imageWidth: 245,
                imageHeight: 230,
                cardWidth: 245,
                cardHeight: 310,
                loginImage: const AssetImage('assets/images/login.png'),
                onEmailLoginPressed: (userEmail, userPassword) async {
                  final user = await UserAPI().signIn(userEmail, userPassword);

                  if (user != null) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DashboardPage(),
                        ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      elevation: 6,
                      behavior: SnackBarBehavior.floating,
                      content: Text(
                        'Please Check your Email/Password',
                      ),
                    ));
                  }
                },
                phoneAuthentication: false,
                isSignUpVisible: false,
                buttonColor: const Color(0xFFeb1589),
                loginButonTextColor: Colors.white,

                // titleTextColor: Colors.white,
                loginPageTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
                isImageVisible: true,
                textFieldBorderColor: Colors.white,
                //  Color(0xFFeb1589),
                cardColor: Color.fromARGB(255, 253, 253, 253),
                textfieldHintColor: Colors.white,
                // emailHintTextStyle: const TextStyle(color: Colors.white),
                // passwordHintTextStyle: const TextStyle(color: Colors.white),
              )),
        ),
      ),
    );
  }
}
