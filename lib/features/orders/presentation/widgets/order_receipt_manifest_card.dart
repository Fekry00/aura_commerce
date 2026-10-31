import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
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
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      padding: const EdgeInsets.all(AppSpacing.spaceMd),
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
                  letterSpacing: 1.1,
                ),
              ),
              Text(
                OrderUiHelper.formatPrice(order.totalAmount),
                style: AppTypography.bodySm.copyWith(
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF0B3B2C),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: order.items.length,
            separatorBuilder: (context, index) => const Divider(
              height: AppSpacing.margin,
              color: Color(0xFFF1F5F9),
            ),
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
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
            child: AppCachedImage(
              imageUrl: item.productThumbnail ?? '',
              width: 52,
              height: 52,
              fit: BoxFit.cover,
              fallbackIcon: Icons.shopping_bag_outlined,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.productName,
                style: AppTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1E293B),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.space2Xs),
              Text(
                'Qty: ${item.quantity} • ${item.price.toStringAsFixed(0)} EGP each',
                style: AppTypography.labelCaps.copyWith(
                  color: AppColors.slateBody,
                ),
              ),
            ],
          ),
        ),
        Text(
          OrderUiHelper.formatPrice(item.itemTotal),
          style: AppTypography.bodySm.copyWith(
            fontWeight: FontWeight.w800,
            color: const Color(0xFF002419),
          ),
        ),
      ],
    );
  }
}
