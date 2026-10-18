import 'package:aura/features/profile/domain/entities/sub_entities/concierge_liaison_entity.dart';

class ConciergeLiaisonModel extends ConciergeLiaisonEntity {
  const ConciergeLiaisonModel({
    required super.name,
    required super.role,
    required super.dispatchStatus,
  });

  factory ConciergeLiaisonModel.fromJson(Map<String, dynamic> json) {
    return ConciergeLiaisonModel(
      name: json['name'] as String? ?? 'Marcus Vance',
      role: json['role'] as String? ??
          'Dedicated White-Glove Stylist & Courier',
      dispatchStatus: (json['dispatch_status'] ?? json['dispatchStatus'])
              as String? ??
          'Priority Dispatch',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'role': role,
      'dispatch_status': dispatchStatus,
    };
  }
}
