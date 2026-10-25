class ProductPaginationEntity {
  const ProductPaginationEntity({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });

  final int currentPage;
  final int pageSize;
  final int totalItems;
  final int totalPages;
}
