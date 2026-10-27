import 'package:flutter/material.dart';

class OrdersCancelDialog extends StatelessWidget {
  final int orderId;
  final VoidCallback onKeepOrder;
  final VoidCallback onConfirmCancel;

  const OrdersCancelDialog({
    super.key,
    required this.orderId,
    required this.onKeepOrder,
    required this.onConfirmCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('Cancel Order?'),
      content: Text(
        'Are you sure you want to cancel order #AUR-$orderId? This will restore product inventory and cancel delivery.',
      ),
      actions: [
        TextButton(
          onPressed: onKeepOrder,
          child: const Text('Keep Order'),
        ),
        ElevatedButton(
          onPressed: onConfirmCancel,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFDC2626),
            foregroundColor: Colors.white,
          ),
          child: const Text('Yes, Cancel'),
        ),
      ],
    );
  }
}
