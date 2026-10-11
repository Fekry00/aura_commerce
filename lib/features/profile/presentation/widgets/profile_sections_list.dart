import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class ProfileSectionsList extends StatelessWidget {
  const ProfileSectionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('ORDERS & ACQUISITIONS'),
        _buildTile(context, Icons.local_shipping_outlined, 'Order History & Returns', 'Track active dispatch & instant courier pi...'),
        _buildTile(context, Icons.apartment_rounded, 'White-Glove Dispatch Ad...', 'Primary: 742 Evergreen St, Manhattan, NY'),
        _buildTile(context, Icons.account_balance_wallet_outlined, 'Payment Methods & Ateli...', '\$450.00 store credit available', isGreenSubtitle: true),
        const SizedBox(height: AppSpacing.spaceLg),
        _buildSectionHeader('CURATION & SECURITY'),
        _buildTile(context, Icons.straighten_outlined, 'Personal Sizing Profile', 'Tailored suit (IT 38), Footwear (EU 39), W...'),
        _buildTile(context, Icons.notifications_active_outlined, 'Runway Drops & Private A...', 'SMS, WhatsApp VIP & Push Active'),
        _buildTile(context, Icons.fingerprint_rounded, 'Atelier Vault & Biometrics', 'Face ID Authentication • 2FA Enforced'),
        const SizedBox(height: AppSpacing.spaceLg),
        _buildSectionHeader('PRIVILEGE & REGIONAL'),
        _buildTile(context, Icons.public_rounded, 'Currency & Dispatch Cou...', 'USD (\$) • United States'),
        _buildTile(context, Icons.headset_mic_outlined, 'Private Salon Concierge D...', 'Priority 24/7 direct dial available', isGreenSubtitle: true),
        _buildTile(context, Icons.verified_user_outlined, 'Terms of Privilege & Priva...', 'Encrypted data compliance & heritage c...'),
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

  Widget _buildTile(BuildContext context, IconData icon, String title, String subtitle, {bool isGreenSubtitle = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.spaceSm),
      child: InkWell(
        onTap: () => showCustomSnackBar(context, message: 'Opening $title...', type: SnackBarType.info),
        borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spaceMd, vertical: AppSpacing.spaceSm + AppSpacing.spaceXs),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            border: Border.all(color: AppColors.outlineVariant, width: 1.0),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.spaceSm),
                decoration: const BoxDecoration(color: AppColors.surfaceContainerLow, shape: BoxShape.circle),
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
