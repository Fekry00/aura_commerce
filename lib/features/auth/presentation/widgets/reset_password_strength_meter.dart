import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class ResetPasswordStrengthMeter extends StatelessWidget {
  final int strength;

  const ResetPasswordStrengthMeter({super.key, required this.strength});

  Color get _strengthColor {
    switch (strength) {
      case 1:
        return AppColors.error;
      case 2:
        return const Color(0xFFF59E0B);
      case 3:
        return const Color(0xFF3B82F6);
      case 4:
        return AppColors.mintHighlight;
      default:
        return AppColors.outlineVariant;
    }
  }

  String get _strengthLabel {
    switch (strength) {
      case 1:
        return 'Weak';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Strong';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (strength == 0) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(4, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 3 ? 4 : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: i < strength ? _strengthColor : AppColors.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        if (_strengthLabel.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            'Password strength: $_strengthLabel',
            style: AppTypography.labelSm.copyWith(
              color: _strengthColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
