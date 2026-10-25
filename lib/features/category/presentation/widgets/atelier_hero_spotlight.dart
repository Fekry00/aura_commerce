import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class AtelierHeroSpotlight extends StatefulWidget {
  const AtelierHeroSpotlight({super.key});

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
    return Container(
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
            Positioned.fill(
              child: Opacity(
                opacity: 0.35,
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuAIJnSvsNWnhkmwk1byp6eSllZpFaK5QPliHg7xg7Gt-dBdGn-g6aac8dTG9C2M1OuYPjhnMh2sSkSlF5knPcDlPFTCKHgvnqYq4hk-7S7ATsApyP7Tq1BMRqthiZhtsdSXyeiJZq4on1eOEpGu0u-RvNxJeCbHNFzYmsoX63TdO5DukkgIDNX_GxYf4KeTjQHR6otkotgKDuRkNokfN_Jdb4CqVDSX_zCDjwGNVgSU2c8IEgkKE4S5',
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => const SizedBox(),
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
                  // Top Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF6CF8BB).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color:
                                const Color(0xFF6CF8BB).withValues(alpha: 0.3),
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
                            Text(
                              'NEW SEASON CURATION',
                              style: AppTypography.labelSm.copyWith(
                                color: const Color(0xFF6FFBBE),
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'FALL 2025',
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
                    'Maison High Jewelry &\nHorlogerie',
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
                    'Hand-assembled flying tourbillons paired with unheated Colombian emerald solitaire suites.',
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
                            '24 Reserved Pieces',
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
                          Navigator.pushNamed(
                            context,
                            Routes.categoryDetailsView,
                            arguments: const CategoryEntity(
                              id: 2,
                              name: 'High Horlogerie',
                              slug: 'high-horlogerie',
                              description: 'Skeletons, perpetuals & tourbillons',
                              collectionLabel: 'Collection 02',
                              creationsCount: '19 COMPLICATIONS',
                            ),
                          );
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
    );
  }
}
