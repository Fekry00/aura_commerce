import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/utils/category_ui_helper.dart';
import 'package:flutter/material.dart';

class CategoryDetailsSliverAppBar extends StatelessWidget {
  const CategoryDetailsSliverAppBar({
    super.key,
    required this.category,
    required this.onBackTap,
    required this.onShareTap,
  });

  final CategoryEntity category;
  final VoidCallback onBackTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    final coverImage = CategoryUiHelper.getCategoryCoverImage(category);

    return SliverAppBar(
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
            onPressed: onBackTap,
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
              onPressed: onShareTap,
            ),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          category.name,
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
            if (coverImage != null && coverImage.isNotEmpty)
              Image.network(
                coverImage,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildFallbackBg(category),
              )
            else
              _buildFallbackBg(category),
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
    );
  }

  Widget _buildFallbackBg(CategoryEntity cat) {
    return Container(
      color: const Color(0xFF0B3B2C),
      child: Center(
        child: Icon(
          CategoryUiHelper.getCategoryIcon(
            cat.name,
            cat.slug,
          ),
          color: Colors.white30,
          size: 72,
        ),
      ),
    );
  }
}
