import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/domain/entities/profile_entity.dart';
import 'package:aura/features/profile/domain/entities/sub_entities/user_profile_entity.dart';
import 'package:aura/features/profile/presentation/models/profile_metrics_data.dart';
import 'package:aura/features/profile/presentation/widgets/concierge_liaison_card.dart';
import 'package:aura/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:aura/features/profile/presentation/widgets/profile_footer.dart';
import 'package:aura/features/profile/presentation/widgets/profile_header_section.dart';
import 'package:aura/features/profile/presentation/widgets/profile_quick_actions_grid.dart';
import 'package:aura/features/profile/presentation/widgets/profile_sections_list.dart';
import 'package:aura/features/profile/presentation/widgets/profile_sign_out_button.dart';
import 'package:aura/features/profile/presentation/widgets/profile_tier_card.dart';
import 'package:flutter/material.dart';

class ProfileContentSection extends StatelessWidget {
  final UserProfileEntity? user;
  final ProfileEntity? profile;
  final ProfileMetricsData metrics;
  final ScrollController scrollController;
  final VoidCallback onSignOut;

  const ProfileContentSection({
    super.key,
    required this.user,
    required this.profile,
    required this.metrics,
    required this.scrollController,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.spaceSm),
        ProfileAppBar(
          avatarUrl: user?.avatarUrl,
          deliveryAddress: metrics.addressesSubtitle,
        ),
        const ProfileHeaderSection(),
        const SizedBox(height: AppSpacing.spaceSm),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileTierCard(
                userName: user?.name ?? 'Aura Client',
                userTier: (user?.role.isNotEmpty ?? false)
                    ? (user!.role == 'customer'
                        ? 'Customer'
                        : user!.role.toUpperCase())
                    : 'Member',
                customerId: user?.id ?? '#AL-000',
                patronSince: user?.patronSince ?? 'Oct 2026',
                avatarUrl: user?.avatarUrl ?? '',
                email: user?.email ?? '',
                phone: user?.phone ?? '',
                deliveredCount: metrics.deliveredCount,
                curationsCount: metrics.curationsCount.toString(),
                totalOrdersCount: metrics.totalOrdersCount,
              ),
              const SizedBox(height: AppSpacing.spaceMd),
              ConciergeLiaisonCard(liaison: profile?.liaison),
              const SizedBox(height: AppSpacing.spaceMd),
              ProfileQuickActionsGrid(
                scrollController: scrollController,
                activeOrdersCount: metrics.activeOrdersCount,
                activeOrdersSubtitle: metrics.activeOrdersSubtitle,
                wishlistCount: metrics.curationsCount,
                wishlistSubtitle: metrics.wishlistSubtitle,
                addressesCountText: metrics.addressesCountText,
                addressesSubtitle: metrics.addressesSubtitle,
                vaultPayStatus: metrics.vaultPayStatus,
                vaultPaySubtitle: metrics.vaultPaySubtitle,
              ),
              const SizedBox(height: AppSpacing.spaceLg),
              ProfileSectionsList(
                dispatchAddress: metrics.allUniqueAddresses.isNotEmpty
                    ? '${metrics.allUniqueAddresses.length} saved location${metrics.allUniqueAddresses.length > 1 ? 's' : ''}'
                    : 'No address saved yet',
              ),
              const SizedBox(height: AppSpacing.spaceLg),
              ProfileSignOutButton(onTap: onSignOut),
              const SizedBox(height: AppSpacing.spaceMd),
              const ProfileFooter(),
              const SizedBox(height: AppSpacing.spaceXl * 2),
            ],
          ),
        ),
      ],
    );
  }
}
