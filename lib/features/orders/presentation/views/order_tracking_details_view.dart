import 'package:aura/core/di/injection_container.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/usecases/get_order_tracking_usecase.dart';
import 'package:aura/features/orders/presentation/controllers/order_tracking_controller.dart';
import 'package:aura/features/orders/presentation/widgets/order_receipt_app_bar.dart';
import 'package:aura/features/orders/presentation/widgets/order_tracking_details_body.dart';
import 'package:flutter/material.dart';

class OrderTrackingDetailsView extends StatefulWidget {
  final int? orderId;
  final OrderEntity? initialOrder;
  final GetOrderTrackingUseCase? getOrderTrackingUseCase;
  final OrderTrackingController controller;

  const OrderTrackingDetailsView({
    super.key,
    this.orderId,
    this.initialOrder,
    this.getOrderTrackingUseCase,
    this.controller = const OrderTrackingController(),
  });

  @override
  State<OrderTrackingDetailsView> createState() => _OrderTrackingDetailsViewState();
}

class _OrderTrackingDetailsViewState extends State<OrderTrackingDetailsView> {
  late final GetOrderTrackingUseCase _getOrderTrackingUseCase;
  OrderEntity? _order;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _getOrderTrackingUseCase =
        widget.getOrderTrackingUseCase ?? sl<GetOrderTrackingUseCase>();
    _order = widget.initialOrder;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTrackingData();
    });
  }

  int get _resolvedOrderId {
    if (widget.orderId != null) return widget.orderId!;
    if (_order != null) return _order!.id;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) return args;
    if (args is OrderEntity) return args.id;
    return 1;
  }

  Future<void> _loadTrackingData() async {
    setState(() {
      _isLoading = _order == null;
      _errorMessage = null;
    });

    final result = await _getOrderTrackingUseCase(_resolvedOrderId);
    if (!mounted) return;

    result.fold(
      (failure) {
        setState(() {
          _isLoading = false;
          if (_order == null) {
            _errorMessage = failure.errMessage;
          }
        });
      },
      (fetchedOrder) {
        setState(() {
          _order = fetchedOrder;
          _isLoading = false;
          _errorMessage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: const OrderReceiptAppBar(title: 'Dispatch Logistics'),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.secondary,
        ),
      );
    }

    if (_errorMessage != null && _order == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: AppColors.error,
              ),
              const SizedBox(height: AppSpacing.spaceSm),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: AppTypography.bodyMd.copyWith(color: AppColors.slateHeadline),
              ),
              const SizedBox(height: AppSpacing.spaceMd),
              ElevatedButton(
                onPressed: _loadTrackingData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry Tracking'),
              ),
            ],
          ),
        ),
      );
    }

    final effectiveOrder = _order;
    if (effectiveOrder == null) {
      return const Center(child: Text('No tracking data found.'));
    }

    return RefreshIndicator(
      color: AppColors.secondary,
      onRefresh: _loadTrackingData,
      child: OrderTrackingDetailsBody(
        order: effectiveOrder,
        controller: widget.controller,
      ),
    );
  }
}
