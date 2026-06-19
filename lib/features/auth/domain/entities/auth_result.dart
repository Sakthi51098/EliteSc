class AuthResult {
  const AuthResult({
    required this.userId,
    required this.phoneNumber,
    required this.isExistingUser,
    this.name,
    this.avatarPath,
  });

  final String userId;
  final String phoneNumber;
  final bool isExistingUser;
  final String? name;
  final String? avatarPath;
}
