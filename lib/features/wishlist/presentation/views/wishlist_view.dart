import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/wishlist/presentation/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.surface,
      body: WishlistViewBody(),
    );
  }
}
