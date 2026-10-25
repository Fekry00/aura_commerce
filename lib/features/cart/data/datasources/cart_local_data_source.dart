import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/cart/data/models/cart_model.dart';
import 'package:aura/features/cart/data/models/sub_models/cart_item_model.dart';
import 'package:aura/features/cart/data/models/sub_models/order_summary_model.dart';
import 'package:aura/features/cart/data/models/sub_models/shipping_meter_model.dart';
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
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  const CartLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedCartKey = 'CACHED_CART';

  @override
  Future<CartModel> getLastCart() async {
    return _buildDefaultCart();
  }

  @override
  Future<void> cacheCart(CartModel cartToCache) async {
    // await cacheHelper.saveData(key: cachedCartKey, value: cartToCache.toJson());
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

  CartModel _buildDefaultCart() {
    return const CartModel(
      curatedBadge: '3 CURATED ITEMS',
      shippingMeter: ShippingMeterModel(
        remainingAmount: 50.0,
        threshold: 2710.0,
        progressRatio: 0.85,
        progressPercent: 85,
        message: 'Add \$50.00 more for Complimentary Express Courier',
        isComplimentary: false,
      ),
      items: [
        CartItemModel(
          id: 'item_1',
          category: 'HOROLOGY',
          title: 'Aethel Minimalist Chronograph',
          subtitle: 'Brushed Titanium • 40mm',
          price: 1450.00,
          quantity: 1,
          imageUrl:
              'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
        ),
        CartItemModel(
          id: 'item_2',
          category: 'LEATHER GOODS',
          title: 'Verona Nappa Leather Tote',
          subtitle: 'Forest Green • One Size',
          price: 890.00,
          quantity: 1,
          imageUrl:
              'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
        ),
        CartItemModel(
          id: 'item_3',
          category: 'HAUTE PARFUMERIE',
          title: 'Oud & Bergamot Extrait',
          subtitle: 'Vaporisateur • 100ml',
          price: 320.00,
          quantity: 1,
          imageUrl:
              'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=600&q=80',
        ),
      ],
      voucher: VoucherModel(
        code: 'WELCOME10',
        discountRate: 0.10,
        label: '-10% VIP Privilege',
      ),
      orderSummary: OrderSummaryModel(
        itemsCount: 3,
        subtotal: 2660.0,
        discountAmount: 266.0,
        shippingLabel: 'COMPLIMENTARY',
        tax: 191.50,
        taxLocation: 'NY',
        total: 2585.50,
      ),
    );
  }
}
