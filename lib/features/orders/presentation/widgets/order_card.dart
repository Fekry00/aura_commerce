import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/app_cached_image.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/presentation/utils/order_ui_helper.dart';
import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final OrderEntity order;
  final ValueChanged<OrderEntity>? onDetailsTap;
  final ValueChanged<OrderEntity>? onCancelTap;

  const OrderCard({
    super.key,
    required this.order,
    this.onDetailsTap,
    this.onCancelTap,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = OrderUiHelper.getStatusColor(order.status);
    final statusBg = OrderUiHelper.getStatusBgColor(order.status);
    final formattedDate = OrderUiHelper.formatDate(order.createdAt);
    final itemsCountText = OrderUiHelper.formatItemsCount(order.itemsCount);
    final priceText = OrderUiHelper.formatPrice(order.totalAmount);

    return GestureDetector(
      onTap: () => onDetailsTap?.call(order),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(AppSpacing.spaceMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Order ID & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #AUR-${order.id}',
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF002419),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spaceSm,
                    vertical: AppSpacing.spaceXs,
                  ),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(AppSpacing.space12),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: AppTypography.labelCaps.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.spaceSm),

            // Date & Items count
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 14,
                  color: AppColors.slateBody,
                ),
                const SizedBox(width: AppSpacing.spaceXs),
                Text(
                  formattedDate,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Text(
                  '•  $itemsCountText',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),

            // Item Thumbnails
            if (order.items.isNotEmpty) ...[
              SizedBox(
                height: AppSpacing.space2Xl,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: order.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: AppSpacing.spaceSm),
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return Container(
                      width: AppSpacing.space2Xl,
                      height: AppSpacing.space2Xl,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(AppSpacing.spaceSm),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: AppCachedImage(
                          imageUrl: item.productThumbnail ?? '',
                          width: AppSpacing.space2Xl,
                          height: AppSpacing.space2Xl,
                          fit: BoxFit.cover,
                          fallbackIcon: Icons.shopping_bag_outlined,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
            ],

            // Divider
            const Divider(color: Color(0xFFF1F5F9), height: 1),
            const SizedBox(height: AppSpacing.spaceSm),

            // Bottom Row: Total & Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TOTAL',
                      style: AppTypography.labelCaps.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.slateBody,
                      ),
                    ),
                    Text(
                      priceText,
                      style: AppTypography.priceCatalog.copyWith(
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF0B3B2C),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (order.isPending) ...[
                      OutlinedButton(
                        onPressed: () => onCancelTap?.call(order),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFEF4444)),
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space12,
                            vertical: AppSpacing.spaceXs,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.spaceSm),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: AppTypography.labelSm.copyWith(
                            color: const Color(0xFFEF4444),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spaceSm),
                    ],
                    if (order.isShipped || order.isDelivered) ...[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.orderTrackingDetailsView,
                            arguments: order,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.space12,
                            vertical: AppSpacing.spaceXs,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.spaceSm),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_shipping_outlined, size: 14),
                            const SizedBox(width: AppSpacing.spaceXs),
                            Text(
                              'Track',
                              style: AppTypography.labelSm.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.spaceSm),
                    ],
                    ElevatedButton(
                      onPressed: () => onDetailsTap?.call(order),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B3B2C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space12,
                          vertical: AppSpacing.spaceXs,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSpacing.spaceSm),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Details',
                            style: AppTypography.labelSm.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.spaceXs),
                          const Icon(Icons.arrow_forward_ios, size: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
