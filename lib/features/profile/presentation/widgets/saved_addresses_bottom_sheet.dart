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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Header Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
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
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'DISPATCH DESTINATIONS',
                        style: AppTypography.labelCaps.copyWith(
                          color: const Color(0xFF0B3B2C),
                          fontWeight: FontWeight.w800,
                          fontSize: 11,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Manage your delivery addresses',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.slateBody,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!_isAdding)
                  TextButton.icon(
                    onPressed: () => setState(() => _isAdding = true),
                    icon: const Icon(Icons.add, size: 18, color: Color(0xFF0B3B2C)),
                    label: const Text(
                      'Add New',
                      style: TextStyle(
                        color: Color(0xFF0B3B2C),
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
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
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            const SizedBox(height: 16),

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
      padding: const EdgeInsets.symmetric(vertical: 32),
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
            const SizedBox(height: 16),
            const Text(
              'No Saved Addresses',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Add your delivery locations for faster checkout',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () => setState(() => _isAdding = true),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add Delivery Address'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(ShippingAddressModel address) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFF0B3B2C).withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  address.label.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0B3B2C),
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              if (address.isDefault) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0B3B2C),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'DEFAULT',
                    style: TextStyle(
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
                  child: const Text(
                    'Select',
                    style: TextStyle(
                      color: Color(0xFF0B3B2C),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              IconButton(
                icon: const Icon(Icons.delete_outline_rounded, size: 18, color: Colors.redAccent),
                onPressed: () => _onDelete(address.id),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            address.address,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
          if (address.recipient.isNotEmpty || address.phone.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              [if (address.recipient.isNotEmpty) address.recipient, if (address.phone.isNotEmpty) address.phone].join(' • '),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF64748B),
              ),
            ),
          ],
          if (!address.isDefault) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _onSetDefault(address.id),
              child: const Text(
                'Set as default address',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0B3B2C),
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
          const Text(
            'Address Label',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: ['Home', 'Office', 'Villa', 'Other'].map((label) {
              final isSelected = _selectedLabel == label;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(label),
                  selected: isSelected,
                  onSelected: (val) {
                    if (val) setState(() => _selectedLabel = label);
                  },
                  selectedColor: const Color(0xFF0B3B2C),
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : const Color(0xFF334155),
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),
          const Text(
            'Detailed Delivery Address *',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _addressController,
            maxLines: 2,
            decoration: InputDecoration(
              hintText: 'Enter street, building, apartment, city...',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
              filled: true,
              fillColor: AppColors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter address' : null,
          ),
          const SizedBox(height: 12),
          const Text(
            'Recipient Contact Phone',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              hintText: 'e.g. 010XXXXXXXX',
              hintStyle: const TextStyle(fontSize: 13, color: Colors.black38),
              filled: true,
              fillColor: AppColors.surfaceContainerLowest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            value: _setAsDefault,
            activeColor: const Color(0xFF0B3B2C),
            title: const Text(
              'Set as default delivery address',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            onChanged: (val) => setState(() => _setAsDefault = val ?? false),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: _onSaveAddress,
              child: const Text(
                'Save Address',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
