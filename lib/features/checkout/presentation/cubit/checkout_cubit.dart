import 'package:aura/features/checkout/domain/usecases/apply_privilege_passcode_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/get_checkout_details_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/place_order_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/select_delivery_method_usecase.dart';
import 'package:aura/features/checkout/domain/usecases/select_shipping_address_usecase.dart';
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

  Future<void> fetchCheckoutDetails() async {
    emit(const CheckoutLoadingState());

    final result = await getCheckoutDetailsUseCase();

    result.fold(
      (failure) => emit(CheckoutErrorState(message: failure.errMessage)),
      (checkout) => emit(CheckoutSuccessState(checkout: checkout)),
    );
  }

  Future<void> selectShippingAddress(String addressId) async {
    final result = await selectShippingAddressUseCase(addressId: addressId);

    result.fold(
      (failure) => emit(CheckoutErrorState(message: failure.errMessage)),
      (isUpdated) {
        if (state is CheckoutSuccessState) {
          fetchCheckoutDetails();
        }
      },
    );
  }

  Future<void> selectDeliveryMethod(String methodId) async {
    final result = await selectDeliveryMethodUseCase(methodId: methodId);

    result.fold(
      (failure) => emit(CheckoutErrorState(message: failure.errMessage)),
      (isUpdated) {
        if (state is CheckoutSuccessState) {
          fetchCheckoutDetails();
        }
      },
    );
  }

  Future<void> applyPasscode(String passcode) async {
    final result = await applyPrivilegePasscodeUseCase(passcode: passcode);

    result.fold(
      (failure) => emit(CheckoutErrorState(message: failure.errMessage)),
      (isApplied) {
        if (state is CheckoutSuccessState) {
          fetchCheckoutDetails();
        }
      },
    );
  }

  Future<void> placeOrder({
    required String shippingAddress,
    required String phone,
    String paymentMethod = 'cod',
    String? deliveryNotes,
    List<Map<String, dynamic>>? items,
  }) async {
    emit(const CheckoutLoadingState());

    final result = await placeOrderUseCase(
      shippingAddress: shippingAddress,
      phone: phone,
      paymentMethod: paymentMethod,
      notes: deliveryNotes,
      items: items,
    );

    result.fold(
      (failure) => emit(CheckoutErrorState(message: failure.errMessage)),
      (order) => emit(CheckoutOrderPlacedState(order: order)),
    );
  }
}
