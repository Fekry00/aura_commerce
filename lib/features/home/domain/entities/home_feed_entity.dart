import 'sub_entities/archive_story_entity.dart';
import 'sub_entities/banner_entity.dart';
import 'sub_entities/category_entity.dart';
import 'sub_entities/curated_drop_entity.dart';
import 'sub_entities/product_highlight_entity.dart';

class HomeFeedEntity {
  const HomeFeedEntity({
    required this.deliveryLocation,
    required this.banners,
    this.curatedDrop,
    required this.categories,
    required this.highlights,
    this.archiveStory,
  });

  final String deliveryLocation;
  final List<BannerEntity> banners;
  final CuratedDropEntity? curatedDrop;
  final List<CategoryEntity> categories;
  final List<ProductHighlightEntity> highlights;
  final ArchiveStoryEntity? archiveStory;
}
