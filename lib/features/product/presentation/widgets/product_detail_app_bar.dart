import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ProductDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool isFavorite;
  final VoidCallback? onBackTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onFavoriteTap;

  const ProductDetailAppBar({
    super.key,
    this.isFavorite = false,
    this.onBackTap,
    this.onShareTap,
    this.onFavoriteTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

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
          color: AppColors.onSurface,
        ),
        onPressed: onBackTap ?? () => Navigator.pop(context),
      ),
      title: Text(
        'Product Detail',
        style: AppTypography.headlineSm.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.share_outlined,
            size: 20,
            color: AppColors.onSurface,
          ),
          onPressed: onShareTap,
        ),
        IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border_rounded,
            size: 22,
            color: isFavorite ? AppColors.error : AppColors.onSurface,
          ),
          onPressed: onFavoriteTap,
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}