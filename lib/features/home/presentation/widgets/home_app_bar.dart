import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'AURA',
          style: AppTypography.headlineSm.copyWith(
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            color: AppColors.primaryContainer,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            _showDeliveryLocationSheet(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 16,
                  color: AppColors.primaryContainer,
                ),
                const SizedBox(width: 4),
                Text(
                  'Deliver to: New York...',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 16,
                  color: AppColors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        Stack(
          children: [
            IconButton(
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.onSurface,
              ),
              onPressed: () {
                _showNotificationsSheet(context);
              },
            ),
            Positioned(
              right: 12,
              top: 12,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.error,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            MainTabController.switchTab(3);
          },
          child: const CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=200',
            ),
          ),
        ),
      ],
    );
  }

  void _showDeliveryLocationSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Delivery Residence',
                style: AppTypography.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              _buildAddressOption(
                context,
                title: 'Manhattan Private Suite • 10001',
                subtitle: '740 Park Avenue, Apt 14B, New York',
                isSelected: true,
              ),
              const SizedBox(height: 10),
              _buildAddressOption(
                context,
                title: 'Beverly Hills Atelier • 90210',
                subtitle: '9641 Sunset Blvd, Beverly Hills, CA',
                isSelected: false,
              ),
              const SizedBox(height: 10),
              _buildAddressOption(
                context,
                title: 'Paris Salon • 75008',
                subtitle: '22 Place Vendôme, 75008 Paris',
                isSelected: false,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressOption(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          message: 'Delivery address updated to $title',
          type: SnackBarType.info,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE9F0EC)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF006C49)
                : AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected
                  ? const Color(0xFF006C49)
                  : AppColors.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF006C49),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Atelier Notifications',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Mark all read',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                title: 'Curated Drop 04 is Live',
                subtitle: 'Vault access unlocked for 24 reserved pieces.',
                time: '12m ago',
                icon: Icons.stars,
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: 'Private Reservation Confirmed',
                subtitle: 'Your consultation with horologist artisan is set.',
                time: '2h ago',
                icon: Icons.verified,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3B2C),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelSm.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.slateBody,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
