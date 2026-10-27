import 'package:flutter/material.dart';

class OrderReceiptActionsCard extends StatelessWidget {
  final VoidCallback onViewAllOrders;
  final VoidCallback onReturnHome;

  const OrderReceiptActionsCard({
    super.key,
    required this.onViewAllOrders,
    required this.onReturnHome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onViewAllOrders,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0B3B2C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'View All My Orders',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: OutlinedButton(
            onPressed: onReturnHome,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF0B3B2C)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: const Text(
              'Return to Home',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0B3B2C),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
