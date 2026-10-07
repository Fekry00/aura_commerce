import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
 

class AuthSalonAndTerms extends StatefulWidget {
  const AuthSalonAndTerms({super.key});

  @override
  State<AuthSalonAndTerms> createState() => _AuthSalonAndTermsState();
}

class _AuthSalonAndTermsState extends State<AuthSalonAndTerms> {
  bool _salonAccessChecked = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () => setState(() => _salonAccessChecked = !_salonAccessChecked),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 16,
                height: 16,
                margin: const EdgeInsets.only(top: 2),
                decoration: BoxDecoration(
                  color: _salonAccessChecked ? const Color(0xFF0B3B2C) : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: const Color(0xFF0B3B2C), width: 1.5),
                ),
                child: _salonAccessChecked
                    ? const Icon(Icons.check, size: 12, color: Colors.white)
                    : null,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Private Salon Access',
                      style: AppTypography.bodySm.copyWith(
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Receive private previews for upcoming limited atelier drops and member private sales',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.slateBody,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.spaceLg),
        RichText(
          text: TextSpan(
            text: "By creating an account, you agree to Aura's ",
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              fontSize: 11,
            ),
            children: [
              TextSpan(
                text: 'Terms of Privilege',
                style: AppTypography.bodySm.copyWith(
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  decoration: TextDecoration.underline,
                ),
              ),
              const TextSpan(text: ' and '),
              TextSpan(
                text: 'Privacy Policy',
                style: AppTypography.bodySm.copyWith(
                  color: const Color(0xFF111827),
                  fontWeight: FontWeight.w600,
                  fontSize: 11,
                  decoration: TextDecoration.underline,
                ),
              ),
              const TextSpan(text: '.'),
            ],
          ),
        ),
      ],
    );
  }
}