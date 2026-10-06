import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  const HomeSearchBar({super.key});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
                    controller: _controller,
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
                  onPressed: () {
                    showCustomSnackBar(
                      context,
                      message: 'Voice search is coming soon!',
                      type: SnackBarType.info,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            showCustomSnackBar(
              context,
              message: 'Opening filter options...',
              type: SnackBarType.info,
            );
          },
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
