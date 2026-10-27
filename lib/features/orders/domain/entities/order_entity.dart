import 'order_item_entity.dart';

class OrderEntity {
  const OrderEntity({
    required this.id,
    this.userId,
    required this.status,
    required this.totalAmount,
    required this.shippingAddress,
    this.paymentMethod = 'cod',
    this.phone,
    this.notes,
    required this.itemsCount,
    required this.items,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final int? userId;
  final String status;
  final double totalAmount;
  final String shippingAddress;
  final String paymentMethod;
  final String? phone;
  final String? notes;
  final int itemsCount;
  final List<OrderItemEntity> items;
  final String? createdAt;
  final String? updatedAt;

  bool get isPending => status.toLowerCase() == 'pending';
  bool get isCancelled => status.toLowerCase() == 'cancelled';
  bool get isDelivered => status.toLowerCase() == 'delivered';
  bool get isShipped => status.toLowerCase() == 'shipped';
}
