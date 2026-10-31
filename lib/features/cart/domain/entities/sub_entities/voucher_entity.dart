class VoucherEntity {
  const VoucherEntity({
    this.id,
    required this.code,
    required this.discountRate,
    required this.label,
    this.type = 'percentage',
    this.value = 0.0,
    this.expiryDate,
  });

  final int? id;
  final String code;
  final double discountRate;
  final String label;
  final String type;
  final double value;
  final String? expiryDate;
}

