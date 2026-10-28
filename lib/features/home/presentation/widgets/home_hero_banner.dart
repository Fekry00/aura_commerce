import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/app_shimmer.dart';
import 'package:aura/features/home/domain/entities/sub_entities/banner_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeHeroBanner extends StatefulWidget {
  final List<BannerEntity>? banners;
  final void Function(BannerEntity banner)? onExploreTap;

  const HomeHeroBanner({
    super.key,
    this.banners,
    this.onExploreTap,
  });

  @override
  State<HomeHeroBanner> createState() => _HomeHeroBannerState();
}

class _HomeHeroBannerState extends State<HomeHeroBanner> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final banners = widget.banners ?? [];

    if (banners.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: banners.length,
          options: CarouselOptions(
            height: 380,
            viewportFraction: 1.0,
            autoPlay: banners.length > 1,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = banners[index];
            final title = banner.title;
            final imageUrl = banner.imageUrl;
            final linkType = banner.linkType;

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: const Color(0xFF1E382B).withValues(alpha: 0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const ShimmerImageLoading(),
                      errorWidget: (context, url, error) {
                        return Container(
                          color: const Color(0xFF1E382B),
                          child: const Center(
                            child: Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.white54,
                              size: 48,
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.85),
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.all(AppSpacing.margin),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (linkType != null && linkType.isNotEmpty)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E382B),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                linkType.toUpperCase(),
                                style: AppTypography.labelCaps.copyWith(
                                  color: const Color(0xFF4EBE86),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          const SizedBox(height: AppSpacing.spaceSm),
                          Text(
                            title,
                            style: AppTypography.headlineLg.copyWith(
                              color: Colors.white,
                              height: 1.15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.spaceMd),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () => widget.onExploreTap?.call(banner),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E382B),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Explore Collection',
                                        style: AppTypography.bodySm.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.spaceSm),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (banners.length > 1) ...[
                                const Spacer(),
                                Row(
                                  children: List.generate(
                                    banners.length,
                                    (dotIndex) => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      margin: const EdgeInsets.only(left: 4),
                                      width: _currentIndex == dotIndex ? 20 : 6,
                                      height: 4,
                                      decoration: BoxDecoration(
                                        color: _currentIndex == dotIndex
                                            ? const Color(0xFF4EBE86)
                                            : Colors.white38,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
