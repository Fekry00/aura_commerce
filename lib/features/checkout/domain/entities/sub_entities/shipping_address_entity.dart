class ShippingAddressEntity {
  const ShippingAddressEntity({
    required this.id,
    required this.label,
    required this.recipient,
    required this.phone,
    required this.address,
    this.isDefault = false,
  });

  final String id;
  final String label;
  final String recipient;
  final String phone;
  final String address;
  final bool isDefault;
}
