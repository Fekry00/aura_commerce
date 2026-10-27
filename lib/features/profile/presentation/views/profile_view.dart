import 'package:aura/features/profile/presentation/controllers/profile_controller.dart';
import 'package:aura/features/profile/presentation/widgets/profile_view_body.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  final ProfileController? controller;

  const ProfileView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: ProfileViewBody(controller: controller),
    );
  }
}
