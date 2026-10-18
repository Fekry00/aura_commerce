import 'package:aura/core/errors/failure.dart';
import 'package:aura/features/orders/domain/repositories/orders_repository.dart';
import 'package:dartz/dartz.dart';

class DownloadOrderInvoiceUseCase {
  const DownloadOrderInvoiceUseCase(this.repository);

  final OrdersRepository repository;

  Future<Either<Failure, bool>> call({required String orderId}) {
    return repository.downloadInvoice(orderId: orderId);
  }
}
