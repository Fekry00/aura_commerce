import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackTap;

  const CheckoutAppBar({
    super.key,
    this.title = 'VAULT CHECKOUT',
    this.onBackTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18,
          color: Color(0xFF002419),
        ),
        onPressed: onBackTap ?? () => Navigator.maybePop(context),
      ),
      title: Text(
        title,
        style: AppTypography.headlineSm.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
          color: const Color(0xFF002419),
        ),
      ),
    );
  }
}
