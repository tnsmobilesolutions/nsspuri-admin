
import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';

int seniorCitizenAgeLimit = 70;
int teenAgeLimit = 12;

Color getColorByDevotee(DevoteeModel devotee) {
  if (devotee.isGuest == true) return Colors.yellow;
  if (devotee.isSpeciallyAbled == true) return Colors.purple;
  if (devotee.isOrganizer == true) return Colors.red;

  if (devotee.dob?.isNotEmpty == true && devotee.dob != null) {
    int age = calculateAge(DateTime.parse(devotee.dob.toString()));
    if (age <= teenAgeLimit) return Colors.green;
    if (age >= seniorCitizenAgeLimit) return Colors.purple;
  }

  if (devotee.gender == "Male") return Colors.blue;
  if (devotee.gender == "Female") return Colors.pink;

  return Colors.blue;
}

int calculateAge(DateTime dob) {
  DateTime now = DateTime.now();
  int age = now.year - dob.year;
  if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
    age--;
  }
  print("age: $age");
  return age;
}