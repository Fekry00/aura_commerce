import 'package:aura/core/network/api/end_points.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Centralized CacheManager for Aura Commerce with extended retention.
class AuraImageCacheManager {
  static const String cacheKey = 'aura_image_cache_v1';

  static final CacheManager instance = CacheManager(
    Config(
      cacheKey,
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 500,
      repo: JsonCacheInfoRepository(databaseName: cacheKey),
      fileService: HttpFileService(),
    ),
  );

  /// Normalizes any host (localhost, 10.0.2.2, LAN IP, relative path)
  /// to the current reachable server URL (e.g. 127.0.0.1:8000 via ADB reverse).
  static String normalizeUrl(String? url) {
    if (url == null || url.trim().isEmpty) return '';
    return EndPoint.fixImageUrl(url);
  }

  /// Extracts a normalized, host-agnostic cache key (e.g. 'storage/products/1.jpg')
  /// ensuring that images cached under localhost, 127.0.0.1, or LAN IP match the exact same cache entry.
  static String computeCacheKey(String url) {
    final clean = url.trim();
    if (clean.isEmpty) return '';
    try {
      final uri = Uri.parse(clean);
      if (uri.path.isNotEmpty) {
        return uri.path.startsWith('/') ? uri.path.substring(1) : uri.path;
      }
    } catch (_) {}
    return clean;
  }

  /// Helper to get a CachedNetworkImageProvider with custom cache manager and normalized key.
  static CachedNetworkImageProvider provider(String url) {
    final normalized = normalizeUrl(url);
    final key = computeCacheKey(normalized);
    return CachedNetworkImageProvider(
      normalized,
      cacheManager: instance,
      cacheKey: key.isNotEmpty ? key : null,
    );
  }
}
