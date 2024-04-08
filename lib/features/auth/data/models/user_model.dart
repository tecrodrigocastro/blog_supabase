import 'package:blog_supabase/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.name, required super.email, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      id: json['id'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'id': id,
    };
  }
}
