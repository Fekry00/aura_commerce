import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'concierge_liaison_card.dart';
import 'profile_app_bar.dart';
import 'profile_footer.dart';
import 'profile_header_section.dart';
import 'profile_quick_actions_grid.dart';
import 'profile_sections_list.dart';
import 'profile_sign_out_button.dart';
import 'profile_tier_card.dart';

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSpacing.spaceSm),
            const ProfileAppBar(),
            const ProfileHeaderSection(),
            const SizedBox(height: AppSpacing.spaceSm),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.margin,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileTierCard(),
                  const SizedBox(height: AppSpacing.spaceMd),
                  const ConciergeLiaisonCard(),
                  const SizedBox(height: AppSpacing.spaceMd),
                  ProfileQuickActionsGrid(scrollController: _scrollController),
                  const SizedBox(height: AppSpacing.spaceLg),
                  const ProfileSectionsList(),
                  const SizedBox(height: AppSpacing.spaceLg),
                  const ProfileSignOutButton(),
                  const SizedBox(height: AppSpacing.spaceMd),
                  const ProfileFooter(),
                  const SizedBox(height: AppSpacing.spaceXl * 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
