import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/features/home/data/models/home_feed_model.dart';
import 'package:aura/features/home/data/models/sub_models/archive_story_model.dart';
import 'package:aura/features/home/data/models/sub_models/banner_model.dart';
import 'package:aura/features/home/data/models/sub_models/category_model.dart';
import 'package:aura/features/home/data/models/sub_models/curated_drop_model.dart';
import 'package:aura/features/home/data/models/sub_models/product_highlight_model.dart';
import 'package:aura/features/home/data/models/sub_models/product_rating_model.dart';

abstract class HomeLocalDataSource {
  Future<HomeFeedModel> getLastHomeFeed();

  Future<void> cacheHomeFeed(HomeFeedModel feedToCache);

  Future<bool> toggleFavoriteLocal(String productId);
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  const HomeLocalDataSourceImpl({required this.cacheHelper});

  final CacheHelper cacheHelper;
  static const String cachedHomeFeedKey = 'CACHED_HOME_FEED';

  @override
  Future<HomeFeedModel> getLastHomeFeed() async {
    return _buildDefaultHomeFeed();
  }

  @override
  Future<void> cacheHomeFeed(HomeFeedModel feedToCache) async {
    // await cacheHelper.saveData(key: cachedHomeFeedKey, value: feedToCache.toJson());
  }

  @override
  Future<bool> toggleFavoriteLocal(String productId) async {
    return true;
  }

  HomeFeedModel _buildDefaultHomeFeed() {
    return HomeFeedModel(
      deliveryLocation: 'New York, NY',
      banners: const [
        BannerModel(
          id: 'banner_1',
          tag: 'EXCLUSIVE PREVIEW',
          title: 'The Architectural\nSilhouette',
          subtitle:
              'Curated Summer Capsule. Tactile tailoring sculpted for effortless modern...',
          ctaText: 'Explore Collection',
          imageUrl:
              'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80',
        ),
      ],
      curatedDrop: CuratedDropModel(
        id: 'drop_04',
        label: 'CURATED DROP 04',
        endTime: DateTime.now().add(
          const Duration(hours: 8, minutes: 24, seconds: 11),
        ),
      ),
      categories: const [
        CategoryModel(id: 'cat_1', name: 'Timepieces', iconKey: 'watch'),
        CategoryModel(id: 'cat_2', name: 'Leather', iconKey: 'bag'),
        CategoryModel(id: 'cat_3', name: 'Apparel', iconKey: 'apparel'),
        CategoryModel(id: 'cat_4', name: 'Jewelry', iconKey: 'diamond'),
        CategoryModel(id: 'cat_5', name: 'Fragrance', iconKey: 'fragrance'),
      ],
      highlights: const [
        ProductHighlightModel(
          id: 'prod_1',
          title: 'Aethel Minimalist...',
          price: 1450,
          imageUrl:
              'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
          rating: ProductRatingModel(average: 4.9, reviewsCount: 128),
          badge: 'BESTSELLER',
          isPopular: true,
        ),
        ProductHighlightModel(
          id: 'prod_2',
          title: 'Verona Nappa...',
          price: 890,
          imageUrl:
              'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
          rating: ProductRatingModel(average: 4.8, reviewsCount: 94),
          isPopular: true,
        ),
        ProductHighlightModel(
          id: 'prod_3',
          title: 'Oud & Bergamot...',
          price: 320,
          imageUrl:
              'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=600&q=80',
          rating: ProductRatingModel(average: 5.0, reviewsCount: 210),
          isPopular: true,
        ),
        ProductHighlightModel(
          id: 'prod_4',
          title: 'Structured Cashme...',
          price: 1280,
          imageUrl:
              'https://images.unsplash.com/photo-1539533018447-63fcce2678e3?auto=format&fit=crop&w=600&q=80',
          rating: ProductRatingModel(average: 4.7, reviewsCount: 65),
          badge: 'NEW',
          isPopular: false,
        ),
      ],
      archiveStory: const ArchiveStoryModel(
        id: 'story_1',
        label: 'ATELIER ARCHIVE',
        title: 'The Art of Pure Precision',
        subtitle: 'Meet the master artisans sh...',
        imageUrl:
            'https://images.unsplash.com/photo-1509048191080-d2984bad6ae5?auto=format&fit=crop&w=400&q=80',
      ),
    );
  }
}
