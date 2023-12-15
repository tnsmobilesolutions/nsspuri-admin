import 'dart:convert';

class DashboardStatusModel {
  String? title;
  String? message;
  String? status;
  int? count;
  DashboardStatusModel({
    this.title,
    this.message,
    this.status,
    this.count,
  });

  DashboardStatusModel copyWith({
    String? title,
    String? message,
    String? status,
    int? count,
  }) {
    return DashboardStatusModel(
      title: title ?? this.title,
      message: message ?? this.message,
      status: status ?? this.status,
      count: count ?? this.count,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    if(title != null){
      result.addAll({'title': title});
    }
    if(message != null){
      result.addAll({'message': message});
    }
    if(status != null){
      result.addAll({'status': status});
    }
    if(count != null){
      result.addAll({'count': count});
    }
  
    return result;
  }

  factory DashboardStatusModel.fromMap(Map<String, dynamic> map) {
    return DashboardStatusModel(
      title: map['title'],
      message: map['message'],
      status: map['status'],
      count: map['count']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory DashboardStatusModel.fromJson(String source) =>
      DashboardStatusModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DashboardStatusModel(title: $title, message: $message, status: $status, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is DashboardStatusModel &&
      other.title == title &&
      other.message == message &&
      other.status == status &&
      other.count == count;
  }

  @override
  int get hashCode {
    return title.hashCode ^
      message.hashCode ^
      status.hashCode ^
      count.hashCode;
  }
}
