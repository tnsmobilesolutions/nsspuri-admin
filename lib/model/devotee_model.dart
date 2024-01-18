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
  String? role;
  String? uid;
  bool? hasParichayaPatra;
  bool? isGuest;
  bool? isOrganizer;
  bool? isSpeciallyAbled;
  String? dob;
  int? age;
  bool? isKYDVerified;
  bool? isApproved;
  bool? isAdmin;
  bool? isGruhasanaApproved;
  String? createdOn;
  String? approvedBy;
  String? updatedOn;
  String? status;
  double? paidAmount;
  String? createdById;
  String? remarks;
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
    this.role,
    this.uid,
    this.hasParichayaPatra,
    this.isGuest,
    this.isOrganizer,
    this.isSpeciallyAbled,
    this.dob,
    this.age,
    this.isKYDVerified,
    this.isApproved,
    this.isAdmin,
    this.isGruhasanaApproved,
    this.createdOn,
    this.approvedBy,
    this.updatedOn,
    this.status,
    this.paidAmount,
    this.createdById,
    this.remarks,
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
    String? role,
    String? uid,
    bool? hasParichayaPatra,
    bool? isGuest,
    bool? isOrganizer,
    bool? isSpeciallyAbled,
    String? dob,
    int? age,
    bool? isKYDVerified,
    bool? isApproved,
    bool? isAdmin,
    bool? isGruhasanaApproved,
    String? createdOn,
    String? approvedBy,
    String? updatedOn,
    String? status,
    double? paidAmount,
    String? createdById,
    String? remarks,
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
      role: role ?? this.role,
      uid: uid ?? this.uid,
      hasParichayaPatra: hasParichayaPatra ?? this.hasParichayaPatra,
      isGuest: isGuest ?? this.isGuest,
      isOrganizer: isOrganizer ?? this.isOrganizer,
      isSpeciallyAbled: isSpeciallyAbled ?? this.isSpeciallyAbled,
      dob: dob ?? this.dob,
      age: age ?? this.age,
      isKYDVerified: isKYDVerified ?? this.isKYDVerified,
      isApproved: isApproved ?? this.isApproved,
      isAdmin: isAdmin ?? this.isAdmin,
      isGruhasanaApproved: isGruhasanaApproved ?? this.isGruhasanaApproved,
      createdOn: createdOn ?? this.createdOn,
      approvedBy: approvedBy ?? this.approvedBy,
      updatedOn: updatedOn ?? this.updatedOn,
      status: status ?? this.status,
      paidAmount: paidAmount ?? this.paidAmount,
      createdById: createdById ?? this.createdById,
      remarks: remarks ?? this.remarks,
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
      'role': role,
      'uid': uid,
      'hasParichayaPatra': hasParichayaPatra,
      'isGuest': isGuest,
      'isOrganizer': isOrganizer,
      'isSpeciallyAbled': isSpeciallyAbled,
      'dob': dob,
      'age': age,
      'isKYDVerified': isKYDVerified,
      'isApproved': isApproved,
      'isAdmin': isAdmin,
      'isGruhasanaApproved': isGruhasanaApproved,
      'createdOn': createdOn,
      'approvedBy': approvedBy,
      'updatedOn': updatedOn,
      'status': status,
      'paidAmount': paidAmount,
      'createdById': createdById,
      'remarks': remarks,
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
      role: map['role'],
      uid: map['uid'],
      hasParichayaPatra: map['hasParichayaPatra'],
      isGuest: map['isGuest'],
      isOrganizer: map['isOrganizer'],
      isSpeciallyAbled: map['isSpeciallyAbled'],
      dob: map['dob'],
      age: map['age']?.toInt(),
      isKYDVerified: map['isKYDVerified'],
      isApproved: map['isApproved'],
      isAdmin: map['isAdmin'],
      isGruhasanaApproved: map['isGruhasanaApproved'],
      createdOn: map['createdOn'],
      approvedBy: map['approvedBy'],
      updatedOn: map['updatedOn'],
      status: map['status'],
      paidAmount: map['paidAmount']?.toDouble(),
      createdById: map['createdById'],
      remarks: map['remarks'],
      address:
          map['address'] != null ? AddressModel.fromMap(map['address']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DevoteeModel.fromJson(String source) =>
      DevoteeModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DevoteeModel(devoteeId: $devoteeId, devoteeCode: $devoteeCode, isAllowedToScanPrasad: $isAllowedToScanPrasad, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, sangha: $sangha, role: $role, uid: $uid, hasParichayaPatra: $hasParichayaPatra, isGuest: $isGuest, isOrganizer: $isOrganizer, isSpeciallyAbled: $isSpeciallyAbled, dob: $dob, age: $age, isKYDVerified: $isKYDVerified, isApproved: $isApproved, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, approvedBy: $approvedBy, updatedOn: $updatedOn, status: $status, paidAmount: $paidAmount, createdById: $createdById, remarks: $remarks, address: $address)';
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
        other.role == role &&
        other.uid == uid &&
        other.hasParichayaPatra == hasParichayaPatra &&
        other.isGuest == isGuest &&
        other.isOrganizer == isOrganizer &&
        other.isSpeciallyAbled == isSpeciallyAbled &&
        other.dob == dob &&
        other.age == age &&
        other.isKYDVerified == isKYDVerified &&
        other.isApproved == isApproved &&
        other.isAdmin == isAdmin &&
        other.isGruhasanaApproved == isGruhasanaApproved &&
        other.createdOn == createdOn &&
        other.approvedBy == approvedBy &&
        other.updatedOn == updatedOn &&
        other.status == status &&
        other.paidAmount == paidAmount &&
        other.createdById == createdById &&
        other.remarks == remarks &&
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
        role.hashCode ^
        uid.hashCode ^
        hasParichayaPatra.hashCode ^
        isGuest.hashCode ^
        isOrganizer.hashCode ^
        isSpeciallyAbled.hashCode ^
        dob.hashCode ^
        age.hashCode ^
        isKYDVerified.hashCode ^
        isApproved.hashCode ^
        isAdmin.hashCode ^
        isGruhasanaApproved.hashCode ^
        createdOn.hashCode ^
        approvedBy.hashCode ^
        updatedOn.hashCode ^
        status.hashCode ^
        paidAmount.hashCode ^
        createdById.hashCode ^
        remarks.hashCode ^
        address.hashCode;
  }
}
