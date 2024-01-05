// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SanghaModel {
  int? sanghaId;
  String? sanghaName;
  String? jillaSanghaName;
  String? sabhapatiName;
  String? sampadakaName;
  String? address;
  bool? isItPathachakra;
  bool? isApproved;
  int? devoteeCount;
  String? ashramArea;
  SanghaModel({
    this.sanghaId,
    this.sanghaName,
    this.jillaSanghaName,
    this.sabhapatiName,
    this.sampadakaName,
    this.address,
    this.isItPathachakra,
    this.isApproved,
    this.devoteeCount,
    this.ashramArea,
  });

  SanghaModel copyWith({
    int? sanghaId,
    String? sanghaName,
    String? jillaSanghaName,
    String? sabhapatiName,
    String? sampadakaName,
    String? address,
    bool? isItPathachakra,
    bool? isApproved,
    int? devoteeCount,
    String? ashramArea,
  }) {
    return SanghaModel(
      sanghaId: sanghaId ?? this.sanghaId,
      sanghaName: sanghaName ?? this.sanghaName,
      jillaSanghaName: jillaSanghaName ?? this.jillaSanghaName,
      sabhapatiName: sabhapatiName ?? this.sabhapatiName,
      sampadakaName: sampadakaName ?? this.sampadakaName,
      address: address ?? this.address,
      isItPathachakra: isItPathachakra ?? this.isItPathachakra,
      isApproved: isApproved ?? this.isApproved,
      devoteeCount: devoteeCount ?? this.devoteeCount,
      ashramArea: ashramArea ?? this.ashramArea,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sanghaId': sanghaId,
      'sanghaName': sanghaName,
      'jillaSanghaName': jillaSanghaName,
      'sabhapatiName': sabhapatiName,
      'sampadakaName': sampadakaName,
      'address': address,
      'isItPathachakra': isItPathachakra,
      'isApproved': isApproved,
      'devoteeCount': devoteeCount,
      'ashramArea': ashramArea,
    };
  }

  factory SanghaModel.fromMap(Map<String, dynamic> map) {
    return SanghaModel(
      sanghaId: map['sanghaId'] != null ? int.parse(map['sanghaId']) : null,
      sanghaName:
          map['sanghaName'] != null ? map['sanghaName'] as String : null,
      jillaSanghaName: map['jillaSanghaName'] != null
          ? map['jillaSanghaName'] as String
          : null,
      sabhapatiName:
          map['sabhapatiName'] != null ? map['sabhapatiName'] as String : null,
      sampadakaName:
          map['sampadakaName'] != null ? map['sampadakaName'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      isItPathachakra: map['isItPathachakra'] != null
          ? map['isItPathachakra'] as bool
          : null,
      isApproved: map['isApproved'] != null ? map['isApproved'] as bool : null,
      devoteeCount:
          map['devoteeCount'] != null ? map['devoteeCount'] as int : null,
      ashramArea:
          map['ashramArea'] != null ? map['ashramArea'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SanghaModel.fromJson(String source) =>
      SanghaModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SanghaModel(sanghaId: $sanghaId, sanghaName: $sanghaName, jillaSanghaName: $jillaSanghaName, sabhapatiName: $sabhapatiName, sampadakaName: $sampadakaName, address: $address, isItPathachakra: $isItPathachakra, isApproved: $isApproved, devoteeCount: $devoteeCount, ashramArea: $ashramArea)';
  }

  @override
  bool operator ==(covariant SanghaModel other) {
    if (identical(this, other)) return true;

    return other.sanghaId == sanghaId &&
        other.sanghaName == sanghaName &&
        other.jillaSanghaName == jillaSanghaName &&
        other.sabhapatiName == sabhapatiName &&
        other.sampadakaName == sampadakaName &&
        other.address == address &&
        other.isItPathachakra == isItPathachakra &&
        other.isApproved == isApproved &&
        other.devoteeCount == devoteeCount &&
        other.ashramArea == ashramArea;
  }

  @override
  int get hashCode {
    return sanghaId.hashCode ^
        sanghaName.hashCode ^
        jillaSanghaName.hashCode ^
        sabhapatiName.hashCode ^
        sampadakaName.hashCode ^
        address.hashCode ^
        isItPathachakra.hashCode ^
        isApproved.hashCode ^
        devoteeCount.hashCode ^
        ashramArea.hashCode;
  }
}
