// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  String? paymentMode;
  String? sangha;
  String? role;
  String? uid;
  bool? hasParichayaPatra;
  bool? isGuest;
  bool? isOrganizer;
  bool? isSpeciallyAbled;
  String? dob;
  String? ageGroup;
  bool? isKYDVerified;
  bool? isApproved;
  bool? isRejected;
  bool? isAdmin;
  bool? isGruhasanaApproved;
  String? createdOn;
  String? approvedBy;
  String? rejectedBy;
  String? updatedOn;
  String? status;
  double? paidAmount;
  String? createdById;
  String? createdByUUID;
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
    this.paymentMode,
    this.sangha,
    this.role,
    this.uid,
    this.hasParichayaPatra,
    this.isGuest,
    this.isOrganizer,
    this.isSpeciallyAbled,
    this.dob,
    this.ageGroup,
    this.isKYDVerified,
    this.isApproved,
    this.isRejected,
    this.isAdmin,
    this.isGruhasanaApproved,
    this.createdOn,
    this.approvedBy,
    this.rejectedBy,
    this.updatedOn,
    this.status,
    this.paidAmount,
    this.createdById,
    this.createdByUUID,
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
    String? paymentMode,
    String? sangha,
    String? role,
    String? uid,
    bool? hasParichayaPatra,
    bool? isGuest,
    bool? isOrganizer,
    bool? isSpeciallyAbled,
    String? dob,
    String? ageGroup,
    bool? isKYDVerified,
    bool? isApproved,
    bool? isRejected,
    bool? isAdmin,
    bool? isGruhasanaApproved,
    String? createdOn,
    String? approvedBy,
    String? rejectedBy,
    String? updatedOn,
    String? status,
    double? paidAmount,
    String? createdById,
    String? createdByUUID,
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
      paymentMode: paymentMode ?? this.paymentMode,
      sangha: sangha ?? this.sangha,
      role: role ?? this.role,
      uid: uid ?? this.uid,
      hasParichayaPatra: hasParichayaPatra ?? this.hasParichayaPatra,
      isGuest: isGuest ?? this.isGuest,
      isOrganizer: isOrganizer ?? this.isOrganizer,
      isSpeciallyAbled: isSpeciallyAbled ?? this.isSpeciallyAbled,
      dob: dob ?? this.dob,
      ageGroup: ageGroup ?? this.ageGroup,
      isKYDVerified: isKYDVerified ?? this.isKYDVerified,
      isApproved: isApproved ?? this.isApproved,
      isRejected: isRejected ?? this.isRejected,
      isAdmin: isAdmin ?? this.isAdmin,
      isGruhasanaApproved: isGruhasanaApproved ?? this.isGruhasanaApproved,
      createdOn: createdOn ?? this.createdOn,
      approvedBy: approvedBy ?? this.approvedBy,
      rejectedBy: rejectedBy ?? this.rejectedBy,
      updatedOn: updatedOn ?? this.updatedOn,
      status: status ?? this.status,
      paidAmount: paidAmount ?? this.paidAmount,
      createdById: createdById ?? this.createdById,
      createdByUUID: createdByUUID ?? this.createdByUUID,
      remarks: remarks ?? this.remarks,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (devoteeId != null) {
      result.addAll({'devoteeId': devoteeId});
    }
    if (devoteeCode != null) {
      result.addAll({'devoteeCode': devoteeCode});
    }
    if (isAllowedToScanPrasad != null) {
      result.addAll({'isAllowedToScanPrasad': isAllowedToScanPrasad});
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
    if (paymentMode != null) {
      result.addAll({'paymentMode': paymentMode});
    }
    if (sangha != null) {
      result.addAll({'sangha': sangha});
    }
    if (role != null) {
      result.addAll({'role': role});
    }
    if (uid != null) {
      result.addAll({'uid': uid});
    }
    if (hasParichayaPatra != null) {
      result.addAll({'hasParichayaPatra': hasParichayaPatra});
    }
    if (isGuest != null) {
      result.addAll({'isGuest': isGuest});
    }
    if (isOrganizer != null) {
      result.addAll({'isOrganizer': isOrganizer});
    }
    if (isSpeciallyAbled != null) {
      result.addAll({'isSpeciallyAbled': isSpeciallyAbled});
    }
    if (dob != null) {
      result.addAll({'dob': dob});
    }
    if (ageGroup != null) {
      result.addAll({'ageGroup': ageGroup});
    }
    if (isKYDVerified != null) {
      result.addAll({'isKYDVerified': isKYDVerified});
    }
    if (isApproved != null) {
      result.addAll({'isApproved': isApproved});
    }
    if (isRejected != null) {
      result.addAll({'isRejected': isRejected});
    }
    if (isAdmin != null) {
      result.addAll({'isAdmin': isAdmin});
    }
    if (isGruhasanaApproved != null) {
      result.addAll({'isGruhasanaApproved': isGruhasanaApproved});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (approvedBy != null) {
      result.addAll({'approvedBy': approvedBy});
    }
    if (rejectedBy != null) {
      result.addAll({'rejectedBy': rejectedBy});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }
    if (status != null) {
      result.addAll({'status': status});
    }
    if (paidAmount != null) {
      result.addAll({'paidAmount': paidAmount});
    }
    if (createdById != null) {
      result.addAll({'createdById': createdById});
    }
    if (createdByUUID != null) {
      result.addAll({'createdByUUID': createdByUUID});
    }
    if (remarks != null) {
      result.addAll({'remarks': remarks});
    }
    if (address != null) {
      result.addAll({'address': address!.toMap()});
    }

    return result;
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
      paymentMode: map['paymentMode'],
      sangha: map['sangha'],
      role: map['role'],
      uid: map['uid'],
      hasParichayaPatra: map['hasParichayaPatra'],
      isGuest: map['isGuest'],
      isOrganizer: map['isOrganizer'],
      isSpeciallyAbled: map['isSpeciallyAbled'],
      dob: map['dob'],
      ageGroup: map['ageGroup'],
      isKYDVerified: map['isKYDVerified'],
      isApproved: map['isApproved'],
      isRejected: map['isRejected'],
      isAdmin: map['isAdmin'],
      isGruhasanaApproved: map['isGruhasanaApproved'],
      createdOn: map['createdOn'],
      approvedBy: map['approvedBy'],
      rejectedBy: map['rejectedBy'],
      updatedOn: map['updatedOn'],
      status: map['status'],
      paidAmount: map['paidAmount']?.toDouble(),
      createdById: map['createdById'],
      createdByUUID: map['createdByUUID'],
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
    return 'DevoteeModel(devoteeId: $devoteeId, devoteeCode: $devoteeCode, isAllowedToScanPrasad: $isAllowedToScanPrasad, name: $name, emailId: $emailId, mobileNumber: $mobileNumber, bloodGroup: $bloodGroup, profilePhotoUrl: $profilePhotoUrl, gender: $gender, paymentMode: $paymentMode, sangha: $sangha, role: $role, uid: $uid, hasParichayaPatra: $hasParichayaPatra, isGuest: $isGuest, isOrganizer: $isOrganizer, isSpeciallyAbled: $isSpeciallyAbled, dob: $dob, ageGroup: $ageGroup, isKYDVerified: $isKYDVerified, isApproved: $isApproved, isRejected: $isRejected, isAdmin: $isAdmin, isGruhasanaApproved: $isGruhasanaApproved, createdOn: $createdOn, approvedBy: $approvedBy, rejectedBy: $rejectedBy, updatedOn: $updatedOn, status: $status, paidAmount: $paidAmount, createdById: $createdById, createdByUUID: $createdByUUID, remarks: $remarks, address: $address)';
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
        other.paymentMode == paymentMode &&
        other.sangha == sangha &&
        other.role == role &&
        other.uid == uid &&
        other.hasParichayaPatra == hasParichayaPatra &&
        other.isGuest == isGuest &&
        other.isOrganizer == isOrganizer &&
        other.isSpeciallyAbled == isSpeciallyAbled &&
        other.dob == dob &&
        other.ageGroup == ageGroup &&
        other.isKYDVerified == isKYDVerified &&
        other.isApproved == isApproved &&
        other.isRejected == isRejected &&
        other.isAdmin == isAdmin &&
        other.isGruhasanaApproved == isGruhasanaApproved &&
        other.createdOn == createdOn &&
        other.approvedBy == approvedBy &&
        other.rejectedBy == rejectedBy &&
        other.updatedOn == updatedOn &&
        other.status == status &&
        other.paidAmount == paidAmount &&
        other.createdById == createdById &&
        other.createdByUUID == createdByUUID &&
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
        paymentMode.hashCode ^
        sangha.hashCode ^
        role.hashCode ^
        uid.hashCode ^
        hasParichayaPatra.hashCode ^
        isGuest.hashCode ^
        isOrganizer.hashCode ^
        isSpeciallyAbled.hashCode ^
        dob.hashCode ^
        ageGroup.hashCode ^
        isKYDVerified.hashCode ^
        isApproved.hashCode ^
        isRejected.hashCode ^
        isAdmin.hashCode ^
        isGruhasanaApproved.hashCode ^
        createdOn.hashCode ^
        approvedBy.hashCode ^
        rejectedBy.hashCode ^
        updatedOn.hashCode ^
        status.hashCode ^
        paidAmount.hashCode ^
        createdById.hashCode ^
        createdByUUID.hashCode ^
        remarks.hashCode ^
        address.hashCode;
  }
}
