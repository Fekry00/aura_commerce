import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/cart/data/models/cart_model.dart';

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

  Future<bool> applyVoucher({required String promoCode});

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
  Future<bool> applyVoucher({required String promoCode}) async {
    final response = await apiConsumer.post(
      '${EndPoint.cart}/voucher',
      data: {'code': promoCode},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> removeVoucher() async {
    final response = await apiConsumer.delete('${EndPoint.cart}/voucher');
    return response['success'] ?? true;
  }
}
