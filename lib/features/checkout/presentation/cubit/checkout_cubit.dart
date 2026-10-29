import 'package:aura/core/utils/app_constants.dart';
import 'package:aura/features/checkout/data/models/sub_models/shipping_address_model.dart';
import 'package:aura/features/checkout/domain/usecases/apply_privilege_passcode_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/get_checkout_details_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/select_delivery_method_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/select_shipping_address_usecase.dart';
import 'package:aura/features/profile/data/services/user_address_manager.dart';
import 'package:aura/features/profile/data/services/user_payment_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit({
    required this.getCheckoutDetailsUseCase,
    required this.selectShippingAddressUseCase,
    required this.selectDeliveryMethodUseCase,
    required this.applyPrivilegePasscodeUseCase,
    required this.placeOrderUseCase,
  }) : super(const CheckoutInitialState());

  final GetCheckoutDetailsUseCase getCheckoutDetailsUseCase;
  final SelectShippingAddressUseCase selectShippingAddressUseCase;
  final SelectDeliveryMethodUseCase selectDeliveryMethodUseCase;
  final ApplyPrivilegePasscodeUseCase applyPrivilegePasscodeUseCase;
  final PlaceOrderUseCase placeOrderUseCase;

  String _selectedPaymentMethod = 'cod';
  int _selectedDeliveryMethodIndex = 0;
  int _activeStepIndex = 1;
  String? _selectedShippingAddress;
  String? _recipientPhone;
  String? _appliedPasscode;

  String get selectedPaymentMethod => _selectedPaymentMethod;
  int get selectedDeliveryMethodIndex => _selectedDeliveryMethodIndex;
  int get activeStepIndex => _activeStepIndex;
  String? get selectedShippingAddress => _selectedShippingAddress;
  String? get recipientPhone => _recipientPhone;
  String? get appliedPasscode => _appliedPasscode;

  @override
  void emit(CheckoutState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  void initCheckout({String? defaultAddress, String? defaultPhone}) {
    _selectedPaymentMethod = UserPaymentManager.getPreferredPaymentMethod();
    if (defaultAddress != null && defaultAddress.isNotEmpty) {
      _selectedShippingAddress = defaultAddress;
    } else {
      final defaultAddr = UserAddressManager.getDefaultAddress();
      if (defaultAddr != null && defaultAddr.address.isNotEmpty) {
        _selectedShippingAddress = defaultAddr.address;
        if (defaultPhone == null || defaultPhone.isEmpty) {
          _recipientPhone = defaultAddr.phone;
        }
      }
    }
    if (defaultPhone != null && defaultPhone.isNotEmpty) {
      _recipientPhone = defaultPhone;
    }
    _emitFlowUpdate();
  }

  void selectPaymentMethod(String method) {
    _selectedPaymentMethod = method;
    _emitFlowUpdate();
  }

  void selectDeliveryMethod(int index) {
    _selectedDeliveryMethodIndex = index;
    _emitFlowUpdate();
  }

  void selectSavedAddress(ShippingAddressModel addr) {
    _selectedShippingAddress = addr.address;
    if (addr.phone.isNotEmpty) {
      _recipientPhone = addr.phone;
    }
    _emitFlowUpdate();
  }

  void setStepIndex(int index) {
    _activeStepIndex = index;
    _emitFlowUpdate();
  }

  void removePasscode() {
    _appliedPasscode = null;
    _emitFlowUpdate();
  }

  void _emitFlowUpdate() {
    emit(CheckoutFlowUpdatedState(
      selectedPaymentMethod: _selectedPaymentMethod,
      selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
      activeStepIndex: _activeStepIndex,
      selectedShippingAddress: _selectedShippingAddress,
      recipientPhone: _recipientPhone,
      appliedPasscode: _appliedPasscode,
    ));
  }

  Future<void> fetchCheckoutDetails() async {
    emit(CheckoutLoadingState(
      selectedPaymentMethod: _selectedPaymentMethod,
      selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
      activeStepIndex: _activeStepIndex,
      selectedShippingAddress: _selectedShippingAddress,
      recipientPhone: _recipientPhone,
      appliedPasscode: _appliedPasscode,
    ));

    final result = await getCheckoutDetailsUseCase();

    result.fold(
      (failure) => emit(CheckoutErrorState(
        message: failure.errMessage,
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      )),
      (checkout) => emit(CheckoutSuccessState(
        checkout: checkout,
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      )),
    );
  }

  Future<void> applyPasscode(String passcode) async {
    final clean = passcode.trim();
    if (clean.isEmpty) {
      emit(CheckoutErrorState(
        message: 'Please enter a valid passcode',
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      ));
      return;
    }

    _appliedPasscode = clean;
    emit(CheckoutLoadingState(
      selectedPaymentMethod: _selectedPaymentMethod,
      selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
      activeStepIndex: _activeStepIndex,
      selectedShippingAddress: _selectedShippingAddress,
      recipientPhone: _recipientPhone,
      appliedPasscode: _appliedPasscode,
    ));

    final result = await applyPrivilegePasscodeUseCase(passcode: clean);

    result.fold(
      (failure) => emit(CheckoutErrorState(
        message: failure.errMessage,
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      )),
      (isApplied) => _emitFlowUpdate(),
    );
  }

  Future<void> placeOrder({
    required String shippingAddress,
    required String phone,
    String? deliveryNotes,
    List<Map<String, dynamic>>? items,
  }) async {
    final cleanAddress = shippingAddress.trim();
    final cleanPhone = phone.trim();

    if (cleanAddress.isEmpty) {
      emit(CheckoutErrorState(
        message: 'Please provide a valid delivery address',
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      ));
      return;
    }

    if (cleanPhone.isEmpty || !AppConstants.phoneRegex.hasMatch(cleanPhone)) {
      emit(CheckoutErrorState(
        message: 'Please enter a valid contact phone number',
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      ));
      return;
    }

    // Auto-save address to user's saved list if not present
    final saved = UserAddressManager.getSavedAddresses();
    if (!saved.any((a) =>
        a.address.trim().toLowerCase() == cleanAddress.toLowerCase())) {
      UserAddressManager.saveAddress(
        ShippingAddressModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          label: 'Delivery Location',
          recipient: '',
          phone: cleanPhone,
          address: cleanAddress,
          isDefault: saved.isEmpty,
        ),
      );
    }

    emit(CheckoutLoadingState(
      selectedPaymentMethod: _selectedPaymentMethod,
      selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
      activeStepIndex: _activeStepIndex,
      selectedShippingAddress: _selectedShippingAddress,
      recipientPhone: _recipientPhone,
      appliedPasscode: _appliedPasscode,
    ));

    final result = await placeOrderUseCase(
      shippingAddress: cleanAddress,
      phone: cleanPhone,
      paymentMethod: _selectedPaymentMethod,
      notes: deliveryNotes?.trim().isNotEmpty == true
          ? deliveryNotes!.trim()
          : null,
      items: items,
    );

    result.fold(
      (failure) => emit(CheckoutErrorState(
        message: failure.errMessage,
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      )),
      (order) => emit(CheckoutOrderPlacedState(
        order: order,
        selectedPaymentMethod: _selectedPaymentMethod,
        selectedDeliveryMethodIndex: _selectedDeliveryMethodIndex,
        activeStepIndex: _activeStepIndex,
        selectedShippingAddress: _selectedShippingAddress,
        recipientPhone: _recipientPhone,
        appliedPasscode: _appliedPasscode,
      )),
    );
  }
}
