import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.avatarPath,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: (map['name'] ?? '') as String,
      phoneNumber: (map['phoneNumber'] ?? '') as String,
      avatarPath: (map['avatarPath'] ?? '') as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'phoneNumber': phoneNumber, 'avatarPath': avatarPath};
  }
}
