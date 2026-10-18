class TrackingDossierEntity {
  const TrackingDossierEntity({
    required this.recipientName,
    required this.recipientAddress,
    required this.courierService,
    required this.insuranceNote,
    required this.paymentMethod,
    required this.paymentDetails,
    required this.paymentBadge,
  });

  final String recipientName;
  final String recipientAddress;
  final String courierService;
  final String insuranceNote;
  final String paymentMethod;
  final String paymentDetails;
  final String paymentBadge;
}
