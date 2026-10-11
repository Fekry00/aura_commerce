import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/custom_bottom_nav_bar.dart';
import 'package:aura/features/profile/presentation/widgets/concierge_liaison_card.dart';
import 'package:aura/features/profile/presentation/widgets/profile_app_bar.dart';
import 'package:aura/features/profile/presentation/widgets/profile_footer.dart';
import 'package:aura/features/profile/presentation/widgets/profile_header_section.dart';
import 'package:aura/features/profile/presentation/widgets/profile_quick_actions_grid.dart';
import 'package:aura/features/profile/presentation/widgets/profile_sections_list.dart';
import 'package:aura/features/profile/presentation/widgets/profile_sign_out_button.dart';
import 'package:aura/features/profile/presentation/widgets/profile_tier_card.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  int _currentNavIndex = 3;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentNavIndex,
        onItemTapped: (index) => setState(() => _currentNavIndex = index),
      ),
      body: SafeArea(
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
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
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
      ),
    );
  }
}
