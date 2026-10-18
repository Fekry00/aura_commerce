import 'package:aura/features/orders/domain/usecases/download_order_invoice_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_order_details_usecase.dart';
import 'package:aura/features/orders/domain/usecases/get_order_tracking_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit({
    required this.getOrderDetailsUseCase,
    required this.getOrderTrackingUseCase,
    required this.downloadOrderInvoiceUseCase,
  }) : super(const OrdersInitialState());

  final GetOrderDetailsUseCase getOrderDetailsUseCase;
  final GetOrderTrackingUseCase getOrderTrackingUseCase;
  final DownloadOrderInvoiceUseCase downloadOrderInvoiceUseCase;

  Future<void> fetchOrderDetails({String? orderId}) async {
    emit(const OrdersLoadingState());

    final result = await getOrderDetailsUseCase(orderId: orderId);

    result.fold(
      (failure) => emit(OrdersErrorState(message: failure.errMessage)),
      (order) => emit(OrdersSuccessState(order: order)),
    );
  }

  Future<void> fetchOrderTracking({String? orderId}) async {
    emit(const OrdersLoadingState());

    final result = await getOrderTrackingUseCase(orderId: orderId);

    result.fold(
      (failure) => emit(OrdersErrorState(message: failure.errMessage)),
      (tracking) => emit(OrderTrackingSuccessState(tracking: tracking)),
    );
  }

  Future<void> downloadInvoice({required String orderId}) async {
    final result = await downloadOrderInvoiceUseCase(orderId: orderId);

    result.fold(
      (failure) => null,
      (isDownloaded) {},
    );
  }
}
