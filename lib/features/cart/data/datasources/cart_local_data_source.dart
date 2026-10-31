import 'dart:convert';

import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/cart/data/models/cart_model.dart';
import 'package:aura/features/cart/data/models/sub_models/order_summary_model.dart';
import 'package:aura/features/cart/data/models/sub_models/shipping_meter_model.dart';
import 'package:aura/features/cart/data/models/sub_models/store_settings_model.dart';
import 'package:aura/features/cart/data/models/sub_models/voucher_model.dart';

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

  Future<VoucherModel?> getCachedVoucher();

  Future<void> cacheVoucher(VoucherModel voucher);

  Future<void> clearCachedVoucher();

  Future<StoreSettingsModel> getCachedSettings();

  Future<void> cacheSettings(StoreSettingsModel settings);
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  CartLocalDataSourceImpl() {
    CacheHelper.removeData(key: cachedVoucherKey);
  }

  static const String cachedCartKey = 'CACHED_CART';
  static const String cachedVoucherKey = 'CACHED_VOUCHER';

  VoucherModel? _activeSessionVoucher;

  @override
  Future<CartModel> getLastCart() async {
    final cachedData = CacheHelper.getDataString(key: cachedCartKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        final cart = CartModel.fromJson(decoded);
        return cart.applyVoucher(_activeSessionVoucher);
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
  Future<VoucherModel?> getCachedVoucher() async {
    return _activeSessionVoucher;
  }

  @override
  Future<void> cacheVoucher(VoucherModel voucher) async {
    _activeSessionVoucher = voucher;
    await CacheHelper.removeData(key: cachedVoucherKey);
  }

  @override
  Future<void> clearCachedVoucher() async {
    _activeSessionVoucher = null;
    await CacheHelper.removeData(key: cachedVoucherKey);
  }

  static const String cachedSettingsKey = 'CACHED_STORE_SETTINGS';

  @override
  Future<StoreSettingsModel> getCachedSettings() async {
    final cachedData = CacheHelper.getDataString(key: cachedSettingsKey);
    if (cachedData != null && cachedData.isNotEmpty) {
      try {
        final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
        return StoreSettingsModel.fromJson(decoded);
      } catch (_) {}
    }
    return const StoreSettingsModel();
  }

  @override
  Future<void> cacheSettings(StoreSettingsModel settings) async {
    await CacheHelper.saveData(
      key: cachedSettingsKey,
      value: jsonEncode(settings.toJson()),
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
    await clearCachedVoucher();
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
    await clearCachedVoucher();
    return true;
  }

  CartModel _emptyCart() {
    return const CartModel(
      curatedBadge: '0 CURATED ITEMS',
      shippingMeter: ShippingMeterModel(
        remainingAmount: 2000.0,
        threshold: 2000.0,
        progressRatio: 0.0,
        progressPercent: 0,
        message: 'Add 2000 EGP more for Complimentary Express Courier',
        isComplimentary: false,
      ),
      items: [],
      orderSummary: OrderSummaryModel(
        itemsCount: 0,
        subtotal: 0.0,
        discountAmount: 0.0,
        shippingLabel: '-',
        tax: 0.0,
        taxLocation: '',
        total: 0.0,
      ),
    );
  }
}

