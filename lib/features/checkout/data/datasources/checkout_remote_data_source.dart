import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/checkout/data/models/checkout_model.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutModel> getCheckoutDetails();

  Future<bool> selectShippingAddress({required String addressId});

  Future<bool> selectDeliveryMethod({required String methodId});

  Future<bool> applyPrivilegePasscode({required String passcode});

  Future<bool> removePrivilegePasscode();

  Future<String> placeOrder({
    required String addressId,
    required String deliveryMethodId,
    String? deliveryNotes,
    String? passcode,
  });
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  const CheckoutRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<CheckoutModel> getCheckoutDetails() async {
    final response = await apiConsumer.get(EndPoint.checkout);
    return CheckoutModel.fromJson(response);
  }

  @override
  Future<bool> selectShippingAddress({required String addressId}) async {
    final response = await apiConsumer.post(
      '${EndPoint.checkout}/address',
      data: {'address_id': addressId},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> selectDeliveryMethod({required String methodId}) async {
    final response = await apiConsumer.post(
      '${EndPoint.checkout}/delivery-method',
      data: {'method_id': methodId},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> applyPrivilegePasscode({required String passcode}) async {
    final response = await apiConsumer.post(
      '${EndPoint.checkout}/passcode',
      data: {'passcode': passcode},
    );
    return response['success'] ?? true;
  }

  @override
  Future<bool> removePrivilegePasscode() async {
    final response = await apiConsumer.delete('${EndPoint.checkout}/passcode');
    return response['success'] ?? true;
  }

  @override
  Future<String> placeOrder({
    required String addressId,
    required String deliveryMethodId,
    String? deliveryNotes,
    String? passcode,
  }) async {
    final data = <String, dynamic>{
      'address_id': addressId,
      'delivery_method_id': deliveryMethodId,
    };
    if (deliveryNotes != null) data['delivery_notes'] = deliveryNotes;
    if (passcode != null) data['passcode'] = passcode;

    final response = await apiConsumer.post(
      EndPoint.orders,
      data: data,
    );
    return response['order_id']?.toString() ?? 'AL-98421';
  }
}
