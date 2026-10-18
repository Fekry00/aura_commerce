import 'package:aura/features/profile/domain/entities/sub_entities/user_profile_entity.dart';

class UserProfileModel extends UserProfileEntity {
  const UserProfileModel({
    required super.id,
    required super.name,
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
    return UserProfileModel(
      id: json['id']?.toString() ?? '#AL-98421',
      name: json['name'] as String? ?? 'Claire Daniels',
      tier: json['tier'] as String? ?? 'Tier 01',
      tierTitle: (json['tier_title'] ?? json['tierTitle']) as String? ??
          'VIP Luminary',
      patronSince: (json['patron_since'] ?? json['patronSince']) as String? ??
          'Oct 2022',
      avatarUrl: (json['avatar_url'] ?? json['avatarUrl']) as String? ??
          'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
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
