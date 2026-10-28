import 'package:aura/core/utils/app_constants.dart';
import 'package:aura/features/checkout/data/models/sub_models/shipping_address_model.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/data/services/user_payment_manager.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  final TextEditingController passcodeController = TextEditingController();

  String selectedPaymentMethod = 'cod';
  int selectedDeliveryMethodIndex = 0;
  String? appliedPasscode;
  bool isInitialized = false;

  void init(BuildContext context) {
    if (!isInitialized) {
      isInitialized = true;
      selectedPaymentMethod = UserPaymentManager.getPreferredPaymentMethod();

      try {
        final profileState = context.read<ProfileCubit>().state;
        if (profileState is ProfileSuccessState &&
            profileState.profile != null) {
          final userPhone = profileState.profile!.user.phone;
          if (userPhone.isNotEmpty && userPhone != '01012345678') {
            phoneController.text = userPhone;
          }
        }
      } catch (_) {}

      final defaultAddress = UserAddressManager.getDefaultAddress();
      if (defaultAddress != null && defaultAddress.address.isNotEmpty) {
        addressController.text = defaultAddress.address;
        if (phoneController.text.isEmpty && defaultAddress.phone.isNotEmpty) {
          phoneController.text = defaultAddress.phone;
        }
      }
    }
  }

  void onSelectPaymentMethod(String method, VoidCallback onUpdate) {
    selectedPaymentMethod = method;
    onUpdate();
  }

  void onSelectDeliveryMethod(int index, VoidCallback onUpdate) {
    selectedDeliveryMethodIndex = index;
    onUpdate();
  }

  void onSelectSavedAddress(ShippingAddressModel addr, VoidCallback onUpdate) {
    addressController.text = addr.address;
    if (addr.phone.isNotEmpty) {
      phoneController.text = addr.phone;
    }
    onUpdate();
  }

  void onApplyPasscode(BuildContext context, String code, VoidCallback onUpdate) {
    appliedPasscode = code;
    onUpdate();
    context.read<CheckoutCubit>().applyPasscode(code);
  }

  void onRemovePasscode(VoidCallback onUpdate) {
    appliedPasscode = null;
    passcodeController.clear();
    onUpdate();
  }

  String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please provide a valid delivery address';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter a contact phone number';
    }
    if (!AppConstants.phoneRegex.hasMatch(value.trim())) {
      return 'Please enter a valid contact phone number';
    }
    return null;
  }

  void placeOrder(BuildContext context) {
    if (formKey.currentState == null || !formKey.currentState!.validate()) {
      return;
    }

    final address = addressController.text.trim();
    final phone = phoneController.text.trim();
    final notes = notesController.text.trim();

    // Auto-save address to user's saved list if not present
    if (address.isNotEmpty) {
      final saved = UserAddressManager.getSavedAddresses();
      if (!saved.any(
          (a) => a.address.trim().toLowerCase() == address.toLowerCase())) {
        UserAddressManager.saveAddress(
          ShippingAddressModel(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            label: 'Delivery Location',
            recipient: '',
            phone: phone,
            address: address,
            isDefault: saved.isEmpty,
          ),
        );
      }
    }

    context.read<CheckoutCubit>().placeOrder(
          shippingAddress: address,
          phone: phone,
          paymentMethod: selectedPaymentMethod,
          deliveryNotes: notes.isNotEmpty ? notes : null,
        );
  }

  void dispose() {
    addressController.dispose();
    phoneController.dispose();
    notesController.dispose();
    passcodeController.dispose();
  }
}
