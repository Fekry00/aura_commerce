import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

class OrdersEmptyState extends StatelessWidget {
  final String message;
  final VoidCallback onStartShopping;

  const OrdersEmptyState({
    super.key,
    required this.message,
    required this.onStartShopping,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0B3B2C).withValues(alpha: 0.08),
              ),
              child: const Icon(
                Icons.receipt_long_outlined,
                size: 36,
                color: Color(0xFF0B3B2C),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No Orders Found',
              style: AppTypography.headlineSm.copyWith(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF002419),
              ),
            ),
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: AppTypography.bodySm.copyWith(
                  color: AppColors.slateBody,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onStartShopping,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Start Shopping'),
            ),
          ],
        ),
      ),
    );
  }
}
