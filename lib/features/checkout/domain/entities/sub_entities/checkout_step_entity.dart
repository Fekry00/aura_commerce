class CheckoutStepEntity {
  const CheckoutStepEntity({
    required this.stepText,
    required this.nextStepText,
    required this.title,
    required this.badgeText,
    required this.progress,
  });

  final String stepText;
  final String nextStepText;
  final String title;
  final String badgeText;
  final double progress;
}
