import 'package:aura/features/checkout/data/models/checkout_model.dart';
import 'package:aura/features/checkout/data/models/sub_models/checkout_payment_summary_model.dart';
import 'package:aura/features/checkout/data/models/sub_models/checkout_step_model.dart';
import 'package:aura/features/checkout/data/models/sub_models/delivery_method_model.dart';
import 'package:aura/features/checkout/data/models/sub_models/shipping_address_model.dart';

abstract class CheckoutLocalDataSource {
  Future<CheckoutModel> getLastCheckout();

  Future<void> cacheCheckout(CheckoutModel checkoutToCache);

  Future<bool> selectShippingAddressLocal(String addressId);

  Future<bool> selectDeliveryMethodLocal(String methodId);

  Future<bool> applyPrivilegePasscodeLocal(String passcode);

  Future<bool> removePrivilegePasscodeLocal();
}

class CheckoutLocalDataSourceImpl implements CheckoutLocalDataSource {
  const CheckoutLocalDataSourceImpl();

  static const String cachedCheckoutKey = 'CACHED_CHECKOUT';

  @override
  Future<CheckoutModel> getLastCheckout() async {
    return _buildDefaultCheckout();
  }

  @override
  Future<void> cacheCheckout(CheckoutModel checkoutToCache) async {
    // await cacheHelper.saveData(key: cachedCheckoutKey, value: checkoutToCache.toJson());
  }

  @override
  Future<bool> selectShippingAddressLocal(String addressId) async {
    return true;
  }

  @override
  Future<bool> selectDeliveryMethodLocal(String methodId) async {
    return true;
  }

  @override
  Future<bool> applyPrivilegePasscodeLocal(String passcode) async {
    return true;
  }

  @override
  Future<bool> removePrivilegePasscodeLocal() async {
    return true;
  }

  CheckoutModel _buildDefaultCheckout() {
    return const CheckoutModel(
      step: CheckoutStepModel(
        stepText: 'STEP 1 OF 2',
        nextStepText: 'Next: Payment',
        title: 'Shipping & Delivery',
        badgeText: 'VIP Privilege Active',
        progress: 0.5,
      ),
      addresses: [
        ShippingAddressModel(
          id: '1',
          label: 'Home',
          recipient: 'Ahmed Mohamed',
          phone: '+20 100 000 0000',
          address: '123 Main St, Gihan, Mansoura, Dakahlia, Egypt',
          isDefault: true,
        ),
        ShippingAddressModel(
          id: '2',
          label: 'Office / Atelier',
          recipient: 'Claire Daniels',
          phone: '+1 (555) 249-8100',
          address: '742 Evergreen St, Penthouse B, Manhattan, NY, United States',
          isDefault: false,
        ),
      ],
      selectedAddressId: '1',
      deliveryMethods: [
        DeliveryMethodModel(
          id: '1',
          title: 'White-Glove Armored Courier',
          vipPill: 'VIP FREE',
          description: 'Discreet temperature-controlled security van',
          eta: 'Est. 1–2 Business Days • May 16 - 17',
          price: 'Free',
          originalPrice: '\$40.00',
          isSelected: true,
        ),
        DeliveryMethodModel(
          id: '2',
          title: 'Standard Priority Delivery',
          description: 'Signature required air transit',
          eta: 'Est. 2–5 Business Days • May 18 - 21',
          price: 'Free',
          subPrice: '>\$1,000 Tier',
          isSelected: false,
        ),
      ],
      selectedDeliveryMethodId: '1',
      appliedPasscode: 'WELCOME10',
      paymentSummary: CheckoutPaymentSummaryModel(
        subtotal: '\$2,660.00',
        discount: '-\$266.00',
        discountPercentage: '10% OFF',
        shippingFee: 'COMPLIMENTARY',
        tax: '\$191.50',
        total: '\$2,585.50',
        itemsCountText: '3 Items Selected',
      ),
    );
  }
}
