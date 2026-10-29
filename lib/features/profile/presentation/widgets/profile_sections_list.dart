import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:flutter/material.dart';

class ProfileSectionsList extends StatelessWidget {
  final String dispatchAddress;
  final String vaultCreditText;
  final VoidCallback? onOrdersTap;
  final VoidCallback? onAddressesTap;

  const ProfileSectionsList({
    super.key,
    this.dispatchAddress = 'No address saved yet',
    this.vaultCreditText = '0 EGP store credit available',
    this.onOrdersTap,
    this.onAddressesTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('ORDERS & ACQUISITIONS'),
        _buildTile(
          context,
          Icons.local_shipping_outlined,
          'Order History & Returns',
          'Track active dispatch & instant courier status',
          onTap: onOrdersTap ??
              () => Navigator.pushNamed(context, Routes.ordersView),
        ),
        _buildTile(
          context,
          Icons.apartment_rounded,
          'White-Glove Dispatch Address',
          dispatchAddress,
          onTap: onAddressesTap ??
              () => showModalBottomSheet<void>(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const SavedAddressesBottomSheet(),
                  ),
        ),
        _buildTile(
          context,
          Icons.account_balance_wallet_outlined,
          'Payment Methods & Store Credit',
          vaultCreditText,
          isGreenSubtitle: true,
        ),
        const SizedBox(height: AppSpacing.spaceLg),
        _buildSectionHeader('CURATION & SECURITY'),
        _buildTile(
          context,
          Icons.straighten_outlined,
          'Personal Sizing Profile',
          'Tailored suit, Footwear, Watches',
        ),
        _buildTile(
          context,
          Icons.notifications_active_outlined,
          'Runway Drops & Private Access',
          'VIP Push Notifications Active',
        ),
        _buildTile(
          context,
          Icons.fingerprint_rounded,
          'Biometric Passkey Authentication',
          'FaceID & Device Security Enabled',
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppSpacing.spaceXs,
        bottom: AppSpacing.spaceSm,
      ),
      child: Text(
        title,
        style: AppTypography.labelCaps.copyWith(
          color: const Color(0xFF6B7280),
          letterSpacing: 1.2,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle, {
    bool isGreenSubtitle = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.spaceSm),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.margin),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.spaceMd,
          vertical: AppSpacing.spaceXs,
        ),
        leading: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: const Color(0xFF1F2937), size: 20),
        ),
        title: Text(
          title,
          style: AppTypography.bodyMd.copyWith(
            fontWeight: FontWeight.w600,
            color: const Color(0xFF111827),
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.bodySm.copyWith(
            color: isGreenSubtitle
                ? const Color(0xFF0B3B2C)
                : const Color(0xFF6B7280),
            fontWeight: isGreenSubtitle ? FontWeight.w600 : FontWeight.w400,
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: Color(0xFF9CA3AF),
        ),
        onTap: onTap ??
            () {
              showCustomSnackBar(
                context,
                message: '$title preferences up to date',
                type: SnackBarType.info,
              );
            },
      ),
    );
  }
}
