// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashboardStatusModel {
  String? title;
  String? message;
  String? translate;
  String? status;
  int? count;
  int? online;
  int? offline;
  int? coupon;
  DashboardStatusModel({
    this.title,
    this.message,
    this.translate,
    this.status,
    this.count,
    this.online,
    this.offline,
    this.coupon,
  });

  DashboardStatusModel copyWith({
    String? title,
    String? message,
    String? translate,
    String? status,
    int? count,
    int? online,
    int? offline,
    int? coupon,
  }) {
    return DashboardStatusModel(
      title: title ?? this.title,
      message: message ?? this.message,
      translate: translate ?? this.translate,
      status: status ?? this.status,
      count: count ?? this.count,
      online: online ?? this.online,
      offline: offline ?? this.offline,
      coupon: coupon ?? this.coupon,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'translate': translate,
      'status': status,
      'count': count,
      'online': online,
      'offline': offline,
      'coupon': coupon,
    };
  }

  factory DashboardStatusModel.fromMap(Map<String, dynamic> map) {
    return DashboardStatusModel(
      title: map['title'],
      message: map['message'],
      translate: map['translate'],
      status: map['status'],
      count: map['count']?.toInt(),
      online: map['online']?.toInt(),
      offline: map['offline']?.toInt(),
      coupon: map['coupon']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardStatusModel.fromJson(String source) =>
      DashboardStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DashboardStatusModel(title: $title, message: $message, translate: $translate, status: $status, count: $count, online: $online, offline: $offline, coupon: $coupon)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DashboardStatusModel &&
        other.title == title &&
        other.message == message &&
        other.translate == translate &&
        other.status == status &&
        other.count == count &&
        other.online == online &&
        other.offline == offline &&
        other.coupon == coupon;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        message.hashCode ^
        translate.hashCode ^
        status.hashCode ^
        count.hashCode ^
        online.hashCode ^
        offline.hashCode ^
        coupon.hashCode;
  }
}
