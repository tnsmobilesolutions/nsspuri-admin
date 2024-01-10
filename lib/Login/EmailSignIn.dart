// ignore_for_file: file_names, use_build_context_synchronously

import 'package:authentication/EmailLogin/authentication_widget.dart';
import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/firebase/firebase_auth_api.dart';
import 'package:sdp/model/devotee_model.dart';

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
        backgroundColor: Color.fromARGB(255, 242, 247, 254),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                child: AuthenticationWidget(
                  shouldEmailAuthentication: true,
                  imageWidth: 150,
                  imageHeight: 150,
                  cardWidth: 245,
                  cardHeight: 280,

                  cardElevation: 20,
                  loginImage: const AssetImage('assets/images/login.png'),
                  title: const Text(
                    'Sammilani Delegate Admin',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  onEmailLoginPressed: (userEmail, userPassword) async {
                    try {
                      String? uid = await FirebaseAuthentication()
                          .signinWithFirebase(userEmail.toString().trim(),
                              userPassword.toString().trim());

                      if (uid != null) {
                        final response =
                            await GetDevoteeAPI().loginDevotee(uid);
                        DevoteeModel resDevoteeData = response?["data"];

                        if (response?["statusCode"] == 200 &&
                                resDevoteeData.role == "Admin" ||
                            resDevoteeData.role == "SuperAdmin" ||
                            resDevoteeData.role == "Approver") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DashboardPage(),
                              ));
                        } else {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            elevation: 6,
                            behavior: SnackBarBehavior.floating,
                            content: Text(
                              'You are not an Admin',
                            ),
                          ));
                        }
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          elevation: 6,
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            'Please Check your Email/Password',
                          ),
                        ));
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  phoneAuthentication: false,
                  isSignUpVisible: false,
                  buttonColor: Colors.deepOrange,
                  loginButonTextColor: Colors.white,

                  // titleTextColor: Colors.white,

                  isImageVisible: true,

                  //  Color(0xFFeb1589),
                  cardColor: const Color.fromARGB(255, 253, 253, 253),
                  textfieldHintColor: Colors.white,

                  emailFieldDecoration: InputDecoration(
                    label: Text('Email'),
                    labelStyle: TextStyle(color: Colors.grey[800]),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                  passwordFieldDecoration: InputDecoration(
                    label: Text('Password'),
                    labelStyle: TextStyle(color: Colors.grey[800]),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepOrange),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.black.withOpacity(0.5)),
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
