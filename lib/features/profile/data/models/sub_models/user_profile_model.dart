import 'package:aura/features/profile/domain/entities/sub_entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.name,
    super.email = '',
    super.phone = '',
    super.role = 'customer',
    required super.tier,
    required super.tierTitle,
    required super.patronSince,
    required super.avatarUrl,
    required super.targetTier,
    required super.progress,
    required super.spentAmount,
    required super.remainingToPrivilege,
    required super.deliveredCount,
    required super.curationsCount,
    required super.vaultCredit,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    final String rawId = (json['id'] ?? '').toString();
    final String formattedId = rawId.isNotEmpty ? '#AL-$rawId' : '#AL-98421';
    final String userName = (json['name'] ?? json['fullName']) as String? ?? 'Aura Member';
    final String userEmail = (json['email'] ?? '').toString();
    final String userPhone = (json['phone'] ?? '').toString();
    final String userRole = (json['role'] ?? json['tier']) as String? ?? 'Private Client';
    
    String avatar = (json['profile_image'] ?? json['avatar_url'] ?? json['avatarUrl']) as String? ?? '';
    if (avatar.isNotEmpty) {
      if (!avatar.startsWith('http')) {
        avatar = 'http://127.0.0.1:8000/${avatar.startsWith('/') ? avatar.substring(1) : avatar}';
      }
    } else {
      avatar = 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300';
    }

    String memberSince = 'Oct 2026';
    if (json['created_at'] is String && (json['created_at'] as String).length >= 10) {
      final dateStr = (json['created_at'] as String).substring(0, 10);
      try {
        final parsed = DateTime.parse(dateStr);
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        memberSince = '${months[parsed.month - 1]} ${parsed.year}';
      } catch (_) {
        memberSince = dateStr;
      }
    }

    return UserProfileModel(
      id: formattedId,
      name: userName,
      email: userEmail,
      phone: userPhone,
      role: userRole,
      tier: userRole == 'customer' ? 'Tier 01' : userRole,
      tierTitle: userRole == 'customer' ? 'VIP Luminary' : userRole,
      patronSince: memberSince,
      avatarUrl: avatar,
      targetTier: (json['target_tier'] ?? json['targetTier']) as String? ??
          'TIER 02 SOVEREIGN',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.78,
      spentAmount: (json['spent_amount'] ?? json['spentAmount']) as String? ??
          '\$12,450 spent',
      remainingToPrivilege: (json['remaining_to_privilege'] ??
              json['remainingToPrivilege']) as String? ??
          '\$2,550 to Sovereign Privileges',
      deliveredCount:
          (json['delivered_count'] ?? json['deliveredCount']) as String? ??
              '14',
      curationsCount:
          (json['curations_count'] ?? json['curationsCount']) as String? ??
              '28',
      vaultCredit: (json['vault_credit'] ?? json['vaultCredit']) as String? ??
          '\$450',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role,
      'tier': tier,
      'tier_title': tierTitle,
      'patron_since': patronSince,
      'avatar_url': avatarUrl,
      'target_tier': targetTier,
      'progress': progress,
      'spent_amount': spentAmount,
      'remaining_to_privilege': remainingToPrivilege,
      'delivered_count': deliveredCount,
      'curations_count': curationsCount,
      'vault_credit': vaultCredit,
    };
  }
}
