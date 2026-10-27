import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/profile/presentation/controllers/edit_profile_controller.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/utils/edit_profile_listener_handler.dart';
import 'package:aura/features/profile/presentation/widgets/edit_profile_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileView extends StatefulWidget {
  final EditProfileController? controller;

  const EditProfileView({
    super.key,
    this.controller,
  });

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  late final EditProfileController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? const EditProfileController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: EditProfileListenerHandler.handleState,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColors.onSurface,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Text(
              'EDIT PROFILE',
              style: AppTypography.labelCaps.copyWith(
                color: AppColors.primary,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          body: EditProfileViewBody(
            state: state,
            controller: _controller,
          ),
        );
      },
    );
  }
}
