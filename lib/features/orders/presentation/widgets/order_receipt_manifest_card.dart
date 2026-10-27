import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/entities/order_item_entity.dart';
import 'package:aura/features/orders/presentation/utils/order_ui_helper.dart';
import 'package:flutter/material.dart';

class OrderReceiptManifestCard extends StatelessWidget {
  final OrderEntity order;

  const OrderReceiptManifestCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'ORDER ITEMS (${order.items.length})',
                style: AppTypography.labelCaps.copyWith(
                  color: const Color(0xFF0B3B2C),
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 1.1,
                ),
              ),
              Text(
                OrderUiHelper.formatPrice(order.totalAmount),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF0B3B2C),
                  fontSize: 13,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 20, color: Color(0xFFF1F5F9)),
            itemBuilder: (context, index) {
              final item = order.items[index];
              return _OrderReceiptItemTile(item: item);
            },
          ),
        ],
      ),
    );
  }
}

class _OrderReceiptItemTile extends StatelessWidget {
  final OrderItemEntity item;

  const _OrderReceiptItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: (item.productThumbnail != null &&
                    item.productThumbnail!.isNotEmpty)
                ? Image.network(
                    EndPoint.fixImageUrl(item.productThumbnail!),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.shopping_bag_outlined,
                      color: Color(0xFF94A3B8),
                      size: 22,
                    ),
                  )
                : const Icon(
                    Icons.shopping_bag_outlined,
                    color: Color(0xFF94A3B8),
                    size: 22,
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName,
                style: AppTypography.headlineSm.copyWith(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                'Qty: ${item.quantity} • ${item.price.toStringAsFixed(0)} EGP each',
                style: AppTypography.bodySm.copyWith(
                  fontSize: 11,
                  color: AppColors.slateBody,
                ),
              ),
            ],
          ),
        ),
        Text(
          OrderUiHelper.formatPrice(item.itemTotal),
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13,
            color: Color(0xFF002419),
          ),
        ),
      ],
    );
  }
}
