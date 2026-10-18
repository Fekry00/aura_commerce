import 'package:aura/features/orders/domain/entities/sub_entities/tracking_dispatch_item_entity.dart';

class TrackingDispatchItemModel extends TrackingDispatchItemEntity {
  const TrackingDispatchItemModel({
    required super.id,
    required super.category,
    required super.title,
    required super.subtitle,
    required super.quantity,
    required super.price,
    required super.serialTag,
    required super.imageUrl,
    super.nftCertificateId,
  });

  factory TrackingDispatchItemModel.fromJson(Map<String, dynamic> json) {
    return TrackingDispatchItemModel(
      id: json['id']?.toString() ?? '',
      category: json['category'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      quantity: json['quantity'] as String? ?? 'Qty: 01',
      price: json['price'] as String? ?? '',
      serialTag: (json['serial_tag'] ?? json['serialTag']) as String? ?? '',
      imageUrl: (json['image_url'] ?? json['imageUrl']) as String? ?? '',
      nftCertificateId: (json['nft_certificate_id'] ?? json['nftCertificateId']) as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'subtitle': subtitle,
      'quantity': quantity,
      'price': price,
      'serial_tag': serialTag,
      'image_url': imageUrl,
      'nft_certificate_id': nftCertificateId,
    };
  }
}
