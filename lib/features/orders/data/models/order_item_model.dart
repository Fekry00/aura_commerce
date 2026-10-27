import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/orders/domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.id,
    required super.productId,
    required super.productName,
    super.productSlug,
    super.productThumbnail,
    required super.quantity,
    required super.price,
    required super.itemTotal,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final qty = (json['quantity'] as num?)?.toInt() ?? 1;
    final priceVal = (json['price'] as num?)?.toDouble() ?? 0.0;
    final total = (json['itemTotal'] ?? json['item_total'] as num?)?.toDouble() ??
        (priceVal * qty);

    final rawThumb = (json['productThumbnail'] ??
        json['product_thumbnail'] ??
        json['thumbnail'] ??
        json['image'] ??
        json['imageUrl']) as String?;
    final thumb = EndPoint.fixImageUrl(rawThumb);

    return OrderItemModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      productId: (json['productId'] ?? json['product_id'] as num?)?.toInt() ?? 0,
      productName: (json['productName'] ?? json['product_name'] ?? json['name']) as String? ?? 'Item',
      productSlug: (json['productSlug'] ?? json['product_slug'] ?? json['slug']) as String?,
      productThumbnail: thumb,
      quantity: qty,
      price: priceVal,
      itemTotal: total,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'productSlug': productSlug,
      'productThumbnail': productThumbnail,
      'quantity': quantity,
      'price': price,
      'itemTotal': itemTotal,
    };
  }
}
