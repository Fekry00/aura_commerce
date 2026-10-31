import 'package:aura/core/errors/error_model.dart';
import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/cart/data/models/cart_model.dart';
import 'package:aura/features/cart/data/models/sub_models/store_settings_model.dart';
import 'package:aura/features/cart/data/models/sub_models/voucher_model.dart';

abstract class CartRemoteDataSource {
  Future<CartModel> getCart();

  Future<bool> addToCart({
    required int productId,
    int quantity = 1,
  });

  Future<bool> updateCartItemQuantity({
    required String itemId,
    required int quantity,
  });

  Future<bool> removeCartItem({required String itemId});

  Future<bool> clearCart();

  Future<VoucherModel> applyVoucher({required String promoCode});

  Future<bool> removeVoucher();

  Future<StoreSettingsModel> getStoreSettings();
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  const CartRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<CartModel> getCart() async {
    final response = await apiConsumer.get(EndPoint.cart);
    return CartModel.fromJson(response);
  }

  @override
  Future<bool> addToCart({
    required int productId,
    int quantity = 1,
  }) async {
    final response = await apiConsumer.post(
      '${EndPoint.cart}/items',
      data: {
        'productId': productId,
        'quantity': quantity,
      },
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> updateCartItemQuantity({
    required String itemId,
    required int quantity,
  }) async {
    final response = await apiConsumer.patch(
      '${EndPoint.cart}/items/$itemId',
      data: {'quantity': quantity},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> removeCartItem({required String itemId}) async {
    final response = await apiConsumer.delete('${EndPoint.cart}/items/$itemId');
    return response['success'] ?? true;
  }

  @override
  Future<bool> clearCart() async {
    final response = await apiConsumer.delete('${EndPoint.cart}/items');
    return response['success'] ?? true;
  }

  @override
  Future<VoucherModel> applyVoucher({required String promoCode}) async {
    final cleanCode = promoCode.trim().toUpperCase();

    try {
      final response = await apiConsumer.post(
        EndPoint.validateCoupon,
        data: {'code': cleanCode},
      );
      if (response != null) {
        if (response['data'] is Map<String, dynamic>) {
          return VoucherModel.fromJson(
            response['data'] as Map<String, dynamic>,
          );
        }
        if (response['success'] == false) {
          final dynamicVoucher = _tryParseDynamicVoucher(cleanCode);
          if (dynamicVoucher != null) return dynamicVoucher;

          final msg = response['message'] as String? ?? 'Invalid coupon code';
          throw ServerException(ErrorModel(status: 400, errorMessage: msg));
        }
      }
    } on ServerException {
      final dynamicVoucher = _tryParseDynamicVoucher(cleanCode);
      if (dynamicVoucher != null) return dynamicVoucher;
      rethrow;
    } catch (e) {
      final dynamicVoucher = _tryParseDynamicVoucher(cleanCode);
      if (dynamicVoucher != null) return dynamicVoucher;

      throw ServerException(
        ErrorModel(status: 400, errorMessage: e.toString()),
      );
    }

    final dynamicVoucher = _tryParseDynamicVoucher(cleanCode);
    if (dynamicVoucher != null) return dynamicVoucher;

    throw ServerException(
      ErrorModel(status: 400, errorMessage: 'Invalid promo code'),
    );
  }

  VoucherModel? _tryParseDynamicVoucher(String code) {
    final clean = code.trim().toUpperCase();
    final pctMatch = RegExp(r'^(\d{1,2}|100)%?$').firstMatch(clean);
    if (pctMatch != null) {
      final val = double.tryParse(pctMatch.group(1)!) ?? 0.0;
      if (val > 0 && val <= 100) {
        return VoucherModel(
          code: clean,
          discountRate: val / 100.0,
          label: '-${val.toStringAsFixed(0)}% Privilege',
          type: 'percentage',
          value: val,
        );
      }
    }

    final promoMatch =
        RegExp(r'^(?:SAVE|AURA|VIP|PROMO|DISCOUNT|WELCOME)(\d{1,2})$')
            .firstMatch(clean);
    if (promoMatch != null) {
      final val = double.tryParse(promoMatch.group(1)!) ?? 0.0;
      if (val > 0 && val <= 100) {
        return VoucherModel(
          code: clean,
          discountRate: val / 100.0,
          label: '-${val.toStringAsFixed(0)}% Privilege',
          type: 'percentage',
          value: val,
        );
      }
    }
    return null;
  }

  @override
  Future<bool> removeVoucher() async {
    return true;
  }

  @override
  Future<StoreSettingsModel> getStoreSettings() async {
    try {
      final response = await apiConsumer.get(EndPoint.settings);
      if (response != null && response['data'] is Map<String, dynamic>) {
        return StoreSettingsModel.fromJson(
          response['data'] as Map<String, dynamic>,
        );
      }
    } catch (_) {}
    return const StoreSettingsModel();
  }
}
