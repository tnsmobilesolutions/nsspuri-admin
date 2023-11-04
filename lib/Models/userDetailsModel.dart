// ignore_for_file: file_names

import 'dart:convert';

class UserDetailsModel {
  String? name;
  String? uid;
  UserDetailsModel({
    this.name,
    this.uid,
  });

  UserDetailsModel copyWith({
    String? name,
    String? uid,
  }) {
    return UserDetailsModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    if (name != null) {
      result.addAll({'name': name});
    }
    if (uid != null) {
      result.addAll({'uid': uid});
    }

    return result;
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      name: map['name'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailsModel.fromJson(String source) =>
      UserDetailsModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserDetailsModel(name: $name, uid: $uid)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetailsModel && other.name == name && other.uid == uid;
  }

  @override
  int get hashCode => name.hashCode ^ uid.hashCode;
}
