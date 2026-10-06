import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';


class ProductDetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ProductDetailAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18, color: AppColors.onSurface),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Product Detail',
        style: AppTypography.headlineSm.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.share_outlined, size: 20, color: AppColors.onSurface),
          onPressed: () {
            showCustomSnackBar(context, message: 'Share link copied!', type: SnackBarType.info);
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite_border_rounded, size: 22, color: AppColors.onSurface),
          onPressed: () {
            showCustomSnackBar(context, message: 'Added to wishlist!', type: SnackBarType.success);
          },
        ),
        const SizedBox(width: 4),
      ],
    );
  }
}