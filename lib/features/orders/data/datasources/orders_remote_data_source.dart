import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/orders/data/models/order_model.dart';
import 'package:aura/features/orders/data/models/orders_list_model.dart';

abstract class OrdersRemoteDataSource {
  Future<OrdersListModel> getMyOrders({String? status, int? perPage, int? page});

  Future<OrderModel> getOrderDetails(int orderId);

  Future<OrderModel> cancelOrder(int orderId);

  Future<bool> downloadInvoice({required String orderId});
}

class OrdersRemoteDataSourceImpl implements OrdersRemoteDataSource {
  const OrdersRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<OrdersListModel> getMyOrders({
    String? status,
    int? perPage,
    int? page,
  }) async {
    final query = <String, dynamic>{};
    if (status != null && status.isNotEmpty) query['status'] = status;
    if (perPage != null) query['per_page'] = perPage;
    if (page != null) query['page'] = page;

    final response = await apiConsumer.get(
      EndPoint.orders,
      queryParameters: query,
    );
    return OrdersListModel.fromJson(response);
  }

  @override
  Future<OrderModel> getOrderDetails(int orderId) async {
    final response = await apiConsumer.get('${EndPoint.orders}/$orderId');
    return OrderModel.fromJson(response);
  }

  @override
  Future<OrderModel> cancelOrder(int orderId) async {
    final response = await apiConsumer.post('${EndPoint.orders}/$orderId/cancel');
    return OrderModel.fromJson(response);
  }

  @override
  Future<bool> downloadInvoice({required String orderId}) async {
    final response = await apiConsumer.get('${EndPoint.orders}/$orderId/invoice');
    return response['success'] ?? true;
  }
}
