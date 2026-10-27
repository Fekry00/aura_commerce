import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class CheckoutPrivilegePasscodeSection extends StatelessWidget {
  final TextEditingController controller;
  final String? appliedCode;
  final ValueChanged<String> onApply;
  final VoidCallback onRemove;

  const CheckoutPrivilegePasscodeSection({
    super.key,
    required this.controller,
    this.appliedCode,
    required this.onApply,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final isApplied = appliedCode != null &&
        controller.text.trim().toUpperCase() == appliedCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.loyalty_rounded,
                  size: 20,
                  color: Color(0xFF0B3B2C),
                ),
                const SizedBox(width: 6),
                Text(
                  'Privilege Passcode',
                  style: AppTypography.headlineSm.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            Text(
              appliedCode != null ? '1 Applied' : 'None Applied',
              style: AppTypography.labelSm.copyWith(
                color: AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isApplied
                                ? Icons.check_circle_rounded
                                : Icons.sell_outlined,
                            size: 18,
                            color: isApplied
                                ? AppColors.secondary
                                : AppColors.outline,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              controller: controller,
                              textCapitalization: TextCapitalization.characters,
                              style: AppTypography.labelCaps.copyWith(
                                fontSize: 13,
                                color: AppColors.onSurface,
                              ),
                              decoration: const InputDecoration(
                                hintText: 'ENTER PASSCODE',
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onSubmitted: (val) => onApply(val.trim()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: isApplied ? null : () => onApply(controller.text.trim()),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isApplied
                            ? const Color(0xFF0B3B2C)
                            : AppColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        isApplied ? 'Applied' : 'Apply',
                        style: AppTypography.labelSm.copyWith(
                          color: isApplied ? Colors.white : const Color(0xFF002419),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (appliedCode != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFBDEDD7).withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.verified_user_rounded,
                        size: 16,
                        color: AppColors.secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '$appliedCode Privilege Active',
                          style: AppTypography.bodySm.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                      Text(
                        '-10% OFF BAG',
                        style: AppTypography.labelCaps.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: onRemove,
                        child: const Icon(
                          Icons.close_rounded,
                          size: 16,
                          color: AppColors.outline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
