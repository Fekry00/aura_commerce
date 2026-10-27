import 'order_model.dart';

class OrdersPaginationModel {
  const OrdersPaginationModel({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;

  factory OrdersPaginationModel.fromJson(Map<String, dynamic> json) {
    return OrdersPaginationModel(
      currentPage: (json['currentPage'] ?? json['current_page'] as num?)?.toInt() ?? 1,
      pageSize: (json['pageSize'] ?? json['page_size'] as num?)?.toInt() ?? 15,
      totalItems: (json['totalItems'] ?? json['total_items'] ?? json['total'] as num?)?.toInt() ?? 0,
      totalPages: (json['totalPages'] ?? json['total_pages'] ?? json['last_page'] as num?)?.toInt() ?? 1,
    );
  }
}

class OrdersListModel {
  const OrdersListModel({
    required this.items,
    this.pagination,
  });

  final List<OrderModel> items;
  final OrdersPaginationModel? pagination;

  factory OrdersListModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = (json['data'] is Map<String, dynamic>)
        ? json['data'] as Map<String, dynamic>
        : json;

    final rawItems = (data['items'] as List<dynamic>? ?? []);
    final itemsList = rawItems
        .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final paginationMap = (data['pagination'] is Map<String, dynamic>)
        ? data['pagination'] as Map<String, dynamic>
        : null;

    return OrdersListModel(
      items: itemsList,
      pagination: paginationMap != null
          ? OrdersPaginationModel.fromJson(paginationMap)
          : null,
    );
  }
}
