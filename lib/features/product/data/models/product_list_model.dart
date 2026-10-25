import 'package:aura/features/product/domain/entities/sub_entities/product_pagination_entity.dart';
import 'sub_models/product_item_model.dart';

class ProductPaginationModel extends ProductPaginationEntity {
  const ProductPaginationModel({
    required super.currentPage,
    required super.pageSize,
    required super.totalItems,
    required super.totalPages,
  });

  factory ProductPaginationModel.fromJson(Map<String, dynamic> json) {
    return ProductPaginationModel(
      currentPage: (json['currentPage'] ?? json['current_page']) as int? ?? 1,
      pageSize: (json['pageSize'] ?? json['page_size'] ?? json['per_page'])
              as int? ??
          20,
      totalItems:
          (json['totalItems'] ?? json['total_items'] ?? json['total'])
                  as int? ??
              0,
      totalPages:
          (json['totalPages'] ?? json['total_pages'] ?? json['last_page'])
                  as int? ??
              1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'pageSize': pageSize,
      'totalItems': totalItems,
      'totalPages': totalPages,
    };
  }
}

class ProductListModel {
  const ProductListModel({
    required this.items,
    required this.pagination,
  });

  final List<ProductItemModel> items;
  final ProductPaginationModel pagination;

  factory ProductListModel.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> data = json['data'] is Map<String, dynamic>
        ? json['data'] as Map<String, dynamic>
        : json;

    final itemsList = (data['items'] as List<dynamic>? ?? [])
        .map((e) => ProductItemModel.fromJson(e as Map<String, dynamic>))
        .toList();

    final paginationMap = data['pagination'] is Map<String, dynamic>
        ? data['pagination'] as Map<String, dynamic>
        : <String, dynamic>{};

    return ProductListModel(
      items: itemsList,
      pagination: ProductPaginationModel.fromJson(paginationMap),
    );
  }
}
