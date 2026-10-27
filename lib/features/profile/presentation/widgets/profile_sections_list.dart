import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/profile/presentation/controllers/profile_controller.dart';
import 'package:flutter/material.dart';

class ProfileSectionsList extends StatelessWidget {
  final String dispatchAddress;
  final String vaultCreditText;
  final ProfileController? controller;
  final VoidCallback? onOrdersTap;
  final VoidCallback? onAddressesTap;

  const ProfileSectionsList({
    super.key,
    this.dispatchAddress = 'No address saved yet',
    this.vaultCreditText = '0 EGP store credit available',
    this.controller,
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
              () => (controller ?? const ProfileController())
                  .onMyOrdersPressed(context),
        ),
        _buildTile(
          context,
          Icons.apartment_rounded,
          'White-Glove Dispatch Address',
          dispatchAddress,
          onTap: onAddressesTap ??
              () => (controller ?? const ProfileController())
                  .onSavedAddressesPressed(context),
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
          'Atelier Vault & Biometrics',
          'Protected Authentication • 2FA',
        ),
        const SizedBox(height: AppSpacing.spaceLg),
        _buildSectionHeader('PRIVILEGE & REGIONAL'),
        _buildTile(
          context,
          Icons.public_rounded,
          'Currency & Dispatch Region',
          'EGP (ج.م) • Egypt',
        ),
        _buildTile(
          context,
          Icons.headset_mic_outlined,
          'Private Salon Concierge Desk',
          'Priority 24/7 direct assistance',
          isGreenSubtitle: true,
        ),
        _buildTile(
          context,
          Icons.verified_user_outlined,
          'Terms of Privilege & Privacy',
          'Encrypted data compliance & heritage care',
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.spaceSm, top: AppSpacing.spaceXs),
      child: Text(
        title,
        style: AppTypography.labelCaps.copyWith(color: AppColors.slateBody, letterSpacing: 0.8),
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
      child: InkWell(
        onTap: onTap ??
            () => showCustomSnackBar(context,
                message: 'Opening $title...', type: SnackBarType.info),
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.spaceMd,
            vertical: AppSpacing.spaceSm + AppSpacing.spaceXs,
          ),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            border: Border.all(color: AppColors.outlineVariant, width: 1.0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.spaceSm),
                decoration: const BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: AppSpacing.spaceMd, color: AppColors.slateHeadline),
              ),
              const SizedBox(width: AppSpacing.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.w700, color: AppColors.slateHeadline)),
                    const SizedBox(height: AppSpacing.spaceXs / 2),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.bodySm.copyWith(
                        color: isGreenSubtitle ? AppColors.secondary : AppColors.slateBody,
                        fontSize: 11,
                        fontWeight: isGreenSubtitle ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, size: AppSpacing.spaceLg, color: AppColors.slateBody),
            ],
          ),
        ),
      ),
    );
  }
}
