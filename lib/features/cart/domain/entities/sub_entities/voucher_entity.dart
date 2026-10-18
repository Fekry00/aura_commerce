class VoucherEntity {
  const VoucherEntity({
    required this.code,
    required this.discountRate,
    required this.label,
  });

  final String code;
  final double discountRate;
  final String label;
}
