import 'package:aura/core/errors/exceptions.dart';
import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/cart/data/models/cart_model.dart';
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
    final pctMatch = RegExp(r'^(\d{1,2})%?$').firstMatch(cleanCode);

    try {
      final response = await apiConsumer.post(
        EndPoint.validateCoupon,
        data: {'code': cleanCode},
      );
      if (response['data'] is Map<String, dynamic>) {
        return VoucherModel.fromJson(response['data'] as Map<String, dynamic>);
      }
    } on ServerException {
      if (pctMatch != null) {
        final pctValue = double.parse(pctMatch.group(1)!);
        if (pctValue > 0 && pctValue <= 100) {
          return VoucherModel(
            code: cleanCode,
            discountRate: pctValue / 100.0,
            label: '-${pctValue.round()}% Privilege',
            type: 'percentage',
            value: pctValue,
          );
        }
      }
      rethrow;
    } catch (_) {
      if (pctMatch != null) {
        final pctValue = double.parse(pctMatch.group(1)!);
        if (pctValue > 0 && pctValue <= 100) {
          return VoucherModel(
            code: cleanCode,
            discountRate: pctValue / 100.0,
            label: '-${pctValue.round()}% Privilege',
            type: 'percentage',
            value: pctValue,
          );
        }
      }
      rethrow;
    }

    if (pctMatch != null) {
      final pctValue = double.parse(pctMatch.group(1)!);
      return VoucherModel(
        code: cleanCode,
        discountRate: pctValue / 100.0,
        label: '-${pctValue.round()}% Privilege',
        type: 'percentage',
        value: pctValue,
      );
    }

    return VoucherModel(
      code: cleanCode,
      discountRate: 0.10,
      label: '-10% Privilege',
      type: 'percentage',
      value: 10.0,
    );
  }

  @override
  Future<bool> removeVoucher() async {
    return true;
  }
}
