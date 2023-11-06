import 'dart:convert';

import 'package:sdp/model/address_model.dart';

class DevoteeModel {
  String? devoteeId;
  String? name;
  String? emailId;
  String? mobileNumber;
  String? bloodGroup;
  String? profilePhotoUrl;
  String? gender;
  String? sangha;
  String? uid;
  String? dob;
  String? createdAt;
  String? updatedAt;
  AddressModel? address;
  DevoteeModel({
    this.devoteeId,
    this.name,
    this.emailId,
    this.mobileNumber,
    this.bloodGroup,
    this.profilePhotoUrl,
    this.gender,
    this.sangha,
    this.uid,
    this.dob,
    this.createdAt,
    this.updatedAt,
    this.address,
  });

  DevoteeModel copyWith({
    String? devoteeId,
    String? name,
    String? emailId,
    String? mobileNumber,
    String? bloodGroup,
    String? profilePhotoUrl,
    String? gender,
    String? sangha,
    String? uid,
    String? dob,
    String? createdAt,
    String? updatedAt,
    AddressModel? address,
  }) {
    return DevoteeModel(
      devoteeId: devoteeId ?? this.devoteeId,
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      gender: gender ?? this.gender,
      sangha: sangha ?? this.sangha,
      uid: uid ?? this.uid,
      dob: dob ?? this.dob,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (devoteeId != null) {
      result.addAll({'devoteeId': devoteeId});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (emailId != null) {
      result.addAll({'emailId': emailId});
    }
    if (mobileNumber != null) {
      result.addAll({'mobileNumber': mobileNumber});
    }
    if (bloodGroup != null) {
      result.addAll({'bloodGroup': bloodGroup});
    }
    if (profilePhotoUrl != null) {
      result.addAll({'profilePhotoUrl': profilePhotoUrl});
    }
    if (gender != null) {
      result.addAll({'gender': gender});
    }
    if (sangha != null) {
      result.addAll({'sangha': sangha});
    }
    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (dob != null) {
      result.addAll({'dob': dob});
    }
    if (createdAt != null) {
      result.addAll({'createdAt': createdAt});
    }
    if (updatedAt != null) {
      result.addAll({'updatedAt': updatedAt});
    }
    if (address != null) {
      result.addAll({'address': address!.toMap()});
    }

    return result;
  }

  factory DevoteeModel.fromMap(Map<String, dynamic> map) {
    return DevoteeModel(
      devoteeId: map['devoteeId'],
      name: map['name'],
      emailId: map['emailId'],
      mobileNumber: map['mobileNumber'],
      bloodGroup: map['bloodGroup'],
      profilePhotoUrl: map['profilePhotoUrl'],
      gender: map['gender'],
      sangha: map['sangha'],
      uid: map['uid'],
      dob: map['dob'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) =>
      DevoteeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, uid: $uid, dob: $dob, createdAt: $createdAt, updatedAt: $updatedAt, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DevoteeModel &&
        other.devoteeId == devoteeId &&
        other.name == name &&
        other.emailId == emailId &&
        other.mobileNumber == mobileNumber &&
        other.bloodGroup == bloodGroup &&
        other.profilePhotoUrl == profilePhotoUrl &&
        other.gender == gender &&
        other.sangha == sangha &&
        other.uid == uid &&
        other.dob == dob &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.address == address;
  }

  @override
  int get hashCode {
    return devoteeId.hashCode ^
        name.hashCode ^
        emailId.hashCode ^
        mobileNumber.hashCode ^
        bloodGroup.hashCode ^
        profilePhotoUrl.hashCode ^
        gender.hashCode ^
        sangha.hashCode ^
        uid.hashCode ^
        dob.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        address.hashCode;
  }
}
