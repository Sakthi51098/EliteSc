class UserEntity {
  const UserEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.avatarPath,
  });

  final String id;
  final String name;
  final String phoneNumber;
  final String avatarPath;
}
