import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'sub_models/order_consignment_address_model.dart';
import 'sub_models/order_manifest_item_model.dart';
import 'sub_models/order_settlement_summary_model.dart';
import 'sub_models/order_tracking_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.orderId,
    required super.orderRef,
    required super.recipientName,
    required super.dispatchSchedule,
    required List<OrderManifestItemModel> super.manifestItems,
    required OrderConsignmentAddressModel super.consignmentAddress,
    required OrderSettlementSummaryModel super.settlementSummary,
    required OrderTrackingModel super.tracking,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: (json['order_id'] ?? json['orderId']) as String? ?? 'AL-98421',
      orderRef: (json['order_ref'] ?? json['orderRef']) as String? ?? '#AL-98421',
      recipientName: (json['recipient_name'] ?? json['recipientName']) as String? ?? 'Ahmed',
      dispatchSchedule: (json['dispatch_schedule'] ?? json['dispatchSchedule']) as String? ?? 'May 16 – 17, 2026',
      manifestItems: (json['manifest_items'] ?? json['manifestItems'] as List<dynamic>?)
              ?.map((item) =>
                  OrderManifestItemModel.fromJson(item as Map<String, dynamic>))
              .toList() ??
          const [],
      consignmentAddress: OrderConsignmentAddressModel.fromJson(
        (json['consignment_address'] ?? json['consignmentAddress']) as Map<String, dynamic>? ?? {},
      ),
      settlementSummary: OrderSettlementSummaryModel.fromJson(
        (json['settlement_summary'] ?? json['settlementSummary']) as Map<String, dynamic>? ?? {},
      ),
      tracking: OrderTrackingModel.fromJson(
        json['tracking'] as Map<String, dynamic>? ?? {},
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'order_ref': orderRef,
      'recipient_name': recipientName,
      'dispatch_schedule': dispatchSchedule,
      'manifest_items': manifestItems
          .map((item) => (item as OrderManifestItemModel).toJson())
          .toList(),
      'consignment_address':
          (consignmentAddress as OrderConsignmentAddressModel).toJson(),
      'settlement_summary':
          (settlementSummary as OrderSettlementSummaryModel).toJson(),
      'tracking': (tracking as OrderTrackingModel).toJson(),
    };
  }
}
