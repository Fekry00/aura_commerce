import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/checkout/data/models/sub_models/shipping_address_model.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:flutter/material.dart';

class SavedAddressesBottomSheet extends StatefulWidget {
  final ValueChanged<ShippingAddressModel>? onSelectAddress;

  const SavedAddressesBottomSheet({
    super.key,
    this.onSelectAddress,
  });

  @override
  State<SavedAddressesBottomSheet> createState() => _SavedAddressesBottomSheetState();
}

class _SavedAddressesBottomSheetState extends State<SavedAddressesBottomSheet> {
  late List<ShippingAddressModel> _addresses;
  bool _isAdding = false;

  final _formKey = GlobalKey<FormState>();
  String _selectedLabel = 'Home';
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _recipientController = TextEditingController();
  bool _setAsDefault = false;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  void _loadAddresses() {
    _addresses = UserAddressManager.getSavedAddresses();
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _recipientController.dispose();
    super.dispose();
  }

  void _onSaveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    final newAddress = ShippingAddressModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      label: _selectedLabel,
      recipient: _recipientController.text.trim(),
      phone: _phoneController.text.trim(),
      address: _addressController.text.trim(),
      isDefault: _setAsDefault || _addresses.isEmpty,
    );

    await UserAddressManager.saveAddress(newAddress);
    _addressController.clear();
    _phoneController.clear();
    _recipientController.clear();

    if (mounted) {
      setState(() {
        _isAdding = false;
        _loadAddresses();
      });
      showCustomSnackBar(
        context,
        message: 'Address saved successfully',
        type: SnackBarType.success,
      );
    }
  }

  void _onDelete(String id) async {
    await UserAddressManager.deleteAddress(id);
    if (mounted) {
      setState(() {
        _loadAddresses();
      });
      showCustomSnackBar(
        context,
        message: 'Address removed',
        type: SnackBarType.info,
      );
    }
  }

  void _onSetDefault(String id) async {
    await UserAddressManager.setDefaultAddress(id);
    if (mounted) {
      setState(() {
        _loadAddresses();
      });
      showCustomSnackBar(
        context,
        message: 'Default address updated',
        type: SnackBarType.success,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppSpacing.spaceLg),
        ),
      ),
      padding: EdgeInsets.only(
        top: AppSpacing.gutter,
        left: AppSpacing.margin,
        right: AppSpacing.margin,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.spaceLg,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: AppSpacing.spaceXl,
                height: AppSpacing.spaceXs,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(AppSpacing.space2Xs),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.gutter),

            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.spaceSm),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B3B2C).withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFF0B3B2C),
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DISPATCH DESTINATIONS',
                        style: AppTypography.labelCaps.copyWith(
                          color: const Color(0xFF0B3B2C),
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space2Xs),
                      Text(
                        'Manage your delivery addresses',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.slateBody,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isAdding)
                  TextButton.icon(
                    onPressed: () => setState(() => _isAdding = true),
                    icon: const Icon(
                      Icons.add,
                      size: 18,
                      color: Color(0xFF0B3B2C),
                    ),
                    label: Text(
                      'Add New',
                      style: AppTypography.bodySm.copyWith(
                        color: const Color(0xFF0B3B2C),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                if (_isAdding)
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => setState(() => _isAdding = false),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.gutter),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            const SizedBox(height: AppSpacing.gutter),

            if (_isAdding) ...[
              _buildAddAddressForm(),
            ] else if (_addresses.isEmpty) ...[
              _buildEmptyState(),
            ] else ...[
              ..._addresses.map((address) => _buildAddressCard(address)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space32),
      child: Center(
        child: Column(
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF0B3B2C).withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.location_off_outlined,
                size: 30,
                color: Color(0xFF0B3B2C),
              ),
            ),
            const SizedBox(height: AppSpacing.gutter),
            Text(
              'No Saved Addresses',
              style: AppTypography.priceCatalog.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: AppSpacing.spaceSm),
            Text(
              'Add your delivery locations for faster checkout',
              textAlign: TextAlign.center,
              style: AppTypography.bodySm.copyWith(
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: AppSpacing.margin),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.margin,
                  vertical: AppSpacing.space12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.space12),
                ),
              ),
              onPressed: () => setState(() => _isAdding = true),
              icon: const Icon(Icons.add, size: 18),
              label: Text(
                'Add Delivery Address',
                style: AppTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(ShippingAddressModel address) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.space12),
      padding: const EdgeInsets.all(AppSpacing.space12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(AppSpacing.space12),
        border: Border.all(
          color: address.isDefault
              ? const Color(0xFF0B3B2C).withValues(alpha: 0.4)
              : const Color(0xFFE2E8F0),
          width: address.isDefault ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.spaceSm,
                  vertical: AppSpacing.space2Xs,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B3B2C).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
                ),
                child: Text(
                  address.label.toUpperCase(),
                  style: AppTypography.labelCaps.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF0B3B2C),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: AppSpacing.spaceSm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.spaceSm,
                    vertical: AppSpacing.space2Xs,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B3B2C),
                    borderRadius: BorderRadius.circular(AppSpacing.spaceXs),
                  ),
                  child: Text(
                    'DEFAULT',
                    style: AppTypography.labelCaps.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
              const Spacer(),
              if (widget.onSelectAddress != null)
                TextButton(
                  onPressed: () {
                    widget.onSelectAddress!(address);
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Select',
                    style: AppTypography.bodySm.copyWith(
                      color: const Color(0xFF0B3B2C),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              IconButton(
                icon: const Icon(
                  Icons.delete_outline_rounded,
                  size: 18,
                  color: Colors.redAccent,
                ),
                onPressed: () => _onDelete(address.id),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Text(
            address.address,
            style: AppTypography.bodyMd.copyWith(
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          if (address.recipient.isNotEmpty || address.phone.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.spaceXs),
            Text(
              [
                if (address.recipient.isNotEmpty) address.recipient,
                if (address.phone.isNotEmpty) address.phone,
              ].join(' • '),
              style: AppTypography.bodySm.copyWith(
                color: const Color(0xFF64748B),
              ),
            ),
          ],
          if (!address.isDefault) ...[
            const SizedBox(height: AppSpacing.spaceSm),
            GestureDetector(
              onTap: () => _onSetDefault(address.id),
              child: Text(
                'Set as default address',
                style: AppTypography.bodySm.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF0B3B2C),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddAddressForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Address Label',
            style: AppTypography.labelSm.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          Row(
            children: ['Home', 'Office', 'Villa', 'Other'].map((label) {
              final isSelected = _selectedLabel == label;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.spaceSm),
                child: ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _selectedLabel = label);
                  },
                  selectedColor: const Color(0xFF0B3B2C),
                  labelStyle: AppTypography.labelSm.copyWith(
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Detailed Delivery Address *',
            style: AppTypography.labelSm.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          TextFormField(
            controller: _addressController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Enter street, building, apartment, city...',
              hintStyle: AppTypography.bodySm.copyWith(color: Colors.black38),
              filled: true,
              fillColor: AppColors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.space12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Please enter address' : null,
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Recipient Contact Phone',
            style: AppTypography.labelSm.copyWith(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: AppSpacing.spaceSm),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'e.g. 010XXXXXXXX',
              hintStyle: AppTypography.bodySm.copyWith(color: Colors.black38),
              filled: true,
              fillColor: AppColors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSpacing.space12),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _setAsDefault,
            activeColor: const Color(0xFF0B3B2C),
            title: Text(
              'Set as default delivery address',
              style: AppTypography.bodySm.copyWith(fontWeight: FontWeight.w600),
            ),
            onChanged: (val) => setState(() => _setAsDefault = val ?? false),
          ),
          const SizedBox(height: AppSpacing.gutter),
          SizedBox(
            width: double.infinity,
            height: AppSpacing.space2Xl,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.space12),
                ),
              ),
              onPressed: _onSaveAddress,
              child: Text(
                'Save Address',
                style: AppTypography.bodyMd.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
