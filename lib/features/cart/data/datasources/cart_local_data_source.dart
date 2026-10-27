import 'dart:convert';

import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/cart/data/models/cart_model.dart';
import 'package:aura/features/cart/data/models/sub_models/order_summary_model.dart';
import 'package:aura/features/cart/data/models/sub_models/shipping_meter_model.dart';

abstract class CartLocalDataSource {
  Future<CartModel> getLastCart();

  Future<void> cacheCart(CartModel cartToCache);

  Future<bool> addToCartLocal({
    required int productId,
    int quantity = 1,
  });

  Future<bool> updateCartItemQuantityLocal({
    required String itemId,
    required int quantity,
  });

  Future<bool> removeCartItemLocal({
    required String itemId,
  });

  Future<bool> clearCartLocal();

  Future<bool> applyVoucherLocal({
    required String promoCode,
  });

  Future<bool> removeVoucherLocal();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  const CartLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedCartKey = 'CACHED_CART';

  @override
  Future<CartModel> getLastCart() async {
    final cachedData = CacheHelper.getDataString(key: cachedCartKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        return CartModel.fromJson(decoded);
      } catch (_) {}
    }
    return _emptyCart();
  }

  @override
  Future<void> cacheCart(CartModel cartToCache) async {
    await CacheHelper.saveData(
      key: cachedCartKey,
      value: jsonEncode(cartToCache.toJson()),
    );
  }

  @override
  Future<bool> addToCartLocal({
    required int productId,
    int quantity = 1,
  }) async {
    return true;
  }

  @override
  Future<bool> clearCartLocal() async {
    await CacheHelper.removeData(key: cachedCartKey);
    return true;
  }

  @override
  Future<bool> updateCartItemQuantityLocal({
    required String itemId,
    required int quantity,
  }) async {
    return true;
  }

  @override
  Future<bool> removeCartItemLocal({required String itemId}) async {
    return true;
  }

  @override
  Future<bool> applyVoucherLocal({required String promoCode}) async {
    return true;
  }

  @override
  Future<bool> removeVoucherLocal() async {
    return true;
  }

  CartModel _emptyCart() {
    return const CartModel(
      curatedBadge: '0 CURATED ITEMS',
      shippingMeter: ShippingMeterModel(
        remainingAmount: 0.0,
        threshold: 2000.0,
        progressRatio: 0.0,
        progressPercent: 0,
        message: 'Complimentary Express Courier Included',
        isComplimentary: true,
      ),
      items: [],
      orderSummary: OrderSummaryModel(
        itemsCount: 0,
        subtotal: 0.0,
        discountAmount: 0.0,
        shippingLabel: 'COMPLIMENTARY',
        tax: 0.0,
        taxLocation: '',
        total: 0.0,
      ),
    );
  }
}

