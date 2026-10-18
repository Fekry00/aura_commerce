class AuthEntity {
  const AuthEntity({
    required this.token,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    this.membershipTier = 'Private Client',
    this.avatarUrl,
  });

  final String token;
  final String userId;
  final String name;
  final String email;
  final String phone;
  final String membershipTier;
  final String? avatarUrl;
}
