import 'package:aura/features/home/domain/entities/home_feed_entity.dart';

import 'sub_models/archive_story_model.dart';
import 'sub_models/banner_model.dart';
import 'sub_models/category_model.dart';
import 'sub_models/curated_drop_model.dart';
import 'sub_models/product_highlight_model.dart';

class HomeFeedModel extends HomeFeedEntity {
  const HomeFeedModel({
    required super.deliveryLocation,
    required List<BannerModel> super.banners,
    CuratedDropModel? super.curatedDrop,
    required List<CategoryModel> super.categories,
    required List<ProductHighlightModel> super.highlights,
    ArchiveStoryModel? super.archiveStory,
  });

  factory HomeFeedModel.fromJson(Map<String, dynamic> json) {
    return HomeFeedModel(
      deliveryLocation:
          (json['delivery_location'] ?? json['deliveryLocation']) as String? ??
              'New York, NY',
      banners: (json['banners'] as List<dynamic>? ?? [])
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      curatedDrop: (json['curated_drop'] ?? json['curatedDrop']) != null
          ? CuratedDropModel.fromJson(
              (json['curated_drop'] ?? json['curatedDrop'])
                  as Map<String, dynamic>,
            )
          : null,
      categories: (json['categories'] as List<dynamic>? ?? [])
          .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      highlights: (json['highlights'] as List<dynamic>? ?? [])
          .map((e) => ProductHighlightModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      archiveStory: (json['archive_story'] ?? json['archiveStory']) != null
          ? ArchiveStoryModel.fromJson(
              (json['archive_story'] ?? json['archiveStory'])
                  as Map<String, dynamic>,
            )
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'delivery_location': deliveryLocation,
      'banners': banners.map((e) => (e as BannerModel).toJson()).toList(),
      'curated_drop': (curatedDrop as CuratedDropModel?)?.toJson(),
      'categories':
          categories.map((e) => (e as CategoryModel).toJson()).toList(),
      'highlights':
          highlights.map((e) => (e as ProductHighlightModel).toJson()).toList(),
      'archive_story': (archiveStory as ArchiveStoryModel?)?.toJson(),
    };
  }
}