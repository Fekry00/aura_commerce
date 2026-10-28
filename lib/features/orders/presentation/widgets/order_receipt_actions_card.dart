import 'package:flutter/material.dart';

class OrderReceiptActionsCard extends StatelessWidget {
  final VoidCallback onViewAllOrders;
  final VoidCallback onReturnHome;
  final VoidCallback? onTrackOrder;

  const OrderReceiptActionsCard({
    super.key,
    required this.onViewAllOrders,
    required this.onReturnHome,
    this.onTrackOrder,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (onTrackOrder != null) ...[
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: onTrackOrder,
              icon: const Icon(Icons.local_shipping_outlined, size: 18),
              label: const Text(
                'Track Courier Dispatch',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: onViewAllOrders,
            style: ElevatedButton.styleFrom(
              backgroundColor: onTrackOrder != null
                  ? Colors.white
                  : const Color(0xFF0B3B2C),
              foregroundColor: onTrackOrder != null
                  ? const Color(0xFF0B3B2C)
                  : Colors.white,
              side: onTrackOrder != null
                  ? const BorderSide(color: Color(0xFF0B3B2C))
                  : null,
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
