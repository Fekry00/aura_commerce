import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'order_item_model.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    super.userId,
    required super.status,
    required super.totalAmount,
    required super.shippingAddress,
    super.paymentMethod = 'cod',
    super.phone,
    super.notes,
    required super.itemsCount,
    required List<OrderItemModel> super.items,
    super.createdAt,
    super.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    // If wrapped in 'data'
    final map = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    final rawItems = (map['items'] as List<dynamic>? ?? []);
    final itemsList = rawItems
        .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    return OrderModel(
      id: (map['id'] as num?)?.toInt() ?? 0,
      userId: (map['userId'] ?? map['user_id'] as num?)?.toInt(),
      status: (map['status'] as String? ?? 'pending').toLowerCase(),
      totalAmount: (map['totalAmount'] ?? map['total_amount'] as num?)?.toDouble() ?? 0.0,
      shippingAddress: (map['shippingAddress'] ?? map['shipping_address']) as String? ?? '',
      paymentMethod: (map['paymentMethod'] ?? map['payment_method']) as String? ?? 'cod',
      phone: (map['phone']) as String?,
      notes: (map['notes']) as String?,
      itemsCount: (map['itemsCount'] ?? map['items_count'] as num?)?.toInt() ?? itemsList.length,
      items: itemsList,
      createdAt: (map['createdAt'] ?? map['created_at']) as String?,
      updatedAt: (map['updatedAt'] ?? map['updated_at']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'status': status,
      'totalAmount': totalAmount,
      'shippingAddress': shippingAddress,
      'paymentMethod': paymentMethod,
      'phone': phone,
      'notes': notes,
      'itemsCount': itemsCount,
      'items': items.map((e) => (e as OrderItemModel).toJson()).toList(),
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
