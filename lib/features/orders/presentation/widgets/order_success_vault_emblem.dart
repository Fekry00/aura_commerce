import 'package:aura/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class OrderSuccessVaultEmblem extends StatelessWidget {
  const OrderSuccessVaultEmblem({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: AppColors.mintHighlight.withValues(alpha: 0.25),
                  blurRadius: 24,
                  spreadRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.verified_outlined,
                size: 34,
                color: AppColors.secondaryContainer,
              ),
            ),
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLowest,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.outlineVariant.withValues(alpha: 0.6),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: AppColors.primaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
