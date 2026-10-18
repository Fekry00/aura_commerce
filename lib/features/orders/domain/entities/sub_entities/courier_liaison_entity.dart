class CourierLiaisonEntity {
  const CourierLiaisonEntity({
    required this.name,
    required this.role,
    required this.badge,
    required this.avatarUrl,
    required this.phone,
    required this.securityClearance,
    required this.protocolNote,
  });

  final String name;
  final String role;
  final String badge;
  final String avatarUrl;
  final String phone;
  final String securityClearance;
  final String protocolNote;
}
