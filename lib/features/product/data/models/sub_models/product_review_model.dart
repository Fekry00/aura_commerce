import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_review_entity.dart';

class ProductReviewModel extends ProductReviewEntity {
  const ProductReviewModel({
    required super.id,
    required super.authorName,
    required super.authorInitials,
    required super.authorStatus,
    required super.rating,
    required super.comment,
    required super.purchaseInfo,
    super.authorAvatar,
  });

  factory ProductReviewModel.fromJson(Map<String, dynamic> json) {
    final rawName = (json['userName'] ??
            json['user_name'] ??
            json['authorName'] ??
            json['author_name'] ??
            'Anonymous')
        .toString();
    final name = rawName.isNotEmpty ? rawName : 'Anonymous';

    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.length > 1
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : (name.isNotEmpty ? name[0].toUpperCase() : 'U');

    final createdAt = json['createdAt']?.toString() ?? json['created_at']?.toString();
    String formattedDate = '';
    if (createdAt != null && createdAt.isNotEmpty) {
      try {
        final dt = DateTime.parse(createdAt);
        formattedDate = ' • ${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
      } catch (_) {
        formattedDate = ' • $createdAt';
      }
    }

    String? avatar = (json['userAvatar'] ??
            json['user_avatar'] ??
            json['avatar'] ??
            json['avatarUrl'] ??
            json['authorAvatar'] ??
            json['author_avatar'] ??
            json['profile_image'] ??
            (json['user'] is Map ? (json['user']['profile_image'] ?? json['user']['avatar'] ?? json['user']['avatar_url']) : null))
        ?.toString();

    if (avatar != null && avatar.isNotEmpty) {
      if (!avatar.startsWith('http')) {
        avatar = '${EndPoint.serverUrl}/${avatar.startsWith('/') ? avatar.substring(1) : avatar}';
      } else {
        avatar = avatar
            .replaceAll('http://localhost:8000', EndPoint.serverUrl)
            .replaceAll('http://127.0.0.1:8000', EndPoint.serverUrl)
            .replaceAll('localhost', '127.0.0.1');
      }
    } else {
      avatar = null;
    }

    return ProductReviewModel(
      id: json['id']?.toString() ?? '',
      authorName: name,
      authorInitials: initials,
      authorStatus: (json['authorStatus'] ??
              json['author_status'] ??
              'Verified Buyer')
          .toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 5.0,
      comment: (json['comment'] ?? json['content'] ?? '') as String,
      purchaseInfo: 'Verified Purchase$formattedDate',
      authorAvatar: avatar,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_name': authorName,
      'author_initials': authorInitials,
      'author_status': authorStatus,
      'rating': rating,
      'comment': comment,
      'purchase_info': purchaseInfo,
      'author_avatar': authorAvatar,
    };
  }
}
