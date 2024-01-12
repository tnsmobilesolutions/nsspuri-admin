// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:authentication/EmailLogin/authentication_widget.dart';
import 'package:flutter/material.dart';
import 'package:sdp/API/get_devotee.dart';
import 'package:sdp/firebase/firebase_auth_api.dart';
import 'package:sdp/model/devotee_model.dart';

import 'package:sdp/screen/dashboard/dashboard.dart';
import 'package:sdp/utilities/network_helper.dart';

class EmailSignIn extends StatefulWidget {
  const EmailSignIn({super.key});

  @override
  State<EmailSignIn> createState() => _EmailSignInState();
}

class _EmailSignInState extends State<EmailSignIn> {
  final TextEditingController phoneController = TextEditingController();
  bool obscureText = true;
  InputDecoration authFieldDecor(String hintText, [Widget? suffixIcon]) {
    return InputDecoration(
      hintText: hintText,
      errorStyle: const TextStyle(color: Colors.deepOrange),
      hintStyle: const TextStyle(
          color: Color.fromARGB(255, 173, 173, 245),
          fontWeight: FontWeight.normal),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      suffixIcon: suffixIcon ?? const SizedBox(),
      errorMaxLines: 3,
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepOrange),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black45),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color.fromARGB(255, 242, 247, 254),
        body: Center(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: AuthenticationWidget(
                shouldEmailAuthentication: true,
                imageWidth: 150,
                imageHeight: 150,
                cardWidth: 400,
                cardHeight: 400,
                cardElevation: 20,
                loginImage: const AssetImage('assets/images/login.png'),
                title: const Text(
                  'Sammilani Delegate Admin',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    // shadows: [
                    //   Shadow(
                    //     color: Colors.deepOrange,
                    //     offset: Offset(.1, .1),
                    //     blurRadius: 8.0,
                    //   ),
                    // ],
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                onEmailLoginPressed: (userEmail, userPassword) async {
                  try {
                    String? uid = await FirebaseAuthentication()
                        .signinWithFirebase(userEmail.toString().trim(),
                            userPassword.toString().trim());

                    if (uid != null) {
                      final response = await GetDevoteeAPI().loginDevotee(uid);
                      DevoteeModel resDevoteeData = response?["data"];

                      Networkhelper().setCurrentDevotee = resDevoteeData;

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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
                obscureText: obscureText,
                phoneAuthentication: false,
                isSignUpVisible: false,
                buttonColor: Colors.deepOrange,
                loginButonTextColor: Colors.white,
                isImageVisible: true,
                cardColor: const Color.fromARGB(255, 253, 253, 253),
                textfieldHintColor: Colors.white,
                emailFieldDecoration: authFieldDecor("Email"),
                passwordFieldDecoration: authFieldDecor(
                  "Password",
                  IconButton(
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_rounded
                          : Icons.visibility,
                      color: obscureText
                          ? const Color.fromARGB(255, 249, 170, 147)
                          : Colors.deepOrange,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
