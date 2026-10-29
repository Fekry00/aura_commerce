class VoucherEntity {
  const VoucherEntity({
    required this.code,
    required this.discountRate,
    required this.label,
    this.type = 'percentage',
    this.value = 0.0,
  });

  final String code;
  final double discountRate;
  final String label;
  final String type;
  final double value;
}

