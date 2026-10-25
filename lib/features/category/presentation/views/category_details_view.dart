import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/core/widgets/product_card.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/cubit/category_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetailsView extends StatefulWidget {
  const CategoryDetailsView({
    super.key,
    required this.category,
    this.initialSubDepartment,
  });

  final CategoryEntity category;
  final String? initialSubDepartment;

  @override
  State<CategoryDetailsView> createState() => _CategoryDetailsViewState();
}

class _CategoryDetailsViewState extends State<CategoryDetailsView> {
  late CategoryEntity _currentCategory;
  int _selectedSubDepartmentIndex = 0;
  late List<Map<String, dynamic>> _allProducts;
  late List<Map<String, dynamic>> _filteredProducts;

  @override
  void initState() {
    super.initState();
    _currentCategory = widget.category;
    _allProducts = _generateCategoryProducts(_currentCategory);
    _filteredProducts = List.from(_allProducts);

    if (widget.initialSubDepartment != null) {
      final idx = _currentCategory.subDepartments.indexWhere(
        (s) => s.name.toLowerCase() == widget.initialSubDepartment!.toLowerCase(),
      );
      if (idx != -1) {
        _selectedSubDepartmentIndex = idx + 1;
        _filterProductsBySubDepartment(_currentCategory.subDepartments[idx].name);
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoryCubit>().getCategoryDetails(_currentCategory.id);
    });
  }

  void _filterProductsBySubDepartment(String subDepartmentName) {
    setState(() {
      _filteredProducts = _allProducts.where((p) {
        final sub = p['subDepartment'] as String? ?? '';
        return sub.toLowerCase().contains(subDepartmentName.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final subDepartments = _currentCategory.subDepartments;

    return BlocListener<CategoryCubit, CategoryState>(
      listener: (context, state) {
        if (state is GetCategoryDetailsSuccessState) {
          setState(() {
            _currentCategory = state.category;
            if (state.category.subDepartments.isNotEmpty) {
              _allProducts = _generateCategoryProducts(_currentCategory);
              _filteredProducts = List.from(_allProducts);
            }
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Sliver App Bar with Hero Image
            SliverAppBar(
              expandedHeight: 260,
              pinned: true,
              elevation: 0,
              backgroundColor: const Color(0xFF0B3B2C),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: Colors.black.withValues(alpha: 0.4),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 18,
                    ),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.black.withValues(alpha: 0.4),
                    child: IconButton(
                      icon: const Icon(
                        Icons.share_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () {
                        showCustomSnackBar(
                          context,
                          message: 'Shared "${_currentCategory.name}" link!',
                          type: SnackBarType.info,
                        );
                      },
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  _currentCategory.name,
                  style: AppTypography.headlineSm.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    shadows: [
                      Shadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    _currentCategory.image != null &&
                            _currentCategory.image!.isNotEmpty
                        ? Image.network(
                            _currentCategory.image!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => _buildFallbackBg(),
                          )
                        : _buildFallbackBg(),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.25),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.85),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Category Meta Details
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6CF8BB).withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFF00714D),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _currentCategory.creationsCount ??
                                    '${_filteredProducts.length} CREATIONS',
                                style: AppTypography.labelSm.copyWith(
                                  color: const Color(0xFF00714D),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '#${_currentCategory.slug}',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.slateBody,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _currentCategory.description?.isNotEmpty == true
                          ? _currentCategory.description!
                          : 'Explore exquisite luxury creations curated specifically for this private atelier department.',
                      style: AppTypography.bodySm.copyWith(
                        color: AppColors.onSurfaceVariant,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Horizontal Sub-departments Filter Tabs
            if (subDepartments.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        _buildSubDepartmentTab(
                          title: 'All Items',
                          isSelected: _selectedSubDepartmentIndex == 0,
                          onTap: () {
                            setState(() {
                              _selectedSubDepartmentIndex = 0;
                              _filteredProducts = List.from(_allProducts);
                            });
                          },
                        ),
                        ...List.generate(subDepartments.length, (index) {
                          final sub = subDepartments[index];
                          final isSelected =
                              _selectedSubDepartmentIndex == index + 1;
                          return _buildSubDepartmentTab(
                            title: sub.name,
                            isSelected: isSelected,
                            onTap: () {
                              setState(() {
                                _selectedSubDepartmentIndex = index + 1;
                                _filterProductsBySubDepartment(sub.name);
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),

            // Products Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Curated Catalog (${_filteredProducts.length})',
                      style: AppTypography.headlineSm.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF002419),
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.swap_vert_rounded,
                          size: 16,
                          color: AppColors.slateBody,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Sort: Featured',
                          style: AppTypography.labelSm.copyWith(
                            color: AppColors.slateBody,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Products Grid
            if (_filteredProducts.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.inventory_2_outlined,
                          size: 44,
                          color: AppColors.outline,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No pieces currently available',
                          style: AppTypography.headlineSm.copyWith(fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Select another sub-department or view all items.',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.slateBody,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = _filteredProducts[index];
                      return ProductCard(
                        title: item['title'] as String,
                        price: item['price'] as String,
                        imageUrl: item['image'] as String,
                        rating: (item['rating'] as num).toDouble(),
                        reviewsCount: item['reviews'] as int,
                        badgeText: item['badge'] as String?,
                        isFavorite: item['isFavorite'] as bool? ?? false,
                        onFavoriteTap: () {
                          setState(() {
                            item['isFavorite'] = !(item['isFavorite'] as bool? ?? false);
                          });
                          showCustomSnackBar(
                            context,
                            message: item['isFavorite'] == true
                                ? 'Saved to Wishlist'
                                : 'Removed from Wishlist',
                            type: SnackBarType.info,
                          );
                        },
                        onAddToCart: () {
                          showCustomSnackBar(
                            context,
                            message: 'Added ${item['title']} to your Bag!',
                            type: SnackBarType.info,
                          );
                        },
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.productDetailsView,
                            arguments: item,
                          );
                        },
                      );
                    },
                    childCount: _filteredProducts.length,
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 40)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubDepartmentTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF0B3B2C)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : AppColors.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Text(
          title,
          style: AppTypography.labelSm.copyWith(
            color: isSelected ? Colors.white : AppColors.onSurfaceVariant,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildFallbackBg() {
    return Container(
      color: const Color(0xFF0B3B2C),
      child: const Center(
        child: Icon(
          Icons.category_outlined,
          color: Colors.white30,
          size: 72,
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _generateCategoryProducts(CategoryEntity cat) {
    final catName = cat.name.toLowerCase();

    if (catName.contains('parfumerie') || catName.contains('scent')) {
      return [
        {
          'id': 'perf_1',
          'title': 'Oud & Amber Extrait 100ml',
          'price': '\$480',
          'image':
              'https://images.unsplash.com/photo-1592945403244-b3fbafd7f539?auto=format&fit=crop&w=600&q=80',
          'rating': 4.9,
          'reviews': 88,
          'badge': 'VAULT EXCLUSIVE',
          'subDepartment': 'Rare Ouds',
          'isFavorite': false,
        },
        {
          'id': 'perf_2',
          'title': 'Taif Rose Pure Attar',
          'price': '\$650',
          'image':
              'https://images.unsplash.com/photo-1547887537-6158d64c35b3?auto=format&fit=crop&w=600&q=80',
          'rating': 5.0,
          'reviews': 64,
          'badge': 'NUMBERED',
          'subDepartment': 'Pure Attars & Concentrates',
          'isFavorite': true,
        },
        {
          'id': 'perf_3',
          'title': 'Atelier Discovery Coffret (6x10ml)',
          'price': '\$290',
          'image':
              'https://images.unsplash.com/photo-1523293182086-7651a899d37f?auto=format&fit=crop&w=600&q=80',
          'rating': 4.8,
          'reviews': 120,
          'badge': null,
          'subDepartment': 'Discovery Coffrets & Sets',
          'isFavorite': false,
        },
        {
          'id': 'perf_4',
          'title': 'Crystal Flacon Decant 250ml',
          'price': '\$890',
          'image':
              'https://images.unsplash.com/photo-1588405748880-12d1d2a59f75?auto=format&fit=crop&w=600&q=80',
          'rating': 4.9,
          'reviews': 45,
          'badge': 'BESPOKE',
          'subDepartment': 'Bespoke Flacons & Refills',
          'isFavorite': false,
        },
      ];
    } else if (catName.contains('horlogerie') || catName.contains('watch')) {
      return [
        {
          'id': 'horo_1',
          'title': 'Aethel Flying Tourbillon Rose Gold',
          'price': '\$34,500',
          'image':
              'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=600&q=80',
          'rating': 5.0,
          'reviews': 32,
          'badge': '3 LEFT',
          'subDepartment': 'Tourbillons',
          'isFavorite': true,
        },
        {
          'id': 'horo_2',
          'title': 'Openwork Skeleton Chrono 41mm',
          'price': '\$18,900',
          'image':
              'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=600&q=80',
          'rating': 4.9,
          'reviews': 76,
          'badge': 'BESTSELLER',
          'subDepartment': 'Skeleton Chronos',
          'isFavorite': false,
        },
        {
          'id': 'horo_3',
          'title': 'Alligator Mississippi Saddle Strap',
          'price': '\$750',
          'image':
              'https://images.unsplash.com/photo-1614164185128-e4ec99c436d7?auto=format&fit=crop&w=600&q=80',
          'rating': 4.8,
          'reviews': 54,
          'badge': null,
          'subDepartment': 'Bespoke Straps',
          'isFavorite': false,
        },
      ];
    } else if (catName.contains('leather')) {
      return [
        {
          'id': 'leath_1',
          'title': 'Verona Emerald Nappa Clutch',
          'price': '\$890',
          'image':
              'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=600&q=80',
          'rating': 4.8,
          'reviews': 94,
          'badge': 'SIGNATURE',
          'subDepartment': 'Nappa Clutches',
          'isFavorite': true,
        },
        {
          'id': 'leath_2',
          'title': 'Artisan Saddle Briefcase Cognac',
          'price': '\$2,100',
          'image':
              'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=600&q=80',
          'rating': 4.9,
          'reviews': 63,
          'badge': 'HERITAGE',
          'subDepartment': 'Artisan Briefcases',
          'isFavorite': false,
        },
        {
          'id': 'leath_3',
          'title': 'Suede Triple Watch Roll Forest',
          'price': '\$420',
          'image':
              'https://images.unsplash.com/photo-1548036328-c9fa89d128fa?auto=format&fit=crop&w=600&q=80',
          'rating': 5.0,
          'reviews': 112,
          'badge': 'BESTSELLER',
          'subDepartment': 'Watch Rolls',
          'isFavorite': false,
        },
      ];
    } else {
      return [
        {
          'id': 'prod_gen_1',
          'title': '24k Gold Cellular Infusion 50ml',
          'price': '\$380',
          'image':
              'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?auto=format&fit=crop&w=600&q=80',
          'rating': 4.9,
          'reviews': 142,
          'badge': 'EXCLUSIVE',
          'subDepartment': '24k Gold Infusions',
          'isFavorite': true,
        },
        {
          'id': 'prod_gen_2',
          'title': 'Molecular Vitamin C Day Elixir',
          'price': '\$240',
          'image':
              'https://images.unsplash.com/photo-1608248597359-52e043329f79?auto=format&fit=crop&w=600&q=80',
          'rating': 4.8,
          'reviews': 98,
          'badge': 'NEW',
          'subDepartment': 'Vitamin C Elixirs',
          'isFavorite': false,
        },
        {
          'id': 'prod_gen_3',
          'title': 'Alpine Rose Stem Cell Balm',
          'price': '\$310',
          'image':
              'https://images.unsplash.com/photo-1571781926291-c477ebfd024b?auto=format&fit=crop&w=600&q=80',
          'rating': 5.0,
          'reviews': 77,
          'badge': null,
          'subDepartment': 'Stem Cell Balms',
          'isFavorite': false,
        },
      ];
    }
  }
}
