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
    // Handling { success: true, message: "...", data: { user: {...}, token: "..." } }
    final data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final Map<String, dynamic> userData = (data['user'] is Map<String, dynamic>)
        ? data['user'] as Map<String, dynamic>
        : (json['user'] is Map<String, dynamic>
            ? json['user'] as Map<String, dynamic>
            : data);

    final String token = (data['token'] ??
            json['token'] ??
            json['access_token'] ??
            userData['token']) as String? ??
        '';

    final String userId =
        (userData['id'] ?? userData['user_id'] ?? json['id'])?.toString() ??
            '';

    final String name =
        (userData['name'] ?? userData['fullName']) as String? ?? '';

    final String email =
        (userData['email'] ?? json['email']) as String? ?? '';

    final String phone =
        (userData['phone'] ?? userData['phoneNumber']) as String? ?? '';

    final String role = (userData['role'] ??
            userData['membership_tier'] ??
            userData['tier']) as String? ??
        'Private Client';

    final String? avatar = (userData['profile_image'] ??
        userData['avatar_url'] ??
        userData['avatar']) as String?;

    return AuthModel(
      token: token,
      userId: userId,
      name: name,
      email: email,
      phone: phone,
      membershipTier: role,
      avatarUrl: avatar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'token': token,
        'user': {
          'id': userId,
          'name': name,
          'email': email,
          'phone': phone,
          'role': membershipTier,
          'profile_image': avatarUrl,
        },
      },
      'token': token,
    };
  }
}
