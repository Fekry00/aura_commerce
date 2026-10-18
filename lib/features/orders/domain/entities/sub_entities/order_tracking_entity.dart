import 'courier_liaison_entity.dart';
import 'tracking_dispatch_item_entity.dart';
import 'tracking_dossier_entity.dart';
import 'tracking_milestone_entity.dart';

class OrderTrackingEntity {
  const OrderTrackingEntity({
    required this.orderId,
    required this.totalAmount,
    required this.etaTime,
    required this.priorityTier,
    required this.currentMilestoneStep,
    required this.totalMilestoneSteps,
    required this.courier,
    required this.milestones,
    required this.dispatchItems,
    required this.dossier,
  });

  final String orderId;
  final String totalAmount;
  final String etaTime;
  final String priorityTier;
  final int currentMilestoneStep;
  final int totalMilestoneSteps;
  final CourierLiaisonEntity courier;
  final List<TrackingMilestoneEntity> milestones;
  final List<TrackingDispatchItemEntity> dispatchItems;
  final TrackingDossierEntity dossier;
}
