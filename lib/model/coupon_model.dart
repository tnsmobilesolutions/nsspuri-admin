import 'dart:convert';

import 'package:flutter/foundation.dart';

class CouponModel {
  String? date;
  int? balyaCount;
  int? madhyanaCount;
  int? ratraCount;
  List<String>? balyaTiming;
  List<String>? madhyanaTiming;
  List<String>? ratraTiming;
  CouponModel({
    this.date,
    this.balyaCount,
    this.madhyanaCount,
    this.ratraCount,
    this.balyaTiming,
    this.madhyanaTiming,
    this.ratraTiming,
  });

  CouponModel copyWith({
    String? date,
    int? balyaCount,
    int? madhyanaCount,
    int? ratraCount,
    List<String>? balyaTiming,
    List<String>? madhyanaTiming,
    List<String>? ratraTiming,
  }) {
    return CouponModel(
      date: date ?? this.date,
      balyaCount: balyaCount ?? this.balyaCount,
      madhyanaCount: madhyanaCount ?? this.madhyanaCount,
      ratraCount: ratraCount ?? this.ratraCount,
      balyaTiming: balyaTiming ?? this.balyaTiming,
      madhyanaTiming: madhyanaTiming ?? this.madhyanaTiming,
      ratraTiming: ratraTiming ?? this.ratraTiming,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'balyaCount': balyaCount,
      'madhyanaCount': madhyanaCount,
      'ratraCount': ratraCount,
      'balyaTiming': balyaTiming,
      'madhyanaTiming': madhyanaTiming,
      'ratraTiming': ratraTiming,
    };
  }

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      date: map['date'],
      balyaCount: map['balyaCount']?.toInt(),
      madhyanaCount: map['madhyanaCount']?.toInt(),
      ratraCount: map['ratraCount']?.toInt(),
      balyaTiming: List<String>.from(map['balyaTiming']),
      madhyanaTiming: List<String>.from(map['madhyanaTiming']),
      ratraTiming: List<String>.from(map['ratraTiming']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CouponModel.fromJson(String source) =>
      CouponModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CouponModel(date: $date, balyaCount: $balyaCount, madhyanaCount: $madhyanaCount, ratraCount: $ratraCount, balyaTiming: $balyaTiming, madhyanaTiming: $madhyanaTiming, ratraTiming: $ratraTiming)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CouponModel &&
        other.date == date &&
        other.balyaCount == balyaCount &&
        other.madhyanaCount == madhyanaCount &&
        other.ratraCount == ratraCount &&
        listEquals(other.balyaTiming, balyaTiming) &&
        listEquals(other.madhyanaTiming, madhyanaTiming) &&
        listEquals(other.ratraTiming, ratraTiming);
  }

  @override
  int get hashCode {
    return date.hashCode ^
        balyaCount.hashCode ^
        madhyanaCount.hashCode ^
        ratraCount.hashCode ^
        balyaTiming.hashCode ^
        madhyanaTiming.hashCode ^
        ratraTiming.hashCode;
  }
}
