import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/checkout/data/models/checkout_model.dart';
import 'package:aura/features/orders/data/models/order_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutModel> getCheckoutDetails();

  Future<bool> selectShippingAddress({required String addressId});

  Future<bool> selectDeliveryMethod({required String methodId});

  Future<bool> applyPrivilegePasscode({required String passcode});

  Future<bool> removePrivilegePasscode();

  Future<OrderModel> placeOrder({
    required String shippingAddress,
    required String phone,
    String paymentMethod = 'cod',
    String? notes,
    List<Map<String, dynamic>>? items,
  });
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<CheckoutModel> getCheckoutDetails() async {
    try {
      final response = await apiConsumer.get(EndPoint.cart);
      return CheckoutModel.fromJson(response);
    } catch (_) {
      return CheckoutModel.fromJson({});
    }
  }

  @override
  Future<bool> selectShippingAddress({required String addressId}) async {
    return true;
  }

  @override
  Future<bool> selectDeliveryMethod({required String methodId}) async {
    return true;
  }

  @override
  Future<bool> applyPrivilegePasscode({required String passcode}) async {
    try {
      final response = await apiConsumer.post(
        'coupons/validate',
        data: {'code': passcode},
      );
      return response['success'] ?? true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<bool> removePrivilegePasscode() async {
    return true;
  }

  @override
  Future<OrderModel> placeOrder({
    required String shippingAddress,
    required String phone,
    String paymentMethod = 'cod',
    String? notes,
    List<Map<String, dynamic>>? items,
  }) async {
    final body = <String, dynamic>{
      'shipping_address': shippingAddress,
      'phone': phone,
      'payment_method': paymentMethod,
    };
    if (notes != null && notes.trim().isNotEmpty) {
      body['notes'] = notes.trim();
    }
    if (items != null && items.isNotEmpty) {
      body['items'] = items;
    }

    final response = await apiConsumer.post(
      EndPoint.orders,
      data: body,
    );

    final data = (response['data'] is Map<String, dynamic>)
        ? response['data'] as Map<String, dynamic>
        : response;

    return OrderModel.fromJson(data);
  }
}
