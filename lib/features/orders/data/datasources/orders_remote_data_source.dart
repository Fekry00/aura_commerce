import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/orders/data/models/order_model.dart';
import 'package:aura/features/orders/data/models/sub_models/order_tracking_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrderModel> getOrderDetails({String? orderId});

  Future<OrderTrackingModel> getOrderTracking({String? orderId});

  Future<bool> downloadInvoice({required String orderId});
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  const OrdersRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<OrderModel> getOrderDetails({String? orderId}) async {
    final path = orderId != null
        ? '${EndPoint.orders}/$orderId'
        : EndPoint.orders;
    final response = await apiConsumer.get(path);
    return OrderModel.fromJson(response);
  }

  @override
  Future<OrderTrackingModel> getOrderTracking({String? orderId}) async {
    final path = orderId != null
        ? '${EndPoint.orders}/$orderId/tracking'
        : '${EndPoint.orders}/tracking';
    final response = await apiConsumer.get(path);
    return OrderTrackingModel.fromJson(response);
  }

  @override
  Future<bool> downloadInvoice({required String orderId}) async {
    final response = await apiConsumer.get('${EndPoint.orders}/$orderId/invoice');
    return response['success'] ?? true;
  }
}
