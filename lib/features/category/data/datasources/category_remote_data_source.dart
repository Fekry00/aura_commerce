import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/category/data/models/category_model.dart';

abstract class CategoryRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<CategoryModel> getCategoryDetails(int id);
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  const CategoryRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await apiConsumer.get(EndPoint.categories);
    final rawList = response is List
        ? response
        : (response is Map<String, dynamic> ? response[ApiKey.data] : null);

    if (rawList is List) {
      return rawList
          .map((item) => CategoryModel.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<CategoryModel> getCategoryDetails(int id) async {
    final response = await apiConsumer.get(EndPoint.categoryDetails(id));
    final data = (response is Map<String, dynamic> && response[ApiKey.data] != null)
        ? response[ApiKey.data] as Map<String, dynamic>
        : (response as Map<String, dynamic>);

    return CategoryModel.fromJson(data);
  }
}
