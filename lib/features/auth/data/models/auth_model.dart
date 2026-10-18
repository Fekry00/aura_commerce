import 'package:aura/features/auth/domain/entities/auth_entity.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.token,
    required super.userId,
    required super.name,
    required super.email,
    required super.phone,
    super.membershipTier = 'Private Client',
    super.avatarUrl,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final userData = (json['user'] ?? json['data'] ?? json) as Map<String, dynamic>;
    return AuthModel(
      token: (json['token'] ?? json['access_token'] ?? userData['token']) as String? ?? 'aura_vault_jwt_token_mock',
      userId: (userData['id'] ?? userData['user_id'] ?? json['id'])?.toString() ?? '1',
      name: (userData['name'] ?? userData['fullName']) as String? ?? 'Ahmed Mohamed',
      email: (userData['email'] ?? json['email']) as String? ?? 'ahmed@aura.luxury',
      phone: (userData['phone'] ?? userData['phoneNumber']) as String? ?? '+20 100 000 0000',
      membershipTier: (userData['membership_tier'] ?? userData['tier']) as String? ?? 'Private Client',
      avatarUrl: (userData['avatar_url'] ?? userData['avatar']) as String? ??
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': {
        'id': userId,
        'name': name,
        'email': email,
        'phone': phone,
        'membership_tier': membershipTier,
        'avatar_url': avatarUrl,
      },
    };
  }
}
