import 'package:aura/features/orders/domain/entities/sub_entities/tracking_dossier_entity.dart';

class TrackingDossierModel extends TrackingDossierEntity {
  const TrackingDossierModel({
    required super.recipientName,
    required super.recipientAddress,
    required super.courierService,
    required super.insuranceNote,
    required super.paymentMethod,
    required super.paymentDetails,
    required super.paymentBadge,
  });

  factory TrackingDossierModel.fromJson(Map<String, dynamic> json) {
    return TrackingDossierModel(
      recipientName: (json['recipient_name'] ?? json['recipientName']) as String? ?? '',
      recipientAddress: (json['recipient_address'] ?? json['recipientAddress']) as String? ?? '',
      courierService: (json['courier_service'] ?? json['courierService']) as String? ?? '',
      insuranceNote: (json['insurance_note'] ?? json['insuranceNote']) as String? ?? '',
      paymentMethod: (json['payment_method'] ?? json['paymentMethod']) as String? ?? '',
      paymentDetails: (json['payment_details'] ?? json['paymentDetails']) as String? ?? '',
      paymentBadge: (json['payment_badge'] ?? json['paymentBadge']) as String? ?? 'PAID',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient_name': recipientName,
      'recipient_address': recipientAddress,
      'courier_service': courierService,
      'insurance_note': insuranceNote,
      'payment_method': paymentMethod,
      'payment_details': paymentDetails,
      'payment_badge': paymentBadge,
    };
  }
}
