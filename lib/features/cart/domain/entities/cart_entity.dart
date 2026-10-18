import 'sub_entities/cart_item_entity.dart';
import 'sub_entities/order_summary_entity.dart';
import 'sub_entities/shipping_meter_entity.dart';
import 'sub_entities/voucher_entity.dart';

class CartEntity {
  const CartEntity({
    required this.curatedBadge,
    required this.shippingMeter,
    required this.items,
    this.voucher,
    required this.orderSummary,
  });

  final String curatedBadge;
  final ShippingMeterEntity shippingMeter;
  final List<CartItemEntity> items;
  final VoucherEntity? voucher;
  final OrderSummaryEntity orderSummary;
}
