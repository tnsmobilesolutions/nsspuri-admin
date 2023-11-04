// ignore_for_file: file_names

import 'dart:convert';

class SammilaniModel {
  String? sammilaniNumber;
  String? sammilaniYear;
  String? sammilaniPlace;
  SammilaniModel({
    this.sammilaniNumber,
    this.sammilaniYear,
    this.sammilaniPlace,
  });

  SammilaniModel copyWith({
    String? sammilaniNumber,
    String? sammilaniYear,
    String? sammilaniPlace,
  }) {
    return SammilaniModel(
      sammilaniNumber: sammilaniNumber ?? this.sammilaniNumber,
      sammilaniYear: sammilaniYear ?? this.sammilaniYear,
      sammilaniPlace: sammilaniPlace ?? this.sammilaniPlace,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (sammilaniNumber != null) {
      result.addAll({'sammilaniNumber': sammilaniNumber});
    }
    if (sammilaniYear != null) {
      result.addAll({'sammilaniYear': sammilaniYear});
    }
    if (sammilaniPlace != null) {
      result.addAll({'sammilaniPlace': sammilaniPlace});
    }

    return result;
  }

  factory SammilaniModel.fromMap(Map<String, dynamic> map) {
    return SammilaniModel(
      sammilaniNumber: map['sammilaniNumber'],
      sammilaniYear: map['sammilaniYear'],
      sammilaniPlace: map['sammilaniPlace'],
    );
  }

  String toJson() => json.encode(toMap());

  factory SammilaniModel.fromJson(String source) =>
      SammilaniModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'SammilaniModel(sammilaniNumber: $sammilaniNumber, sammilaniYear: $sammilaniYear, sammilaniPlace: $sammilaniPlace)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SammilaniModel &&
        other.sammilaniNumber == sammilaniNumber &&
        other.sammilaniYear == sammilaniYear &&
        other.sammilaniPlace == sammilaniPlace;
  }

  @override
  int get hashCode =>
      sammilaniNumber.hashCode ^
      sammilaniYear.hashCode ^
      sammilaniPlace.hashCode;
}
