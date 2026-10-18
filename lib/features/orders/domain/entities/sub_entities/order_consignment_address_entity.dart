class OrderConsignmentAddressEntity {
  const OrderConsignmentAddressEntity({
    required this.recipientName,
    required this.addressType,
    required this.addressLine,
    required this.cityStateZip,
    required this.phoneNumber,
    required this.conciergeProtocol,
  });

  final String recipientName;
  final String addressType;
  final String addressLine;
  final String cityStateZip;
  final String phoneNumber;
  final String conciergeProtocol;
}
