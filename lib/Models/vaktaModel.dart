// ignore_for_file: file_names

import 'dart:convert';
import 'package:sdp/Models/sammilaniModel.dart';

class VaktaModel {
  String? docId;
  String? name;
  String? sangha;
  String? paaliDate;
  String? receiptDate;
  String? receiptNo;
  SammilaniModel? sammilaniData;
  double? pranaami;
  String? remark;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  VaktaModel({
    this.docId,
    this.name,
    this.sangha,
    this.paaliDate,
    this.receiptDate,
    this.receiptNo,
    this.sammilaniData,
    this.pranaami,
    this.remark,
    this.createdBy,
    this.createdOn,
    this.updatedBy,
    this.updatedOn,
  });

  VaktaModel copyWith({
    String? docId,
    String? name,
    String? sangha,
    String? paaliDate,
    String? receiptDate,
    String? receiptNo,
    SammilaniModel? sammilaniData,
    double? pranaami,
    String? remark,
    String? createdBy,
    String? createdOn,
    String? updatedBy,
    String? updatedOn,
  }) {
    return VaktaModel(
      docId: docId ?? this.docId,
      name: name ?? this.name,
      sangha: sangha ?? this.sangha,
      paaliDate: paaliDate ?? this.paaliDate,
      receiptDate: receiptDate ?? this.receiptDate,
      receiptNo: receiptNo ?? this.receiptNo,
      sammilaniData: sammilaniData ?? this.sammilaniData,
      pranaami: pranaami ?? this.pranaami,
      remark: remark ?? this.remark,
      createdBy: createdBy ?? this.createdBy,
      createdOn: createdOn ?? this.createdOn,
      updatedBy: updatedBy ?? this.updatedBy,
      updatedOn: updatedOn ?? this.updatedOn,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (docId != null) {
      result.addAll({'docId': docId});
    }
    if (name != null) {
      result.addAll({'name': name});
    }
    if (sangha != null) {
      result.addAll({'sangha': sangha});
    }
    if (paaliDate != null) {
      result.addAll({'paaliDate': paaliDate});
    }
    if (receiptDate != null) {
      result.addAll({'receiptDate': receiptDate});
    }
    if (receiptNo != null) {
      result.addAll({'receiptNo': receiptNo});
    }
    if (sammilaniData != null) {
      result.addAll({'sammilaniData': sammilaniData!.toMap()});
    }
    if (pranaami != null) {
      result.addAll({'pranaami': pranaami});
    }
    if (remark != null) {
      result.addAll({'remark': remark});
    }
    if (createdBy != null) {
      result.addAll({'createdBy': createdBy});
    }
    if (createdOn != null) {
      result.addAll({'createdOn': createdOn});
    }
    if (updatedBy != null) {
      result.addAll({'updatedBy': updatedBy});
    }
    if (updatedOn != null) {
      result.addAll({'updatedOn': updatedOn});
    }

    return result;
  }

  factory VaktaModel.fromMap(Map<String, dynamic> map) {
    return VaktaModel(
      docId: map['docId'],
      name: map['name'],
      sangha: map['sangha'],
      paaliDate: map['paaliDate'],
      receiptDate: map['receiptDate'],
      receiptNo: map['receiptNo'],
      sammilaniData: map['sammilaniData'] != null
          ? SammilaniModel.fromMap(map['sammilaniData'])
          : null,
      pranaami: map['pranaami']?.toDouble(),
      remark: map['remark'],
      createdBy: map['createdBy'],
      createdOn: map['createdOn'],
      updatedBy: map['updatedBy'],
      updatedOn: map['updatedOn'],
    );
  }

  String toJson() => json.encode(toMap());

  factory VaktaModel.fromJson(String source) =>
      VaktaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'VaktaModel(docId: $docId, name: $name, sangha: $sangha, paaliDate: $paaliDate, receiptDate: $receiptDate, receiptNo: $receiptNo, sammilaniData: $sammilaniData, pranaami: $pranaami, remark: $remark, createdBy: $createdBy, createdOn: $createdOn, updatedBy: $updatedBy, updatedOn: $updatedOn)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is VaktaModel &&
        other.docId == docId &&
        other.name == name &&
        other.sangha == sangha &&
        other.paaliDate == paaliDate &&
        other.receiptDate == receiptDate &&
        other.receiptNo == receiptNo &&
        other.sammilaniData == sammilaniData &&
        other.pranaami == pranaami &&
        other.remark == remark &&
        other.createdBy == createdBy &&
        other.createdOn == createdOn &&
        other.updatedBy == updatedBy &&
        other.updatedOn == updatedOn;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        name.hashCode ^
        sangha.hashCode ^
        paaliDate.hashCode ^
        receiptDate.hashCode ^
        receiptNo.hashCode ^
        sammilaniData.hashCode ^
        pranaami.hashCode ^
        remark.hashCode ^
        createdBy.hashCode ^
        createdOn.hashCode ^
        updatedBy.hashCode ^
        updatedOn.hashCode;
  }
}
