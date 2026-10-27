import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryNotesSection extends StatelessWidget {
  const CheckoutDeliveryNotesSection({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CheckoutSectionCard(
      title: 'DELIVERY INSTRUCTIONS (OPTIONAL)',
      icon: Icons.notes_rounded,
      child: TextFormField(
        controller: controller,
        maxLines: 2,
        decoration: InputDecoration(
          hintText: 'e.g. Please ring the doorbell upon arrival',
          hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
          filled: true,
          fillColor: AppColors.surfaceContainerLowest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF0B3B2C), width: 1.5),
          ),
        ),
      ),
    );
  }
}
