class ShippingMeterEntity {
  const ShippingMeterEntity({
    required this.remainingAmount,
    required this.threshold,
    required this.progressRatio,
    required this.progressPercent,
    required this.message,
    required this.isComplimentary,
  });

  final double remainingAmount;
  final double threshold;
  final double progressRatio;
  final int progressPercent;
  final String message;
  final bool isComplimentary;
}
