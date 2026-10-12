import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutAppBar extends StatelessWidget {
  final String title;

  const CheckoutAppBar({
    super.key,
    this.title = 'Checkout',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.margin,
        vertical: AppSpacing.spaceSm,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () => Navigator.of(context).maybePop(),
                borderRadius: BorderRadius.circular(AppSpacing.margin),
                child: Container(
                  width: AppSpacing.spaceXl,
                  height: AppSpacing.spaceXl,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: AppSpacing.spaceMd + 2,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.spaceXs),
              Text(
                'AURA',
                style: AppTypography.labelCaps.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(width: AppSpacing.spaceXs / 2),
              Container(
                width: AppSpacing.spaceXs,
                height: AppSpacing.spaceXs,
                decoration: const BoxDecoration(
                  color: AppColors.mintHighlight,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: AppTypography.headlineSm.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(AppSpacing.spaceXs / 2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.outlineVariant,
                width: 1.5,
              ),
            ),
            child: const CircleAvatar(
              radius: AppSpacing.spaceMd - 2,
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=300',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
