import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';
 
class AuthPassphraseSection extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const AuthPassphraseSection({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  State<AuthPassphraseSection> createState() => _AuthPassphraseSectionState();
}

class _AuthPassphraseSectionState extends State<AuthPassphraseSection> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  bool get _hasMinChars => widget.passwordController.text.length >= 8;
  bool get _hasNumber => widget.passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSymbol =>
      widget.passwordController.text.contains(RegExp(r'[!@#\$&*~%^()_\-+=<>?/{}[\]]'));

  @override
  Widget build(BuildContext context) {
    final isMatching = widget.confirmPasswordController.text.isNotEmpty &&
        widget.confirmPasswordController.text == widget.passwordController.text;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AuthFieldHeader(label: 'MASTER PASSPHRASE'),
            Text(
              _hasMinChars && _hasNumber && _hasSymbol ? 'STRONG' : 'REQUIRED',
              style: AppTypography.labelCaps.copyWith(
                color: _hasMinChars && _hasNumber && _hasSymbol
                    ? const Color(0xFF0B3B2C)
                    : const Color(0xFF9CA3AF),
                fontWeight: FontWeight.w800,
                fontSize: 10,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceXs),

        AuthTextFormField(
          controller: widget.passwordController,
          obscureText: _obscurePassword,
          hintText: 'Enter secure password',
          prefixIcon: Icons.lock_outline_rounded,
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Password is required';
            }
            if (value.length < 8) {
              return 'Password must be at least 8 characters';
            }
            return null;
          },
          suffixWidget: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              size: 18,
              color: const Color(0xFF9CA3AF),
            ),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),
 
        Row(
          children: [
            Expanded(child: _buildBar(_hasMinChars)),
            const SizedBox(width: 6),
            Expanded(child: _buildBar(_hasNumber)),
            const SizedBox(width: 6),
            Expanded(child: _buildBar(_hasSymbol)),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        Row(
          children: [
            _buildRequirementItem('8+ characters', _hasMinChars),
            const SizedBox(width: AppSpacing.spaceSm + 4),
            _buildRequirementItem('1+ number', _hasNumber),
            const SizedBox(width: AppSpacing.spaceSm + 4),
            _buildRequirementItem('1+ symbol', _hasSymbol),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),

        const AuthFieldHeader(label: 'CONFIRM PASSPHRASE'),
        const SizedBox(height: AppSpacing.spaceXs),
        AuthTextFormField(
          controller: widget.confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          hintText: 'Re-enter passphrase',
          prefixIcon: Icons.verified_user_outlined,
          onChanged: (_) => setState(() {}),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Please confirm your password';
            }
            if (value != widget.passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
          suffixWidget: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMatching)
                Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD1FAE5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, size: 12, color: Color(0xFF0B3B2C)),
                ),
              IconButton(
                icon: Icon(
                  _obscureConfirmPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 18,
                  color: const Color(0xFF9CA3AF),
                ),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBar(bool active) {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        color: active ? const Color(0xFF0B3B2C) : const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildRequirementItem(String title, bool isSatisfied) {
    return Row(
      children: [
        Icon(
          isSatisfied ? Icons.check_circle : Icons.radio_button_unchecked,
          size: 14,
          color: isSatisfied ? const Color(0xFF0B3B2C) : const Color(0xFF9CA3AF),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: isSatisfied ? const Color(0xFF0B3B2C) : const Color(0xFF6B7280),
            fontWeight: isSatisfied ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}