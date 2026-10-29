import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/app_constants.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_bottom_bar.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_delivery_notes_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_payment_method_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_payment_summary_card.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_security_assurance.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_shipping_address_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_step_header.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_state.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _initialized = true;
      String? defaultPhone;
      try {
        final profileState = context.read<ProfileCubit>().state;
        if (profileState is ProfileSuccessState &&
            profileState.profile != null) {
          final p = profileState.profile!.user.phone;
          if (p.isNotEmpty && p != '01012345678') defaultPhone = p;
        }
      } catch (_) {}
      final defaultAddress = UserAddressManager.getDefaultAddress();
      final cubit = context.read<CheckoutCubit>();
      cubit.initCheckout(
        defaultAddress: defaultAddress?.address,
        defaultPhone: defaultPhone ?? defaultAddress?.phone,
      );
      if (cubit.selectedShippingAddress != null) {
        _addressController.text = cubit.selectedShippingAddress!;
      }
      if (cubit.recipientPhone != null) {
        _phoneController.text = cubit.recipientPhone!;
      }
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _onConfirmOrder() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<CheckoutCubit>().placeOrder(
            shippingAddress: _addressController.text,
            phone: _phoneController.text,
            deliveryNotes: _notesController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutErrorState) {
          showCustomSnackBar(context, message: state.message, type: SnackBarType.error);
        } else if (state is CheckoutOrderPlacedState) {
          showCustomSnackBar(context, message: 'Order placed successfully!', type: SnackBarType.success);
          context.read<CartCubit>().fetchCart();
          Navigator.pushReplacementNamed(context, Routes.orderSuccessReceiptView, arguments: state.order);
        } else if (state is CheckoutFlowUpdatedState) {
          if (state.selectedShippingAddress != null && _addressController.text != state.selectedShippingAddress) {
            _addressController.text = state.selectedShippingAddress!;
          }
          if (state.recipientPhone != null && _phoneController.text != state.recipientPhone) {
            _phoneController.text = state.recipientPhone!;
          }
        }
      },
      builder: (context, state) {
        final isLoading = state is CheckoutLoadingState;
        final cartState = context.watch<CartCubit>().state;
        final cart = cartState is CartSuccessState ? cartState.cart : null;

        return Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: CheckoutBottomBar(
            totalAmount: cart?.orderSummary.total ?? 0,
            isLoading: isLoading,
            onConfirmOrder: _onConfirmOrder,
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.margin,
                vertical: AppSpacing.gutter,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckoutStepHeader(stepNumber: '${state.activeStepIndex}'),
                  const SizedBox(height: AppSpacing.margin),
                  CheckoutShippingAddressSection(
                    addressController: _addressController,
                    phoneController: _phoneController,
                    hasSavedAddresses: UserAddressManager.getSavedAddresses().isNotEmpty,
                    addressValidator: (v) => (v == null || v.trim().isEmpty)
                        ? 'Please provide a valid delivery address'
                        : null,
                    phoneValidator: (v) => (v == null ||
                            v.trim().isEmpty ||
                            !AppConstants.phoneRegex.hasMatch(v.trim()))
                        ? 'Please enter a valid contact phone number'
                        : null,
                    onChooseSavedAddress: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => SavedAddressesBottomSheet(
                        onSelectAddress: (addr) {
                          context.read<CheckoutCubit>().selectSavedAddress(addr);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.margin),
                  CheckoutPaymentMethodSection(
                    selectedMethod: state.selectedPaymentMethod,
                    onMethodSelected: (m) =>
                        context.read<CheckoutCubit>().selectPaymentMethod(m),
                  ),
                  const SizedBox(height: AppSpacing.margin),
                  CheckoutDeliveryNotesSection(controller: _notesController),
                  const SizedBox(height: AppSpacing.margin),
                  CheckoutPaymentSummaryCard(
                    itemsCount: cart?.orderSummary.itemsCount ?? 0,
                    subtotal: cart?.orderSummary.subtotal ?? 0,
                    totalAmount: cart?.orderSummary.total ?? 0,
                  ),
                  const SizedBox(height: AppSpacing.margin),
                  const CheckoutSecurityAssurance(),
                  const SizedBox(height: AppSpacing.margin),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
