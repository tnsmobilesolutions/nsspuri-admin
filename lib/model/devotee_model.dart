import 'dart:convert';

import 'package:sdp/model/address_model.dart';

class DevoteeModel {
  String? devoteeId;
  int? devoteeCode;
  bool? isAllowedToScanPrasad;
  String? name;
  String? emailId;
  String? mobileNumber;
  String? bloodGroup;
  String? profilePhotoUrl;
  String? gender;
  String? sangha;
  String? uid;
  bool? isGuest;
  bool? isOrganizer;
  bool? isSpeciallyAbled;
  String? dob;
  bool? isKYDVerified;
  bool? isApproved;
  bool? isAdmin;
  bool? isGruhasanaApproved;
  String? createdOn;
  String? updatedOn;
  String? status;
  String? createdById;
  AddressModel? address;
  DevoteeModel({
    this.devoteeId,
    this.devoteeCode,
    this.isAllowedToScanPrasad,
    this.name,
    this.emailId,
    this.mobileNumber,
    this.bloodGroup,
    this.profilePhotoUrl,
    this.gender,
    this.sangha,
    this.uid,
    this.isGuest,
    this.isOrganizer,
    this.isSpeciallyAbled,
    this.dob,
    this.isKYDVerified,
    this.isApproved,
    this.isAdmin,
    this.isGruhasanaApproved,
    this.createdOn,
    this.updatedOn,
    this.status,
    this.createdById,
    this.address,
  });

  DevoteeModel copyWith({
    String? devoteeId,
    int? devoteeCode,
    bool? isAllowedToScanPrasad,
    String? name,
    String? emailId,
    String? mobileNumber,
    String? bloodGroup,
    String? profilePhotoUrl,
    String? gender,
    String? sangha,
    String? uid,
    bool? isGuest,
    bool? isOrganizer,
    bool? isSpeciallyAbled,
    String? dob,
    bool? isKYDVerified,
    bool? isApproved,
    bool? isAdmin,
    bool? isGruhasanaApproved,
    String? createdOn,
    String? updatedOn,
    String? status,
    String? createdById,
    AddressModel? address,
  }) {
    return DevoteeModel(
      devoteeId: devoteeId ?? this.devoteeId,
      devoteeCode: devoteeCode ?? this.devoteeCode,
      isAllowedToScanPrasad:
          isAllowedToScanPrasad ?? this.isAllowedToScanPrasad,
      name: name ?? this.name,
      emailId: emailId ?? this.emailId,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      gender: gender ?? this.gender,
      sangha: sangha ?? this.sangha,
      uid: uid ?? this.uid,
      isGuest: isGuest ?? this.isGuest,
      isOrganizer: isOrganizer ?? this.isOrganizer,
      isSpeciallyAbled: isSpeciallyAbled ?? this.isSpeciallyAbled,
      dob: dob ?? this.dob,
      isKYDVerified: isKYDVerified ?? this.isKYDVerified,
      isApproved: isApproved ?? this.isApproved,
      isAdmin: isAdmin ?? this.isAdmin,
      isGruhasanaApproved: isGruhasanaApproved ?? this.isGruhasanaApproved,
      createdOn: createdOn ?? this.createdOn,
      updatedOn: updatedOn ?? this.updatedOn,
      status: status ?? this.status,
      createdById: createdById ?? this.createdById,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'devoteeId': devoteeId,
      'devoteeCode': devoteeCode,
      'isAllowedToScanPrasad': isAllowedToScanPrasad,
      'name': name,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      'bloodGroup': bloodGroup,
      'profilePhotoUrl': profilePhotoUrl,
      'gender': gender,
      'sangha': sangha,
      'uid': uid,
      'isGuest': isGuest,
      'isOrganizer': isOrganizer,
      'isSpeciallyAbled': isSpeciallyAbled,
      'dob': dob,
      'isKYDVerified': isKYDVerified,
      'isApproved': isApproved,
      'isAdmin': isAdmin,
      'isGruhasanaApproved': isGruhasanaApproved,
      'createdOn': createdOn,
      'updatedOn': updatedOn,
      'status': status,
      'createdById': createdById,
      'address': address?.toMap(),
    };
  }

  factory DevoteeModel.fromMap(Map<String, dynamic> map) {
    return DevoteeModel(
      devoteeId: map['devoteeId'],
      devoteeCode: map['devoteeCode']?.toInt(),
      isAllowedToScanPrasad: map['isAllowedToScanPrasad'],
      name: map['name'],
      emailId: map['emailId'],
      mobileNumber: map['mobileNumber'],
      bloodGroup: map['bloodGroup'],
      profilePhotoUrl: map['profilePhotoUrl'],
      gender: map['gender'],
      sangha: map['sangha'],
      uid: map['uid'],
      isGuest: map['isGuest'],
      isOrganizer: map['isOrganizer'],
      isSpeciallyAbled: map['isSpeciallyAbled'],
      dob: map['dob'],
      isKYDVerified: map['isKYDVerified'],
      isApproved: map['isApproved'],
      isAdmin: map['isAdmin'],
      isGruhasanaApproved: map['isGruhasanaApproved'],
      createdOn: map['createdOn'],
      updatedOn: map['updatedOn'],
      status: map['status'],
      createdById: map['createdById'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) =>
      DevoteeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, devoteeCode: $devoteeCode, isAllowedToScanPrasad: $isAllowedToScanPrasad, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, uid: $uid, isGuest: $isGuest, isOrganizer: $isOrganizer, isSpeciallyAbled: $isSpeciallyAbled, dob: $dob, isKYDVerified: $isKYDVerified, isApproved: $isApproved, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, updatedOn: $updatedOn, status: $status, createdById: $createdById, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DevoteeModel &&
        other.devoteeId == devoteeId &&
        other.devoteeCode == devoteeCode &&
        other.isAllowedToScanPrasad == isAllowedToScanPrasad &&
        other.name == name &&
        other.emailId == emailId &&
        other.mobileNumber == mobileNumber &&
        other.bloodGroup == bloodGroup &&
        other.profilePhotoUrl == profilePhotoUrl &&
        other.gender == gender &&
        other.sangha == sangha &&
        other.uid == uid &&
        other.isGuest == isGuest &&
        other.isOrganizer == isOrganizer &&
        other.isSpeciallyAbled == isSpeciallyAbled &&
        other.dob == dob &&
        other.isKYDVerified == isKYDVerified &&
        other.isApproved == isApproved &&
        other.isAdmin == isAdmin &&
        other.isGruhasanaApproved == isGruhasanaApproved &&
        other.createdOn == createdOn &&
        other.updatedOn == updatedOn &&
        other.status == status &&
        other.createdById == createdById &&
        other.address == address;
  }

  @override
  int get hashCode {
    return devoteeId.hashCode ^
        devoteeCode.hashCode ^
        isAllowedToScanPrasad.hashCode ^
        name.hashCode ^
        emailId.hashCode ^
        mobileNumber.hashCode ^
        bloodGroup.hashCode ^
        profilePhotoUrl.hashCode ^
        gender.hashCode ^
        sangha.hashCode ^
        uid.hashCode ^
        isGuest.hashCode ^
        isOrganizer.hashCode ^
        isSpeciallyAbled.hashCode ^
        dob.hashCode ^
        isKYDVerified.hashCode ^
        isApproved.hashCode ^
        isAdmin.hashCode ^
        isGruhasanaApproved.hashCode ^
        createdOn.hashCode ^
        updatedOn.hashCode ^
        status.hashCode ^
        createdById.hashCode ^
        address.hashCode;
  }
}
