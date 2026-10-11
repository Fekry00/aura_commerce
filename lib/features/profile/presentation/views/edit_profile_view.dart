import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_app_bar.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_avatar_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_credentials_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_danger_zone_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_footer.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_password_section.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_phone_section.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              EditProfileAppBar(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.margin),
                child: Column(
                  children: [
                    SizedBox(height: AppSpacing.spaceSm),
                    EditProfileAvatarSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    EditProfileCredentialsSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    EditProfilePhoneSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    EditProfilePasswordSection(),
                    SizedBox(height: AppSpacing.spaceLg),
                    EditProfileDangerZoneSection(),
                    SizedBox(height: AppSpacing.spaceMd),
                    EditProfileFooter(),
                    SizedBox(height: AppSpacing.spaceLg),
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
