import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:aura/features/orders/domain/usecases/download_order_invoice_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_my_orders_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_order_details_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required this.getMyOrdersUseCase,
    required this.getOrderDetailsUseCase,
    required this.cancelOrderUseCase,
    required this.downloadOrderInvoiceUseCase,
  }) : super(const OrdersInitialState());

  final GetMyOrdersUseCase getMyOrdersUseCase;
  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final CancelOrderUseCase cancelOrderUseCase;
  final DownloadOrderInvoiceUseCase downloadOrderInvoiceUseCase;

  List<OrderEntity> _cachedOrders = [];
  List<OrderEntity> get orders => _cachedOrders;

  @override
  void emit(OrdersState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> fetchMyOrders({String? status}) async {
    emit(const OrdersLoadingState());

    final result = await getMyOrdersUseCase(status: status);

    result.fold(
      (failure) => emit(OrdersErrorState(message: failure.errMessage)),
      (ordersList) {
        _cachedOrders = ordersList;
        emit(OrdersListSuccessState(orders: ordersList));
      },
    );
  }

  Future<void> fetchOrderDetails(int orderId) async {
    emit(const OrdersLoadingState());

    final result = await getOrderDetailsUseCase(orderId);

    result.fold(
      (failure) => emit(OrdersErrorState(message: failure.errMessage)),
      (order) => emit(OrderDetailsSuccessState(order: order)),
    );
  }

  Future<void> cancelOrder(int orderId) async {
    emit(const OrdersLoadingState());

    final result = await cancelOrderUseCase(orderId);

    result.fold(
      (failure) => emit(OrdersErrorState(message: failure.errMessage)),
      (cancelledOrder) {
        // Update cached order if present
        final idx = _cachedOrders.indexWhere((o) => o.id == orderId);
        if (idx != -1) {
          _cachedOrders[idx] = cancelledOrder;
        }
        emit(OrderCancelSuccessState(order: cancelledOrder));
      },
    );
  }

  Future<void> downloadInvoice(String orderId) async {
    await downloadOrderInvoiceUseCase(orderId: orderId);
  }
}
