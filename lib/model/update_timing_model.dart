import 'dart:convert';

class UpadateTimeModel {
  String? balyaStartTime;
  String? balyaEndTime;
  String? madhyanaStartTime;
  String? madhyanaEndTime;
  String? ratraStartTime;
  String? ratraEndTime;
  String? prasadFirstDate;
  String? prasadSecondDate;
  String? prasadThirdDate;
  UpadateTimeModel({
    this.balyaStartTime,
    this.balyaEndTime,
    this.madhyanaStartTime,
    this.madhyanaEndTime,
    this.ratraStartTime,
    this.ratraEndTime,
    this.prasadFirstDate,
    this.prasadSecondDate,
    this.prasadThirdDate,
  });

  UpadateTimeModel copyWith({
    String? balyaStartTime,
    String? balyaEndTime,
    String? madhyanaStartTime,
    String? madhyanaEndTime,
    String? ratraStartTime,
    String? ratraEndTime,
    String? prasadFirstDate,
    String? prasadSecondDate,
    String? prasadThirdDate,
  }) {
    return UpadateTimeModel(
      balyaStartTime: balyaStartTime ?? this.balyaStartTime,
      balyaEndTime: balyaEndTime ?? this.balyaEndTime,
      madhyanaStartTime: madhyanaStartTime ?? this.madhyanaStartTime,
      madhyanaEndTime: madhyanaEndTime ?? this.madhyanaEndTime,
      ratraStartTime: ratraStartTime ?? this.ratraStartTime,
      ratraEndTime: ratraEndTime ?? this.ratraEndTime,
      prasadFirstDate: prasadFirstDate ?? this.prasadFirstDate,
      prasadSecondDate: prasadSecondDate ?? this.prasadSecondDate,
      prasadThirdDate: prasadThirdDate ?? this.prasadThirdDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'balyaStartTime': balyaStartTime,
      'balyaEndTime': balyaEndTime,
      'madhyanaStartTime': madhyanaStartTime,
      'madhyanaEndTime': madhyanaEndTime,
      'ratraStartTime': ratraStartTime,
      'ratraEndTime': ratraEndTime,
      'prasadFirstDate': prasadFirstDate,
      'prasadSecondDate': prasadSecondDate,
      'prasadThirdDate': prasadThirdDate,
    };
  }

  factory UpadateTimeModel.fromMap(Map<String, dynamic> map) {
    return UpadateTimeModel(
      balyaStartTime: map['balyaStartTime'] ?? '',
      balyaEndTime: map['balyaEndTime'] ?? '',
      madhyanaStartTime: map['madhyanaStartTime'] ?? '',
      madhyanaEndTime: map['madhyanaEndTime'] ?? '',
      ratraStartTime: map['ratraStartTime'] ?? '',
      ratraEndTime: map['ratraEndTime'] ?? '',
      prasadFirstDate: map['prasadFirstDate'] ?? '',
      prasadSecondDate: map['prasadSecondDate'] ?? '',
      prasadThirdDate: map['prasadThirdDate'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UpadateTimeModel.fromJson(String source) =>
      UpadateTimeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UpadateTimeModel(balyaStartTime: $balyaStartTime, balyaEndTime: $balyaEndTime, madhyanaStartTime: $madhyanaStartTime, madhyanaEndTime: $madhyanaEndTime, ratraStartTime: $ratraStartTime, ratraEndTime: $ratraEndTime, prasadFirstDate: $prasadFirstDate, prasadSecondDate: $prasadSecondDate, prasadThirdDate: $prasadThirdDate)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UpadateTimeModel &&
        other.balyaStartTime == balyaStartTime &&
        other.balyaEndTime == balyaEndTime &&
        other.madhyanaStartTime == madhyanaStartTime &&
        other.madhyanaEndTime == madhyanaEndTime &&
        other.ratraStartTime == ratraStartTime &&
        other.ratraEndTime == ratraEndTime &&
        other.prasadFirstDate == prasadFirstDate &&
        other.prasadSecondDate == prasadSecondDate &&
        other.prasadThirdDate == prasadThirdDate;
  }

  @override
  int get hashCode {
    return balyaStartTime.hashCode ^
        balyaEndTime.hashCode ^
        madhyanaStartTime.hashCode ^
        madhyanaEndTime.hashCode ^
        ratraStartTime.hashCode ^
        ratraEndTime.hashCode ^
        prasadFirstDate.hashCode ^
        prasadSecondDate.hashCode ^
        prasadThirdDate.hashCode;
  }
}
