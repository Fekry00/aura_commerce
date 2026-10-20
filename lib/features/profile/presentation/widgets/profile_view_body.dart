import 'package:aura/core/di/injection_container.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..fetchProfile(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSignedOutState) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.signInView,
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          final user = state.profile?.user;

          return SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.spaceSm),
                  ProfileAppBar(avatarUrl: user?.avatarUrl),
                  const ProfileHeaderSection(),
                  const SizedBox(height: AppSpacing.spaceSm),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.margin,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (user != null)
                          ProfileTierCard(
                            userName: user.name,
                            userTier: user.tier,
                            customerId: user.id,
                            patronSince: user.patronSince,
                            avatarUrl: user.avatarUrl,
                            targetTier: user.targetTier,
                            progress: user.progress,
                            spentAmount: user.spentAmount,
                            remainingToPrivilege: user.remainingToPrivilege,
                            deliveredCount: user.deliveredCount,
                            curationsCount: user.curationsCount,
                            vaultCredit: user.vaultCredit,
                          )
                        else
                          const ProfileTierCard(),
                        const SizedBox(height: AppSpacing.spaceMd),
                        const ConciergeLiaisonCard(),
                        const SizedBox(height: AppSpacing.spaceMd),
                        ProfileQuickActionsGrid(
                          scrollController: _scrollController,
                        ),
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
        },
      ),
    );
  }
}
