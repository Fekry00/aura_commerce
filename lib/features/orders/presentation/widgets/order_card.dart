import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
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
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE2E8F0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Row: Order ID & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #AUR-${order.id}',
                  style: AppTypography.headlineSm.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF002419),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusBg,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status.toUpperCase(),
                    style: TextStyle(
                      color: statusColor,
                      fontSize: 10.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date & Items count
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_outlined,
                  size: 13,
                  color: AppColors.slateBody,
                ),
                const SizedBox(width: 5),
                Text(
                  formattedDate,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.slateBody,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '•  $itemsCountText',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.slateBody,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Item Thumbnails
            if (order.items.isNotEmpty) ...[
              SizedBox(
                height: 48,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: order.items.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final item = order.items[index];
                    return Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: (item.productThumbnail != null &&
                                item.productThumbnail!.isNotEmpty)
                            ? Image.network(
                                EndPoint.fixImageUrl(item.productThumbnail!),
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 18,
                                  color: Color(0xFF94A3B8),
                                ),
                              )
                            : const Icon(
                                Icons.shopping_bag_outlined,
                                size: 18,
                                color: Color(0xFF94A3B8),
                              ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Divider
            const Divider(color: Color(0xFFF1F5F9), height: 1),
            const SizedBox(height: 10),

            // Bottom Row: Total & Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        fontSize: 9.5,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slateBody,
                      ),
                    ),
                    Text(
                      priceText,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF0B3B2C),
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
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: Color(0xFFEF4444),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
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
                            horizontal: 12,
                            vertical: 6,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.local_shipping_outlined, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Track',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    ElevatedButton(
                      onPressed: () => onDetailsTap?.call(order),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0B3B2C),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'Details',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward_ios, size: 10),
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
