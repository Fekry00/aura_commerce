import 'package:aura/features/orders/domain/entities/sub_entities/order_tracking_entity.dart';
import 'courier_liaison_model.dart';
import 'tracking_dispatch_item_model.dart';
import 'tracking_dossier_model.dart';
import 'tracking_milestone_model.dart';

class OrderTrackingModel extends OrderTrackingEntity {
  const OrderTrackingModel({
    required super.orderId,
    required super.totalAmount,
    required super.etaTime,
    required super.priorityTier,
    required super.currentMilestoneStep,
    required super.totalMilestoneSteps,
    required CourierLiaisonModel super.courier,
    required List<TrackingMilestoneModel> super.milestones,
    required List<TrackingDispatchItemModel> super.dispatchItems,
    required TrackingDossierModel super.dossier,
  });

  factory OrderTrackingModel.fromJson(Map<String, dynamic> json) {
    return OrderTrackingModel(
      orderId: (json['order_id'] ?? json['orderId']) as String? ?? 'Order #AL-984218',
      totalAmount: (json['total_amount'] ?? json['totalAmount']) as String? ?? '\$2,585.50',
      etaTime: (json['eta_time'] ?? json['etaTime']) as String? ?? 'Today, Estimated arrival 2:45 PM – 3:15 PM',
      priorityTier: (json['priority_tier'] ?? json['priorityTier']) as String? ?? 'Priority Tier I',
      currentMilestoneStep: ((json['current_milestone_step'] ?? json['currentMilestoneStep']) as num?)?.toInt() ?? 4,
      totalMilestoneSteps: ((json['total_milestone_steps'] ?? json['totalMilestoneSteps']) as num?)?.toInt() ?? 5,
      courier: CourierLiaisonModel.fromJson(
        json['courier'] as Map<String, dynamic>? ?? {},
      ),
      milestones: (json['milestones'] as List<dynamic>?)
              ?.map((item) =>
                  TrackingMilestoneModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
      dispatchItems: (json['dispatch_items'] ?? json['dispatchItems'] as List<dynamic>?)
              ?.map((item) => TrackingDispatchItemModel.fromJson(
                  item as Map<String, dynamic>))
              .toList() ??
          const [],
      dossier: TrackingDossierModel.fromJson(
        json['dossier'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'total_amount': totalAmount,
      'eta_time': etaTime,
      'priority_tier': priorityTier,
      'current_milestone_step': currentMilestoneStep,
      'total_milestone_steps': totalMilestoneSteps,
      'courier': (courier as CourierLiaisonModel).toJson(),
      'milestones': milestones
          .map((item) => (item as TrackingMilestoneModel).toJson())
          .toList(),
      'dispatch_items': dispatchItems
          .map((item) => (item as TrackingDispatchItemModel).toJson())
          .toList(),
      'dossier': (dossier as TrackingDossierModel).toJson(),
    };
  }
}
