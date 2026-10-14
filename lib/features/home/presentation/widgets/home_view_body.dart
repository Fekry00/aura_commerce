import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';
import 'atelier_archive_banner.dart';
import 'curated_highlights_header.dart';
import 'home_app_bar.dart';
import 'home_categories_section.dart';
import 'home_curated_drop_timer.dart';
import 'home_hero_banner.dart';
import 'home_products_grid.dart';
import 'home_search_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSpacing.spaceSm),
            HomeAppBar(),
            SizedBox(height: AppSpacing.spaceMd),
            HomeSearchBar(),
            SizedBox(height: AppSpacing.spaceMd),
            HomeHeroBanner(),
            SizedBox(height: AppSpacing.spaceSm),
            HomeCuratedDropTimer(),
            SizedBox(height: AppSpacing.spaceLg),
            HomeCategoriesSection(),
            SizedBox(height: AppSpacing.spaceLg),
            CuratedHighlightsHeader(),
            SizedBox(height: AppSpacing.spaceMd),
            HomeProductsGrid(),
            SizedBox(height: AppSpacing.spaceMd),
            AtelierArchiveBanner(),
            SizedBox(height: AppSpacing.spaceXl * 2),
          ],
        ),
      ),
    );
  }
}
