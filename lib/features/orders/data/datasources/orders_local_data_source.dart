import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/orders/data/models/order_model.dart';

abstract class OrdersLocalDataSource {
  Future<OrderModel> getLastOrderDetails({String? orderId});

  Future<void> cacheOrder(OrderModel orderToCache);
}

class OrdersLocalDataSourceImpl implements OrdersLocalDataSource {
  const OrdersLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedOrderKey = 'CACHED_ORDER';

  @override
  Future<OrderModel> getLastOrderDetails({String? orderId}) async {
    return _buildDefaultOrder();
  }

  @override
  Future<void> cacheOrder(OrderModel orderToCache) async {
    // await cacheHelper.saveData(key: cachedOrderKey, value: orderToCache.toJson());
  }

  OrderModel _buildDefaultOrder() {
    return const OrderModel(
      id: 0,
      userId: 0,
      status: 'pending',
      totalAmount: 0.0,
      shippingAddress: '',
      paymentMethod: 'cod',
      phone: '',
      itemsCount: 0,
      items: [],
    );
  }
}
