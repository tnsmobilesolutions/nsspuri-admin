// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DashboardStatusModel {
  String? title;
  String? message;
  String? translate;
  String? status;
  int? count;
  DashboardStatusModel({
    this.title,
    this.message,
    this.translate,
    this.status,
    this.count,
  });

  DashboardStatusModel copyWith({
    String? title,
    String? message,
    String? translate,
    String? status,
    int? count,
  }) {
    return DashboardStatusModel(
      title: title ?? this.title,
      message: message ?? this.message,
      translate: translate ?? this.translate,
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'message': message,
      'translate': translate,
      'status': status,
      'count': count,
    };
  }

  factory DashboardStatusModel.fromMap(Map<String, dynamic> map) {
    return DashboardStatusModel(
      title: map['title'] != null ? map['title'] as String : null,
      message: map['message'] != null ? map['message'] as String : null,
      translate: map['translate'] != null ? map['translate'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      count: map['count'] != null ? map['count'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardStatusModel.fromJson(String source) => DashboardStatusModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DashboardStatusModel(title: $title, message: $message, translate: $translate, status: $status, count: $count)';
  }

  @override
  bool operator ==(covariant DashboardStatusModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.message == message &&
      other.translate == translate &&
      other.status == status &&
      other.count == count;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      message.hashCode ^
      translate.hashCode ^
      status.hashCode ^
      count.hashCode;
  }
}
