import 'package:aura/core/theme/app_typography.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'auth_field_header.dart';

class AuthPhoneField extends StatefulWidget {
  final TextEditingController controller;

  const AuthPhoneField({super.key, required this.controller});

  @override
  State<AuthPhoneField> createState() => _AuthPhoneFieldState();
}

class _AuthPhoneFieldState extends State<AuthPhoneField> {
  String _currentDialCode = '+20';
  String _currentCountryCode = 'EG';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AuthFieldHeader(label: 'PHONE NUMBER (COURIER DISPATCH)'),
        const SizedBox(height: AppSpacing.spaceXs),
        Container(
          height: 44,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF3F4F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              CountryCodePicker(
                onChanged: (CountryCode countryCode) {
                  setState(() {
                    _currentDialCode = countryCode.dialCode ?? '+20';
                    _currentCountryCode =
                        countryCode.code?.toLowerCase() ?? 'eg';
                  });
                },
                initialSelection: 'US',
                favorite: const ['+20', 'EG','+1', 'US',  '+966', 'SA'],
                showFlag: false,
                padding: EdgeInsets.zero,
                searchDecoration: InputDecoration(
                  hintText: 'Search country...',
                  prefixIcon: const Icon(Icons.search, size: 18),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
                  ),
                ),
                builder: (CountryCode? code) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$_currentCountryCode $_currentDialCode ⌵',
                        style: AppTypography.bodySm.copyWith(
                          color: const Color(0xFF4B5563),
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(width: AppSpacing.spaceSm + 2),
              const Icon(
                Icons.phone_outlined,
                size: 16,
                color: Color(0xFF9CA3AF),
              ),
              const SizedBox(width: AppSpacing.spaceSm),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF111827),
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Enter phone number',
                    hintStyle: TextStyle(
                      color: Color(0xFF9CA3AF),
                      fontSize: 13,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
