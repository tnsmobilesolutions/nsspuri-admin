// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:sdp/authstate.dart';
import 'package:sdp/utilities/network_helper.dart';

Future<void> main() async {
  // await initializeDateFormatting('en', '');

  WidgetsFlutterBinding.ensureInitialized();

  await fetchCurrentuser();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyDlUZaghUvp0OSayMgnYisIoSlAzKUBSAQ",
        authDomain: "nsspuridelegate.firebaseapp.com",
        projectId: "nsspuridelegate",
        storageBucket: "nsspuridelegate.appspot.com",
        messagingSenderId: "29623966317",
        appId: "1:29623966317:web:cc9354992e7cda94667d64",
        measurementId: "G-N6D6GGLWZG"),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  //final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sammilani Delegate Admin',
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Color(0xff0064B4)),
          primarySwatch: generateMaterialColor(color: Color(0XFF3f51b5)),
        ),
        home: AuthState());
  }
}
