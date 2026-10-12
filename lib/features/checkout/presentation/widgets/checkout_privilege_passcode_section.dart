import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:flutter/material.dart';

class CheckoutPrivilegePasscodeSection extends StatefulWidget {
  final String initialCode;
  final ValueChanged<String>? onCodeApplied;

  const CheckoutPrivilegePasscodeSection({
    super.key,
    this.initialCode = 'WELCOME10',
    this.onCodeApplied,
  });

  @override
  State<CheckoutPrivilegePasscodeSection> createState() =>
      _CheckoutPrivilegePasscodeSectionState();
}

class _CheckoutPrivilegePasscodeSectionState
    extends State<CheckoutPrivilegePasscodeSection> {
  late final TextEditingController _controller;
  String? _appliedCode;

  @override
  void initState() {
    super.initState();
    _appliedCode = widget.initialCode;
    _controller = TextEditingController(text: widget.initialCode);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _apply() {
    final text = _controller.text.trim().toUpperCase();
    if (text.isEmpty) {
      showCustomSnackBar(context, message: 'Enter a passcode', type: SnackBarType.error);
      return;
    }
    setState(() => _appliedCode = text);
    widget.onCodeApplied?.call(text);
    showCustomSnackBar(context, message: 'Passcode $text applied!', type: SnackBarType.success);
    FocusScope.of(context).unfocus();
  }

  void _remove() {
    setState(() {
      _appliedCode = null;
      _controller.clear();
    });
    showCustomSnackBar(context, message: 'Passcode removed', type: SnackBarType.info);
  }

  @override
  Widget build(BuildContext context) {
    final isApplied = _appliedCode != null && _controller.text.trim().toUpperCase() == _appliedCode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.loyalty_rounded, size: 20, color: AppColors.primaryContainer),
                const SizedBox(width: 6),
                Text('Privilege Passcode', style: AppTypography.headlineSm.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
            Text(
              _appliedCode != null ? '1 Applied' : 'None Applied',
              style: AppTypography.labelSm.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.spaceSm),
        Container(
          padding: const EdgeInsets.all(AppSpacing.spaceMd),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppSpacing.spaceMd),
            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 2))],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: BoxDecoration(color: AppColors.surfaceContainerLow, borderRadius: BorderRadius.circular(24)),
                      child: Row(
                        children: [
                          Icon(isApplied ? Icons.check_circle_rounded : Icons.sell_outlined, size: 18, color: isApplied ? AppColors.secondary : AppColors.outline),
                          const SizedBox(width: AppSpacing.spaceSm),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              textCapitalization: TextCapitalization.characters,
                              style: AppTypography.labelCaps.copyWith(fontSize: 13, color: AppColors.onSurface),
                              decoration: const InputDecoration(hintText: 'ENTER PASSCODE', border: InputBorder.none, isDense: true),
                              onChanged: (_) => setState(() {}),
                              onSubmitted: (_) => _apply(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.spaceSm),
                  InkWell(
                    onTap: isApplied ? null : _apply,
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isApplied ? AppColors.primaryContainer : AppColors.secondaryContainer,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Text(
                        isApplied ? 'Applied' : 'Apply',
                        style: AppTypography.labelSm.copyWith(color: isApplied ? Colors.white : AppColors.primary, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
              if (_appliedCode != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(color: const Color(0xFFBDEDD7).withValues(alpha: 0.35), borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    children: [
                      const Icon(Icons.verified_user_rounded, size: 16, color: AppColors.secondary),
                      const SizedBox(width: AppSpacing.spaceSm),
                      Expanded(
                        child: Text('$_appliedCode Privilege Active', style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w600, color: AppColors.onSurface)),
                      ),
                      Text('-10% OFF BAG', style: AppTypography.labelCaps.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w800)),
                      const SizedBox(width: 4),
                      InkWell(onTap: _remove, child: const Icon(Icons.close_rounded, size: 16, color: AppColors.outline)),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
