import 'package:aura/core/network/api/api_consumer.dart';
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/features/wishlist/data/models/wishlist_model.dart';

abstract class WishlistRemoteDataSource {
  Future<WishlistModel> getWishlist();

  Future<bool> removeFromWishlist({required String productId});

  Future<bool> moveAllToBag();
}

class WishlistRemoteDataSourceImpl implements WishlistRemoteDataSource {
  const WishlistRemoteDataSourceImpl({required this.apiConsumer});

  final ApiConsumer apiConsumer;

  @override
  Future<WishlistModel> getWishlist() async {
    final response = await apiConsumer.get(EndPoint.wishlist);
    return WishlistModel.fromJson(response);
  }

  @override
  Future<bool> removeFromWishlist({required String productId}) async {
    final response = await apiConsumer.delete('${EndPoint.favorites}/$productId');
    return response['success'] ?? true;
  }

  @override
  Future<bool> moveAllToBag() async {
    final response = await apiConsumer.post('${EndPoint.cart}/move-all');
    return response['success'] ?? true;
  }
}
