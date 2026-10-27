import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/cart/presentation/cubit/cart_state.dart';
import 'package:aura/features/checkout/presentation/controllers/checkout_controller.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_state.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_app_bar.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_bottom_bar.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_delivery_notes_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_payment_method_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_payment_summary_card.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_security_assurance.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_shipping_address_section.dart';
import 'package:aura/features/checkout/presentation/widgets/checkout_step_header.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/presentation/widgets/saved_addresses_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final CheckoutController _controller = CheckoutController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller.init(context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CheckoutCubit, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutErrorState) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is CheckoutOrderPlacedState) {
          showCustomSnackBar(
            context,
            message: 'Order placed successfully!',
            type: SnackBarType.success,
          );
          context.read<CartCubit>().fetchCart();
          Navigator.pushReplacementNamed(
            context,
            Routes.orderSuccessReceiptView,
            arguments: state.order,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is CheckoutLoadingState;
        final cartState = context.watch<CartCubit>().state;
        final cart = cartState is CartSuccessState ? cartState.cart : null;
        final totalAmount = cart?.orderSummary.subtotal ?? 0;
        final itemsCount = cart?.orderSummary.itemsCount ?? 0;
        final savedAddresses = UserAddressManager.getSavedAddresses();

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CheckoutAppBar(),
          bottomNavigationBar: CheckoutBottomBar(
            totalAmount: totalAmount,
            isLoading: isLoading,
            onConfirmOrder: () => _controller.placeOrder(context),
          ),
          body: Form(
            key: _controller.formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CheckoutStepHeader(),
                  const SizedBox(height: 20),
                  CheckoutShippingAddressSection(
                    addressController: _controller.addressController,
                    phoneController: _controller.phoneController,
                    hasSavedAddresses: savedAddresses.isNotEmpty,
                    addressValidator: _controller.validateAddress,
                    phoneValidator: _controller.validatePhone,
                    onChooseSavedAddress: () => showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (_) => SavedAddressesBottomSheet(
                        onSelectAddress: (addr) =>
                            _controller.onSelectSavedAddress(
                          addr,
                          () => setState(() {}),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CheckoutPaymentMethodSection(
                    selectedMethod: _controller.selectedPaymentMethod,
                    onMethodSelected: (method) =>
                        _controller.onSelectPaymentMethod(
                      method,
                      () => setState(() {}),
                    ),
                  ),
                  const SizedBox(height: 20),
                  CheckoutDeliveryNotesSection(
                    controller: _controller.notesController,
                  ),
                  const SizedBox(height: 20),
                  CheckoutPaymentSummaryCard(
                    itemsCount: itemsCount,
                    subtotal: totalAmount,
                    totalAmount: totalAmount,
                  ),
                  const SizedBox(height: 20),
                  const CheckoutSecurityAssurance(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
