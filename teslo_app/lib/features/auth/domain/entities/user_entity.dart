class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.fullName,
    required this.roles,
    required this.token,
  });

  final String id;
  final String email;
  final String fullName;
  final List<String> roles;
  final String token;

  bool get isAdmin {
    return roles.contains('admin');
  }
}
