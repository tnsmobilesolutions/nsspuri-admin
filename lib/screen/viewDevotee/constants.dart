// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:sdp/model/devotee_model.dart';

int seniorCitizenAgeLimit = 70;
int teenAgeLimit = 12;

Color getColorByDevotee(DevoteeModel devotee) {
  if (devotee.isGuest == true) return Colors.yellow;
  if (devotee.isSpeciallyAbled == true) return Colors.purple;
  if (devotee.isOrganizer == true) return Colors.red;

  if (devotee.ageGroup != "") {
    if (devotee.ageGroup == "Child") return Colors.green;

    if (devotee.ageGroup == "Adult") {
      if (devotee.gender == "Male") {
        return Colors.blue;
      }
      if (devotee.gender == "Female") {
        return Colors.pink;
      }
    }

    if (devotee.ageGroup == "Elder") return Colors.purple;
  }

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
































































// Color getColorByDevotee(DevoteeModel devotee) {
  //   if (devotee.isGuest == true) {
  //     return Colors.yellow;
  //   } else if (devotee.isOrganizer == true) {
  //     return const Color.fromARGB(255, 220, 31, 18);
  //   } else if (devotee.dob != "" && devotee.dob != null) {
  //     if (devotee.isSpeciallyAbled == true ||
  //         calculateAge(DateTime.parse(devotee.dob.toString())) >=
  //             seniorCitizenAgeLimit) {
  //       return Colors.purple;
  //     } else if (calculateAge(DateTime.parse(devotee.dob.toString())) <=
  //         teenAgeLimit) {
  //       return Colors.green;
  //     } else {
  //       return Colors.yellow;
  //     }
  //   } else if (devotee.gender == "Male") {
  //     return Colors.blue;
  //   } else if (devotee.gender == "Female") {
  //     return const Color.fromARGB(255, 254, 117, 163);
  //   } else {
  //     return Colors.grey;
  //   }
  // }

  // Color getColorByDevotee(DevoteeModel devotee) {
  //   if (devotee.dob?.isNotEmpty == true && devotee.dob != null) {
  //     int age = calculateAge(DateTime.parse(devotee.dob.toString()));
  //     if (devotee.isGuest == true) {
  //       return Colors.yellow;
  //     } else if (devotee.isOrganizer == true) {
  //       return Colors.red;
  //     } else if (age <= teenAgeLimit) {
  //       return Colors.green;
  //     } else if (age >= seniorCitizenAgeLimit ||
  //         devotee.isSpeciallyAbled == true) {
  //       return Colors.purple;
  //     } else if (devotee.gender == "Male") {
  //       return Colors.blue;
  //     } else if (devotee.gender == "Female") {
  //       return Colors.pink;
  //     }
  //   }
  //   return Colors.yellow;
  // }


//  Color getColorByDevotee(DevoteeModel devotee) {
//   if (devotee.dob?.isNotEmpty == true && devotee.dob != null) {
//     int age = calculateAge(DateTime.parse(devotee.dob.toString()));

//     switch (true) {
//       case (age <= teenAgeLimit):
//         return Colors.green;
//       case (age >= seniorCitizenAgeLimit || devotee.isSpeciallyAbled == true):
//         return Colors.purple;
//       case (devotee.isGuest == true):
//         return Colors.yellow;
//       case (devotee.isOrganizer == true):
//         return Colors.red;
//       case (devotee.gender == "Male"):
//         return Colors.blue;
//       case (devotee.gender == "Female"):
//         return Colors.pink;
//       default:
//         return Colors.yellow;
//     }
//   }
//   return Colors.yellow;
// }

  // Color getColorByDevotee(DevoteeModel devotee) {
  //   int age = 0;

  //   if (devotee.dob != null && devotee.dob!.isNotEmpty) {
  //     try {
  //       age = calculateAge(DateTime.parse(devotee.dob.toString()));
  //     } catch (e) {
  //       print("Error parsing date: $e");
  //     }
  //   } else {
  //     return Colors.blue;
  //   }

  //   if (devotee.isGuest == true) {
  //     return Colors.yellow;
  //   } else if (devotee.isOrganizer == true) {
  //     return Colors.red;
  //   } else if (age <= teenAgeLimit) {
  //     return Colors.green;
  //   } else if (devotee.dob != "" && devotee.dob != null) {
  //     if (age >= seniorCitizenAgeLimit || devotee.isSpeciallyAbled == true) {
  //       return Colors.purple;
  //     } else if (devotee.gender == "Male") {
  //       return Colors.blue;
  //     } else if (devotee.gender == "Female") {
  //       return Colors.pink;
  //     }
  //   }

  //   return Colors.yellow;
  // }