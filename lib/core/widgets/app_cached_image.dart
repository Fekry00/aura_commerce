import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/utils/image_cache_manager.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Centralized offline-first cached image widget with custom cache manager,
/// host-agnostic cache keys, and elegant luxury fallback placeholder.
class AppCachedImage extends StatelessWidget {
  const AppCachedImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
    this.fallbackAsset,
    this.fallbackIcon,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;
  final String? fallbackAsset;
  final IconData? fallbackIcon;

  @override
  Widget build(BuildContext context) {
    final normalizedUrl = AuraImageCacheManager.normalizeUrl(imageUrl);
    final cacheKey = AuraImageCacheManager.computeCacheKey(normalizedUrl);

    Widget imageWidget;
    if (normalizedUrl.isEmpty) {
      imageWidget = _buildFallback();
    } else {
      imageWidget = CachedNetworkImage(
        imageUrl: normalizedUrl,
        cacheKey: cacheKey.isNotEmpty ? cacheKey : null,
        cacheManager: AuraImageCacheManager.instance,
        width: width,
        height: height,
        fit: fit,
        placeholder: (ctx, url) => placeholder ?? const ShimmerImageLoading(),
        errorWidget: (ctx, url, err) => errorWidget ?? _buildFallback(),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: imageWidget);
    }
    return imageWidget;
  }

  Widget _buildFallback() {
    return Container(
      width: width,
      height: height,
      color: AppColors.surfaceContainerLow,
      child: Center(
        child: fallbackAsset != null
            ? Image.asset(
                fallbackAsset!,
                width: width != null ? width! * 0.45 : 36,
                height: height != null ? height! * 0.45 : 36,
                fit: BoxFit.contain,
              )
            : Icon(
                fallbackIcon ?? Icons.spa_outlined,
                color: AppColors.outline,
                size: (width != null && height != null)
                    ? (width! < height! ? width! * 0.45 : height! * 0.45)
                        .clamp(16.0, 48.0)
                    : 28,
              ),
      ),
    );
  }
}
