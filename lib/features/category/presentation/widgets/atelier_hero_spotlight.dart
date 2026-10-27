import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/utils/category_ui_helper.dart';
import 'package:flutter/material.dart';

class AtelierHeroSpotlight extends StatefulWidget {
  final CategoryEntity? category;
  final VoidCallback? onExploreTap;

  const AtelierHeroSpotlight({
    super.key,
    this.category,
    this.onExploreTap,
  });

  @override
  State<AtelierHeroSpotlight> createState() => _AtelierHeroSpotlightState();
}

class _AtelierHeroSpotlightState extends State<AtelierHeroSpotlight>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final info = CategoryUiHelper.getCategorySpotlightInfo(widget.category);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 350),
      child: Container(
        key: ValueKey(info.title),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF0B3B2C),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF002419).withValues(alpha: 0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              // Background Ambient Texture
              if (info.image != null && info.image!.isNotEmpty)
                Positioned.fill(
                  child: Opacity(
                    opacity: 0.38,
                    child: Image.network(
                      info.image!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(),
                    ),
                  ),
                ),

              // Gradient Overlay
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        const Color(0xFF002419),
                        const Color(0xFF0B3B2C).withValues(alpha: 0.85),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row (Responsive to avoid overflow on narrow screens)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  const Color(0xFF6CF8BB).withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFF6CF8BB)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.stars,
                                  color: Color(0xFF6FFBBE),
                                  size: 13,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  child: Text(
                                    info.tag,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.labelSm.copyWith(
                                      color: const Color(0xFF6FFBBE),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          info.season,
                          style: AppTypography.labelSm.copyWith(
                            color: const Color(0xFFA2D1BB),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Title
                    Text(
                      info.title,
                      style: AppTypography.headlineSm.copyWith(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Subtitle
                    Text(
                      info.subtitle,
                      style: AppTypography.bodySm.copyWith(
                        color: const Color(0xFFA2D1BB),
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Bottom Action Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AnimatedBuilder(
                              animation: _pulseController,
                              builder: (context, child) {
                                return Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: const Color(0xFF6FFBBE),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF6FFBBE)
                                            .withValues(
                                                alpha: _pulseController.value),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 8),
                            Text(
                              info.reservedCount,
                              style: AppTypography.labelSm.copyWith(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.onExploreTap != null) {
                              widget.onExploreTap!();
                            } else {
                              final targetCat = info.targetCategory ??
                                  widget.category ??
                                  const CategoryEntity(
                                    id: 1,
                                    name: 'Electronics',
                                    slug: 'electronics',
                                    description: 'Electronic Devices',
                                  );

                              Navigator.pushNamed(
                                context,
                                Routes.categoryDetailsView,
                                arguments: targetCat,
                              );
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF6FFBBE),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF6FFBBE)
                                      .withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore Vault',
                                  style: AppTypography.labelSm.copyWith(
                                    color: const Color(0xFF002113),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward,
                                  color: Color(0xFF002113),
                                  size: 14,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
