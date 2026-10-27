import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/auth/presentation/controllers/auth_passphrase_controller.dart';
import 'package:flutter/material.dart';
import 'auth_field_header.dart';
import 'auth_text_form_field.dart';

/// Pure declarative UI widget for passphrase and confirmation section.
class AuthPassphraseSection extends StatefulWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final AuthPassphraseController? controller;

  const AuthPassphraseSection({
    super.key,
    required this.passwordController,
    required this.confirmPasswordController,
    this.controller,
  });

  @override
  State<AuthPassphraseSection> createState() => _AuthPassphraseSectionState();
}

class _AuthPassphraseSectionState extends State<AuthPassphraseSection> {
  late final AuthPassphraseController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AuthPassphraseController();
  }

  @override
  Widget build(BuildContext context) {
    final passwordText = widget.passwordController.text;
    final confirmText = widget.confirmPasswordController.text;

    final hasMinChars = _controller.hasMinChars(passwordText);
    final hasNumber = _controller.hasNumber(passwordText);
    final hasSymbol = _controller.hasSymbol(passwordText);
    final isStrong = _controller.isStrong(passwordText);
    final isMatching = _controller.isMatching(passwordText, confirmText);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const AuthFieldHeader(label: 'MASTER PASSPHRASE'),
            Text(
              isStrong ? 'STRONG' : 'REQUIRED',
              style: AppTypography.labelCaps.copyWith(
                color: isStrong
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
          obscureText: _controller.obscurePassword,
          hintText: 'Enter secure password',
          prefixIcon: Icons.lock_outline_rounded,
          onChanged: (_) => setState(() {}),
          validator: _controller.validatePassword,
          suffixWidget: IconButton(
            icon: Icon(
              _controller.obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              size: 18,
              color: const Color(0xFF9CA3AF),
            ),
            onPressed: () =>
                setState(() => _controller.toggleObscurePassword()),
          ),
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        Row(
          children: [
            Expanded(child: _buildBar(hasMinChars)),
            const SizedBox(width: 6),
            Expanded(child: _buildBar(hasNumber)),
            const SizedBox(width: 6),
            Expanded(child: _buildBar(hasSymbol)),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),

        Row(
          children: [
            _buildRequirementItem('8+ characters', hasMinChars),
            const SizedBox(width: AppSpacing.spaceSm + 4),
            _buildRequirementItem('1+ number', hasNumber),
            const SizedBox(width: AppSpacing.spaceSm + 4),
            _buildRequirementItem('1+ symbol', hasSymbol),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceMd),

        const AuthFieldHeader(label: 'CONFIRM PASSPHRASE'),
        const SizedBox(height: AppSpacing.spaceXs),
        AuthTextFormField(
          controller: widget.confirmPasswordController,
          obscureText: _controller.obscureConfirmPassword,
          hintText: 'Re-enter passphrase',
          prefixIcon: Icons.verified_user_outlined,
          onChanged: (_) => setState(() {}),
          validator: (value) =>
              _controller.validateConfirmPassword(value, passwordText),
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
                  child: const Icon(
                    Icons.check,
                    size: 12,
                    color: Color(0xFF0B3B2C),
                  ),
                ),
              IconButton(
                icon: Icon(
                  _controller.obscureConfirmPassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  size: 18,
                  color: const Color(0xFF9CA3AF),
                ),
                onPressed: () =>
                    setState(() => _controller.toggleObscureConfirmPassword()),
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
          color:
              isSatisfied ? const Color(0xFF0B3B2C) : const Color(0xFF9CA3AF),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 11,
            color: isSatisfied
                ? const Color(0xFF0B3B2C)
                : const Color(0xFF6B7280),
            fontWeight: isSatisfied ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}