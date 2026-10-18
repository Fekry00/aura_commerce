import 'package:aura/features/checkout/domain/entities/sub_entities/checkout_step_entity.dart';

class CheckoutStepModel extends CheckoutStepEntity {
  const CheckoutStepModel({
    required super.stepText,
    required super.nextStepText,
    required super.title,
    required super.badgeText,
    required super.progress,
  });

  factory CheckoutStepModel.fromJson(Map<String, dynamic> json) {
    return CheckoutStepModel(
      stepText: (json['step_text'] ?? json['stepText']) as String? ?? 'STEP 1 OF 2',
      nextStepText: (json['next_step_text'] ?? json['nextStepText']) as String? ?? 'Next: Payment',
      title: json['title'] as String? ?? 'Shipping & Delivery',
      badgeText: (json['badge_text'] ?? json['badgeText']) as String? ?? 'VIP Privilege Active',
      progress: (json['progress'] as num?)?.toDouble() ?? 0.5,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'step_text': stepText,
      'next_step_text': nextStepText,
      'title': title,
      'badge_text': badgeText,
      'progress': progress,
    };
  }
}
