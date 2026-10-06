import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeHeroBanner extends StatefulWidget {
  const HomeHeroBanner({super.key});

  @override
  State<HomeHeroBanner> createState() => _HomeHeroBannerState();
}

class _HomeHeroBannerState extends State<HomeHeroBanner> {
  int _currentIndex = 0;

  final List<Map<String, String>> _banners = [
    {
      'tag': 'EXCLUSIVE PREVIEW',
      'title': 'The Architectural\nSilhouette',
      'subtitle':
          'Curated Summer Capsule. Tactile\ntailoring sculpted for effortless modern...',
      'image':
          'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?q=80&w=800',
    },
    {
      'tag': 'NEW ARRIVAL',
      'title': 'Monochrome\nMinimalism',
      'subtitle':
          'Refined aesthetic essentials crafted\nfor timeless daily elegance...',
      'image':
          'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?q=80&w=800',
    },
    {
      'tag': 'LIMITED RUN',
      'title': 'Urban Tailored\nHorology',
      'subtitle':
          'Subtle textures paired with brutalist\nindustrial design integrity...',
      'image':
          'https://images.unsplash.com/photo-1441986300917-64674bd600d8?q=80&w=800',
    },
    {
      'tag': 'AUTUMN EDIT',
      'title': 'Pure Form\n& Substance',
      'subtitle':
          'Monolithic silhouettes designed\nwith pristine craftsmanship...',
      'image':
          'https://images.unsplash.com/photo-1469334031218-e382a71b716b?q=80&w=800',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          options: CarouselOptions(
            height: 380,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          itemBuilder: (context, index, realIndex) {
            final item = _banners[index];
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                image: DecorationImage(
                  image: NetworkImage(item['image']!),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(AppSpacing.margin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                        item['tag']!,
                        style: AppTypography.labelCaps.copyWith(
                          color: const Color(0xFF4EBE86),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceSm),
                    Text(
                      item['title']!,
                      style: AppTypography.headlineLg.copyWith(
                        color: Colors.white,
                        height: 1.15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceXs + 2),
                    Text(
                      item['subtitle']!,
                      style: AppTypography.bodySm.copyWith(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.spaceMd),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            showCustomSnackBar(
                              context,
                              message: 'Exploring ${item['tag']} Collection...',
                              type: SnackBarType.info,
                            );
                          },
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
                        const Spacer(),
                        Row(
                          children: List.generate(
                            _banners.length,
                            (dotIndex) => AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
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
