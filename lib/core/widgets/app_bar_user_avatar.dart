import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBarUserAvatar extends StatelessWidget {
  final double radius;
  final VoidCallback? onTap;
  final bool showBorder;

  const AppBarUserAvatar({
    super.key,
    this.radius = 16.0,
    this.onTap,
    this.showBorder = false,
  });

  @override
  Widget build(BuildContext context) {
    ProfileCubit cubit;
    try {
      cubit = context.read<ProfileCubit>();
    } catch (_) {
      cubit = di.sl<ProfileCubit>();
    }

    return BlocBuilder<ProfileCubit, ProfileState>(
      bloc: cubit,
      builder: (context, state) {
        final profile = state.profile ?? cubit.currentProfile;
        final user = profile?.user;
        final rawAvatar = user?.avatarUrl.trim() ?? '';
        final userName = user?.name.trim() ?? '';

        String effectiveUrl = EndPoint.fixImageUrl(rawAvatar);

        Widget avatarWidget;
        if (effectiveUrl.isNotEmpty &&
            (effectiveUrl.startsWith('http://') ||
                effectiveUrl.startsWith('https://'))) {
          avatarWidget = CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.surfaceContainerLow,
            backgroundImage: NetworkImage(effectiveUrl),
            onBackgroundImageError: (_, __) {},
          );
        } else if (userName.isNotEmpty) {
          avatarWidget = CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.primaryContainer,
            child: Text(
              userName[0].toUpperCase(),
              style: TextStyle(
                fontSize: radius * 0.9,
                fontWeight: FontWeight.w700,
                color: AppColors.onPrimaryContainer,
              ),
            ),
          );
        } else {
          avatarWidget = CircleAvatar(
            radius: radius,
            backgroundColor: AppColors.surfaceContainerLow,
            child: Icon(
              Icons.person_outline_rounded,
              size: radius * 1.1,
              color: AppColors.onSurfaceVariant,
            ),
          );
        }

        if (showBorder) {
          avatarWidget = Container(
            padding: const EdgeInsets.all(1.5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.outlineVariant, width: 1.2),
            ),
            child: avatarWidget,
          );
        }

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap ?? () => MainTabController.switchTab(3),
          child: avatarWidget,
        );
      },
    );
  }
}
