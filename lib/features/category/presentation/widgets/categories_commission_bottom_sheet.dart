import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CategoriesCommissionBottomSheet extends StatefulWidget {
  const CategoriesCommissionBottomSheet({
    super.key,
    required this.onSubmit,
  });

  final ValueChanged<String> onSubmit;

  static void show(
    BuildContext context, {
    required ValueChanged<String> onSubmit,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => CategoriesCommissionBottomSheet(onSubmit: onSubmit),
    );
  }

  @override
  State<CategoriesCommissionBottomSheet> createState() =>
      _CategoriesCommissionBottomSheetState();
}

class _CategoriesCommissionBottomSheetState
    extends State<CategoriesCommissionBottomSheet> {
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.outlineVariant.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFF0B3B2C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.room_service_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Private Commission Inquiry',
                      style: AppTypography.headlineSm.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Bespoke Horology & Fine Jewelry Concierge',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _noteController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
                  'Describe the historical reference piece or bespoke gem specification...',
              hintStyle: AppTypography.bodySm.copyWith(
                color: AppColors.slateBody,
              ),
              filled: true,
              fillColor: AppColors.surfaceContainerLow,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () => widget.onSubmit(_noteController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Text('Submit Commission Request'),
            ),
          ),
        ],
      ),
    );
  }
}
