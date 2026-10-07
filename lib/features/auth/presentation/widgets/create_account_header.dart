import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
 

class CreateAccountHeader extends StatelessWidget {
  const CreateAccountHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF0B3B2C),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'BESPOKE MEMBERSHIP',
              style: AppTypography.labelCaps.copyWith(
                color: const Color(0xFF0B3B2C),
                fontWeight: FontWeight.w800,
                fontSize: 10,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        Text(
          'Create Atelier Account',
          style: AppTypography.headlineLg.copyWith(
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: const Color(0xFF111827),
          ),
        ),
        const SizedBox(height: 6),

        Text(
          'Join Aura Luxe for bespoke privileges, early drop access, and complimentary global courier delivery.',
          style: AppTypography.bodySm.copyWith(
            color: AppColors.slateBody,
            height: 1.4,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: AppSpacing.spaceMd),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6).withOpacity(0.6),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFF0B3B2C),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.diamond_outlined, color: Colors.white, size: 16),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'TIER 01 INVITATION',
                      style: AppTypography.labelCaps.copyWith(
                        color: const Color(0xFF0B3B2C),
                        fontWeight: FontWeight.w800,
                        fontSize: 9,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Complimentary white-glove packaging on first order',
                    style: AppTypography.bodySm.copyWith(
                      color: const Color(0xFF374151),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}