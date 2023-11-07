// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:sdp/authstate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyA1tSAISbgSLqVdLRvfLh-9bB58DgYg1lI",
      authDomain: "nsspuridelegate-dev.firebaseapp.com",
      projectId: "nsspuridelegate-dev",
      storageBucket: "nsspuridelegate-dev.appspot.com",
      messagingSenderId: "222780364320",
      appId: "1:222780364320:web:de84ea401fff9310ac0e45",
      measurementId: "G-V1HVLL1401",
    ),
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
          primarySwatch: generateMaterialColor(color: Color(0XFF3f51b5)),
        ),
        home: AuthState());
  }
}
