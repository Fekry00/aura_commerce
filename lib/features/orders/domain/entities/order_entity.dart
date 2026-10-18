import 'sub_entities/order_consignment_address_entity.dart';
import 'sub_entities/order_manifest_item_entity.dart';
import 'sub_entities/order_settlement_summary_entity.dart';
import 'sub_entities/order_tracking_entity.dart';

class OrderEntity {
  const OrderEntity({
    required this.orderId,
    required this.orderRef,
    required this.recipientName,
    required this.dispatchSchedule,
    required this.manifestItems,
    required this.consignmentAddress,
    required this.settlementSummary,
    required this.tracking,
  });

  final String orderId;
  final String orderRef;
  final String recipientName;
  final String dispatchSchedule;
  final List<OrderManifestItemEntity> manifestItems;
  final OrderConsignmentAddressEntity consignmentAddress;
  final OrderSettlementSummaryEntity settlementSummary;
  final OrderTrackingEntity tracking;
}
