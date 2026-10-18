import 'package:aura/features/orders/domain/entities/sub_entities/courier_liaison_entity.dart';

class CourierLiaisonModel extends CourierLiaisonEntity {
  const CourierLiaisonModel({
    required super.name,
    required super.role,
    required super.badge,
    required super.avatarUrl,
    required super.phone,
    required super.securityClearance,
    required super.protocolNote,
  });

  factory CourierLiaisonModel.fromJson(Map<String, dynamic> json) {
    return CourierLiaisonModel(
      name: json['name'] as String? ?? '',
      role: json['role'] as String? ?? '',
      badge: json['badge'] as String? ?? '',
      avatarUrl: (json['avatar_url'] ?? json['avatarUrl']) as String? ?? '',
      phone: json['phone'] as String? ?? '',
      securityClearance: (json['security_clearance'] ?? json['securityClearance']) as String? ?? '',
      protocolNote: (json['protocol_note'] ?? json['protocolNote']) as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'badge': badge,
      'avatar_url': avatarUrl,
      'phone': phone,
      'security_clearance': securityClearance,
      'protocol_note': protocolNote,
    };
  }
}
