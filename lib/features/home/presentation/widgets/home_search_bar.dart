import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onVoiceSearchTap;
  final VoidCallback? onFilterTap;

  const HomeSearchBar({
    super.key,
    this.controller,
    this.onSubmitted,
    this.onVoiceSearchTap,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: AppColors.slateBody, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: controller,
                    onSubmitted: onSubmitted,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search luxury watches, appar...',
                      hintStyle: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(
                    Icons.mic_none_rounded,
                    color: AppColors.slateBody,
                    size: 20,
                  ),
                  onPressed: onVoiceSearchTap,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onFilterTap,
          child: Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: AppColors.onSurface,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
