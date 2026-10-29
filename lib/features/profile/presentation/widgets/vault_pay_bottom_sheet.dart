import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/profile/data/services/user_payment_manager.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:flutter/material.dart';

class VaultPayBottomSheet extends StatefulWidget {
  final VoidCallback? onPaymentPreferenceChanged;

  const VaultPayBottomSheet({
    super.key,
    this.onPaymentPreferenceChanged,
  });

  static Future<void> show(
    BuildContext context, {
    VoidCallback? onPreferenceChanged,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => VaultPayBottomSheet(
        onPaymentPreferenceChanged: onPreferenceChanged,
      ),
    );
  }

  @override
  State<VaultPayBottomSheet> createState() => _VaultPayBottomSheetState();
}

class _VaultPayBottomSheetState extends State<VaultPayBottomSheet> {
  late String _selectedMethod;
  late List<SavedCardModel> _savedCards;
  bool _isAddingCard = false;

  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _cardHolderController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  String _detectedBrand = 'visa';
  bool _setAsDefault = true;

  @override
  void initState() {
    super.initState();
    _selectedMethod = UserPaymentManager.getPreferredPaymentMethod();
    _savedCards = UserPaymentManager.getSavedCards();
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  void _onSelectMethod(String method) async {
    setState(() {
      _selectedMethod = method;
    });
    await UserPaymentManager.setPreferredPaymentMethod(method);
    widget.onPaymentPreferenceChanged?.call();

    if (mounted) {
      showCustomSnackBar(
        context,
        message: 'Preferred payment method updated to ${UserPaymentManager.getPreferredPaymentSubtitle().replaceFirst('Preferred: ', '')}',
        type: SnackBarType.success,
      );
    }
  }

  void _saveNewCard() async {
    if (!_formKey.currentState!.validate()) return;

    final rawNumber = _cardNumberController.text.replaceAll(' ', '');
    final last4 = rawNumber.length >= 4
        ? rawNumber.substring(rawNumber.length - 4)
        : rawNumber;

    final newCard = SavedCardModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      last4: last4,
      holderName: _cardHolderController.text.trim().toUpperCase(),
      expiry: _expiryController.text.trim(),
      cardBrand: _detectedBrand,
      isDefault: _setAsDefault || _savedCards.isEmpty,
    );

    await UserPaymentManager.saveCard(newCard);
    await UserPaymentManager.setPreferredPaymentMethod('card');

    setState(() {
      _savedCards = UserPaymentManager.getSavedCards();
      _selectedMethod = 'card';
      _isAddingCard = false;
      _cardNumberController.clear();
      _cardHolderController.clear();
      _expiryController.clear();
      _cvvController.clear();
    });

    widget.onPaymentPreferenceChanged?.call();

    if (mounted) {
      showCustomSnackBar(
        context,
        message: 'Card linked successfully and set as preferred payment method',
        type: SnackBarType.success,
      );
    }
  }

  void _deleteCard(String id) async {
    await UserPaymentManager.deleteCard(id);
    setState(() {
      _savedCards = UserPaymentManager.getSavedCards();
      if (_savedCards.isEmpty && _selectedMethod == 'card') {
        _selectedMethod = 'cod';
        UserPaymentManager.setPreferredPaymentMethod('cod');
      }
    });
    widget.onPaymentPreferenceChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    String vaultCreditDisplay = '0 EGP';
    try {
      final profile = di.sl<ProfileCubit>().currentProfile;
      if (profile != null && profile.user.vaultCredit.isNotEmpty) {
        final raw = profile.user.vaultCredit.trim();
        vaultCreditDisplay = raw.toUpperCase().contains('EGP') ? raw : '$raw EGP';
      }
    } catch (_) {}

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.90,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag Handle
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.outlineVariant.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE9F0EC),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.shield_outlined,
                    color: Color(0xFF006C49),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Vault Pay',
                            style: AppTypography.headlineSm.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 7,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1FADF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'VERIFIED',
                              style: AppTypography.labelCaps.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: const Color(0xFF027A48),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Primary Payment Preferences & Encrypted Cards',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.slateBody,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: AppColors.onSurfaceVariant),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section 1: Preferred Method
                  Text(
                    'PREFERRED PAYMENT METHOD',
                    style: AppTypography.labelCaps.copyWith(
                      color: AppColors.slateHeadline,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildMethodOption(
                    id: 'cod',
                    icon: Icons.local_atm_rounded,
                    title: 'Cash on Delivery (COD)',
                    subtitle: 'Settled upon private white-glove consignment',
                  ),
                  const SizedBox(height: 10),

                  _buildMethodOption(
                    id: 'card',
                    icon: Icons.credit_card_rounded,
                    title: 'Credit / Debit Card',
                    subtitle: _savedCards.isNotEmpty
                        ? 'Charged to ${_savedCards.firstWhere((c) => c.isDefault, orElse: () => _savedCards.first).cardBrand.toUpperCase()} •• ${_savedCards.firstWhere((c) => c.isDefault, orElse: () => _savedCards.first).last4}'
                        : 'Visa, MasterCard, or American Express',
                  ),
                  const SizedBox(height: 10),

                  _buildMethodOption(
                    id: 'wallet',
                    icon: Icons.account_balance_wallet_outlined,
                    title: 'Digital Vault Wallet',
                    subtitle: 'Direct deduction from your encrypted reserves',
                  ),

                  const SizedBox(height: 24),

                  // Section 2: Vault Credit Card
                  _buildVaultCreditCard(vaultCreditDisplay),

                  const SizedBox(height: 24),

                  // Section 3: Saved Cards Section Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'LINKED PAYMENT CARDS (${_savedCards.length})',
                        style: AppTypography.labelCaps.copyWith(
                          color: AppColors.slateHeadline,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                          fontSize: 11,
                        ),
                      ),
                      if (!_isAddingCard)
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _isAddingCard = true;
                            });
                          },
                          icon: const Icon(Icons.add_rounded, size: 16),
                          label: const Text('Add Card'),
                          style: TextButton.styleFrom(
                            foregroundColor: const Color(0xFF006C49),
                            textStyle: AppTypography.labelSm.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  if (_isAddingCard) ...[
                    _buildAddCardForm(),
                    const SizedBox(height: 16),
                  ],

                  if (_savedCards.isEmpty && !_isAddingCard) ...[
                    _buildEmptyCardsPlaceholder(),
                  ] else ...[
                    ..._savedCards.map((card) => _buildCardTile(card)),
                  ],

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMethodOption({
    required String id,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final isSelected = _selectedMethod == id;

    return GestureDetector(
      onTap: () => _onSelectMethod(id),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9F0EC) : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF006C49)
                : AppColors.outlineVariant.withValues(alpha: 0.4),
            width: isSelected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF006C49) : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : AppColors.slateHeadline,
                size: 20,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF006C49),
                size: 22,
              )
            else
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.outlineVariant, width: 1.5),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVaultCreditCard(String balance) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF062319), Color(0xFF0E3E2E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF062319).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.diamond_outlined,
                    color: Color(0xFFD4AF37),
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'AURA VAULT RESERVES',
                    style: AppTypography.labelCaps.copyWith(
                      color: const Color(0xFFD4AF37),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w800,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'TIER PRIVILEGE',
                  style: AppTypography.labelCaps.copyWith(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            balance,
            style: AppTypography.displayHero.copyWith(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Instant credit applicable automatically at checkout',
            style: AppTypography.bodySm.copyWith(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardTile(SavedCardModel card) {
    final isSelectedCard = _selectedMethod == 'card' && card.isDefault;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelectedCard
              ? const Color(0xFF006C49)
              : AppColors.outlineVariant.withValues(alpha: 0.6),
          width: isSelectedCard ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF0B3B2C),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              card.cardBrand.toUpperCase(),
              style: AppTypography.labelCaps.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 10,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '••••  ••••  ••••  ${card.last4}',
                      style: AppTypography.labelSm.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        letterSpacing: 1.0,
                      ),
                    ),
                    if (card.isDefault) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD1FADF),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'DEFAULT',
                          style: AppTypography.labelCaps.copyWith(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF027A48),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${card.holderName} • Exp: ${card.expiry}',
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          if (!card.isDefault)
            IconButton(
              icon: const Icon(Icons.star_border_rounded, size: 20),
              tooltip: 'Set as Default',
              onPressed: () async {
                await UserPaymentManager.setDefaultCard(card.id);
                setState(() {
                  _savedCards = UserPaymentManager.getSavedCards();
                });
                widget.onPaymentPreferenceChanged?.call();
              },
            ),
          IconButton(
            icon: const Icon(Icons.delete_outline_rounded,
                size: 20, color: AppColors.error),
            onPressed: () => _deleteCard(card.id),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCardsPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.outlineVariant.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.credit_card_off_outlined,
            size: 32,
            color: AppColors.onSurfaceVariant,
          ),
          const SizedBox(height: 8),
          Text(
            'No credit cards linked yet',
            style: AppTypography.bodySm.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.slateHeadline,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Link your card for 1-tap fast checkout & concierge rewards',
            textAlign: TextAlign.center,
            style: AppTypography.bodySm.copyWith(
              color: AppColors.slateBody,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddCardForm() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF006C49), width: 1.5),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'LINK NEW CARD',
                  style: AppTypography.labelCaps.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.0,
                    color: const Color(0xFF006C49),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, size: 20),
                  onPressed: () {
                    setState(() {
                      _isAddingCard = false;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Card Number
            TextFormField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Card Number',
                hintText: '4000 1234 5678 9010',
                prefixIcon: const Icon(Icons.credit_card),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) {
                if (val.startsWith('4')) {
                  setState(() => _detectedBrand = 'visa');
                } else if (val.startsWith('5')) {
                  setState(() => _detectedBrand = 'mastercard');
                } else if (val.startsWith('3')) {
                  setState(() => _detectedBrand = 'amex');
                }
              },
              validator: (v) {
                if (v == null || v.trim().length < 15) {
                  return 'Please enter a valid card number';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Cardholder Name
            TextFormField(
              controller: _cardHolderController,
              textCapitalization: TextCapitalization.characters,
              decoration: InputDecoration(
                labelText: 'Cardholder Name',
                hintText: 'MOHAMED IBRAHIM',
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              validator: (v) {
                if (v == null || v.trim().isEmpty) {
                  return 'Please enter cardholder name';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),

            // Expiry and CVV
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _expiryController,
                    keyboardType: TextInputType.datetime,
                    decoration: InputDecoration(
                      labelText: 'Expiry (MM/YY)',
                      hintText: '08/29',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || !v.contains('/') || v.length < 5) {
                        return 'Invalid MM/YY';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextFormField(
                    controller: _cvvController,
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'CVV',
                      hintText: '•••',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.trim().length < 3) {
                        return 'Invalid CVV';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Set as Default Checkbox
            Row(
              children: [
                Checkbox(
                  value: _setAsDefault,
                  activeColor: const Color(0xFF006C49),
                  onChanged: (val) {
                    setState(() {
                      _setAsDefault = val ?? false;
                    });
                  },
                ),
                Text(
                  'Set as primary card for Vault Pay',
                  style: AppTypography.bodySm.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveNewCard,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006C49),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save & Link Card',
                  style: AppTypography.bodyMd.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
