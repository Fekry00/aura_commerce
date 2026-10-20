class UserProfileEntity {
  const UserProfileEntity({
    required this.id,
    required this.name,
    this.email = '',
    this.phone = '',
    this.role = 'customer',
    required this.tier,
    required this.tierTitle,
    required this.patronSince,
    required this.avatarUrl,
    required this.targetTier,
    required this.progress,
    required this.spentAmount,
    required this.remainingToPrivilege,
    required this.deliveredCount,
    required this.curationsCount,
    required this.vaultCredit,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String tier;
  final String tierTitle;
  final String patronSince;
  final String avatarUrl;
  final String targetTier;
  final double progress;
  final String spentAmount;
  final String remainingToPrivilege;
  final String deliveredCount;
  final String curationsCount;
  final String vaultCredit;
}
