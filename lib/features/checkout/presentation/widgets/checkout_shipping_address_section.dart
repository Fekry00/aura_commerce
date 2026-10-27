import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_section_card.dart';
import 'package:flutter/material.dart';

class CheckoutShippingAddressSection extends StatelessWidget {
  const CheckoutShippingAddressSection({
    super.key,
    required this.addressController,
    required this.phoneController,
    required this.hasSavedAddresses,
    required this.onChooseSavedAddress,
    this.addressValidator,
    this.phoneValidator,
  });

  final TextEditingController addressController;
  final TextEditingController phoneController;
  final bool hasSavedAddresses;
  final VoidCallback onChooseSavedAddress;
  final FormFieldValidator<String>? addressValidator;
  final FormFieldValidator<String>? phoneValidator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckoutSectionCard(
          title: 'CONSIGNMENT ADDRESS',
          icon: Icons.location_on_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (hasSavedAddresses) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'SAVED DESTINATIONS',
                      style: AppTypography.labelCaps.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 10,
                      ),
                    ),
                    GestureDetector(
                      onTap: onChooseSavedAddress,
                      child: const Text(
                        'Choose Saved Address',
                        style: TextStyle(
                          color: Color(0xFF0B3B2C),
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
              TextFormField(
                controller: addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: 'Enter street address, building, apartment, city...',
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
                    borderSide: const BorderSide(
                      color: Color(0xFF0B3B2C),
                      width: 1.5,
                    ),
                  ),
                ),
                validator: addressValidator,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        CheckoutSectionCard(
          title: 'RECIPIENT CONTACT PHONE',
          icon: Icons.phone_outlined,
          child: TextFormField(
            controller: phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'e.g. 010XXXXXXXX',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
              prefixIcon: const Icon(
                Icons.call_rounded,
                size: 18,
                color: Color(0xFF0B3B2C),
              ),
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
                borderSide: const BorderSide(
                  color: Color(0xFF0B3B2C),
                  width: 1.5,
                ),
              ),
            ),
            validator: phoneValidator,
          ),
        ),
      ],
    );
  }
}
