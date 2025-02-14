// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../../../../core/utils/typedefs.dart';
import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.createdAt,
    required super.name,
    required super.avatar,
  });

  UserModel copyWith({
    String? id,
    String? createdAt,
    String? name,
    String? avatar,
  }) {
    return UserModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
    );
  }

  const UserModel.empty()
      : this(
          id: "1",
          createdAt: '_empty.createdAt',
          name: '_empty.name',
          avatar: '_empty.avatar',
        );

  UserModel.fromMap(DataMap map)
      : this(
          id: map['id'],
          createdAt: map['createdAt'],
          name: map['name'],
          avatar: map['avatar'],
        );

  factory UserModel.fromJson(String jsonSource) => UserModel.fromMap(
        jsonDecode(jsonSource) as DataMap,
      );

  DataMap toMap() => {
        'id': id,
        'name': name,
        'avatar': avatar,
        'createdAt': createdAt,
      };

  String toJson() => jsonEncode(toMap());
}
