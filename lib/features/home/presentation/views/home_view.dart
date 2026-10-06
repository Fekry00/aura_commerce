import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/custom_bottom_nav_bar.dart';
import 'package:aura/features/home/presentation/widgets/atelier_archive_banner.dart';
import 'package:aura/features/home/presentation/widgets/curated_highlights_header.dart';
import 'package:aura/features/home/presentation/widgets/home_app_bar.dart';
import 'package:aura/features/home/presentation/widgets/home_categories_section.dart';
import 'package:aura/features/home/presentation/widgets/home_curated_drop_timer.dart';
import 'package:aura/features/home/presentation/widgets/home_hero_banner.dart';
import 'package:aura/features/home/presentation/widgets/home_products_grid.dart';
import 'package:aura/features/home/presentation/widgets/home_search_bar.dart';
import 'package:flutter/material.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentNavIndex,
        onItemTapped: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
      body: SafeArea(
        bottom: false,
        child: _currentNavIndex == 0
            ? const SingleChildScrollView(
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
              )
            : Center(
                child: Text(
                  'Tab ${_currentNavIndex + 1} Screen',
                  style: const TextStyle(fontSize: 18, color: AppColors.onSurface),
                ),
              ),
      ),
    );
  }
}