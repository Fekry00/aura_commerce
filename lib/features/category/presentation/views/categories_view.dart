import 'package:aura/core/routing/main_tab_controller.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_colors.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/utils/functions/custom_snack_bar.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/cubit/category_state.dart';
import 'package:aura/features/category/presentation/widgets/atelier_hero_spotlight.dart';
import 'package:aura/features/category/presentation/widgets/category_card.dart';
import 'package:aura/features/category/presentation/widgets/category_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedPillIndex = 0;
  String _deliverTo = 'New York, 10001';

  final List<String> _quickPills = [
    'All Maisons',
    'Vault Exclusives',
    'Numbered Runs',
    'Atelier Bespoke',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: RefreshIndicator(
          color: const Color(0xFF0B3B2C),
          onRefresh: () async {
            _searchController.clear();
            await context.read<CategoryCubit>().getCategories();
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              // Top Bar with Location, Brand & Profile
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Back Button or Brand Title
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.of(context).maybePop(),
                            child: Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: AppColors.outlineVariant
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 16,
                                color: Color(0xFF002419),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'A U R A',
                            style: AppTypography.headlineSm.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 3,
                              color: const Color(0xFF002419),
                            ),
                          ),
                        ],
                      ),

                      // Deliver to pill
                      GestureDetector(
                        onTap: () => _showAddressSheet(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceContainerHigh
                                .withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: AppColors.secondary,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Deliver to: $_deliverTo',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurface,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const Icon(
                                Icons.expand_more,
                                size: 14,
                                color: AppColors.outline,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Notification & Profile
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => _showNotificationsSheet(context),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.notifications_outlined,
                                    size: 20,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.error,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () => MainTabController.switchTab(3),
                            child: const CircleAvatar(
                              radius: 17,
                              backgroundColor: AppColors.surfaceContainerLow,
                              backgroundImage: NetworkImage(
                                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&w=200&q=80',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Title Section: AURA CURATED PORTFOLIOS • 8 Departments
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'AURA CURATED PORTFOLIOS',
                            style: AppTypography.labelSm.copyWith(
                              color: AppColors.secondary,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 6,
                                height: 6,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                '8 Departments',
                                style: AppTypography.labelSm.copyWith(
                                  color: AppColors.onSurfaceVariant,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Atelier Collections',
                        style: AppTypography.headlineSm.copyWith(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF002419),
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Explore handcrafted rarity across 8 master categories & private reserves.',
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Search & Filter Controls
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: _searchController,
                            onChanged: (val) {
                              context
                                  .read<CategoryCubit>()
                                  .searchCategories(val);
                            },
                            decoration: InputDecoration(
                              hintText:
                                  'Search maison, notes, complications...',
                              hintStyle: AppTypography.bodySm.copyWith(
                                color: AppColors.outline,
                                fontSize: 13,
                              ),
                              prefixIcon: const Icon(
                                Icons.search_rounded,
                                color: AppColors.outline,
                                size: 20,
                              ),
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear, size: 16),
                                      onPressed: () {
                                        _searchController.clear();
                                        context
                                            .read<CategoryCubit>()
                                            .searchCategories('');
                                        setState(() {});
                                      },
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 13),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          _showAddressSheet(context);
                        },
                        child: Container(
                          width: 46,
                          height: 46,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 10,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.tune_rounded,
                            size: 20,
                            color: Color(0xFF002419),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Quick Pill Selector
              SliverToBoxAdapter(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                  child: Row(
                    children: List.generate(_quickPills.length, (index) {
                      final isSelected = _selectedPillIndex == index;
                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedPillIndex = index);
                          context
                              .read<CategoryCubit>()
                              .filterByPill(_quickPills[index]);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF0B3B2C)
                                : AppColors.surfaceContainerLow,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: const Color(0xFF0B3B2C)
                                          .withValues(alpha: 0.2),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Text(
                            _quickPills[index],
                            style: AppTypography.labelSm.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.onSurfaceVariant,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),

              // Hero Spotlight Banner
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: AtelierHeroSpotlight(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 20)),

              // Master Categories List Section
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  if (state is GetCategoriesLoadingState) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: CategoryShimmer(),
                      ),
                    );
                  }

                  if (state is GetCategoriesErrorState) {
                    return SliverToBoxAdapter(
                      child: _buildErrorWidget(context, state.errMessage),
                    );
                  }

                  final categories = (state is GetCategoriesSuccessState)
                      ? state.categories
                      : context.read<CategoryCubit>().allCategories;

                  if (categories.isEmpty) {
                    return SliverToBoxAdapter(
                      child: _buildEmptyWidget(context),
                    );
                  }

                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final category = categories[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 14),
                            child: CategoryCard(
                              category: category,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.categoryDetailsView,
                                  arguments: category,
                                );
                              },
                            ),
                          );
                        },
                        childCount: categories.length,
                      ),
                    ),
                  );
                },
              ),

              // Bespoke Concierge Banner (Private Commission)
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: GestureDetector(
                    onTap: () => _showPrivateCommissionSheet(context),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh
                            .withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42,
                            height: 42,
                            decoration: const BoxDecoration(
                              color: Color(0xFF0B3B2C),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.room_service_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Private Commission',
                                  style: AppTypography.headlineSm.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Request unlisted historical pieces or custom gem settings',
                                  style: AppTypography.bodySm.copyWith(
                                    color: AppColors.onSurfaceVariant,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              // Atelier Authenticity Escrow Guarantee
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.verified_user_outlined,
                              size: 15,
                              color: AppColors.secondary,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'ATELIER AUTHENTICITY ESCROW GUARANTEE',
                              style: AppTypography.labelSm.copyWith(
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Every vault acquisition includes dual horological appraisal and cryptographic ledger provenance.',
                        textAlign: TextAlign.center,
                        style: AppTypography.bodySm.copyWith(
                          color: AppColors.onSurfaceVariant,
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddressSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Select Delivery Residence',
                style: AppTypography.headlineSm.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              _buildAddressOption(
                context,
                title: 'New York, 10001',
                subtitle: '740 Park Avenue, Manhattan Suite 14B',
              ),
              const SizedBox(height: 10),
              _buildAddressOption(
                context,
                title: 'Beverly Hills, 90210',
                subtitle: '9641 Sunset Blvd, Beverly Hills Atelier',
              ),
              const SizedBox(height: 10),
              _buildAddressOption(
                context,
                title: 'Paris, 75008',
                subtitle: '22 Place Vendôme, Private Salon',
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressOption(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    final isSelected = _deliverTo == title;
    return GestureDetector(
      onTap: () {
        setState(() => _deliverTo = title);
        Navigator.pop(context);
        showCustomSnackBar(
          context,
          message: 'Delivery residence switched to $title',
          type: SnackBarType.info,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFE9F0EC)
              : AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF006C49)
                : AppColors.outlineVariant.withValues(alpha: 0.4),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on,
              color: isSelected
                  ? const Color(0xFF006C49)
                  : AppColors.onSurfaceVariant,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.labelSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySm.copyWith(
                      color: AppColors.slateBody,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: Color(0xFF006C49),
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  void _showNotificationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Atelier Notifications',
                    style: AppTypography.headlineSm.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Mark all read',
                    style: AppTypography.labelSm.copyWith(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildNotificationItem(
                title: 'Curated Drop 04 is Live',
                subtitle: 'Vault access unlocked for 24 reserved pieces.',
                time: '12m ago',
                icon: Icons.stars,
              ),
              const SizedBox(height: 12),
              _buildNotificationItem(
                title: 'Private Reservation Confirmed',
                subtitle: 'Your consultation with horologist artisan is set.',
                time: '2h ago',
                icon: Icons.verified,
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required String time,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color(0xFF0B3B2C),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.labelSm.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
                Text(
                  subtitle,
                  style: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: AppTypography.labelSm.copyWith(
              color: AppColors.slateBody,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivateCommissionSheet(BuildContext context) {
    final noteController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            24,
            24,
            MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.outlineVariant.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B3B2C),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.room_service_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Private Commission Inquiry',
                          style: AppTypography.headlineSm.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Bespoke Horology & Fine Jewelry Concierge',
                          style: AppTypography.bodySm.copyWith(
                            color: AppColors.slateBody,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: noteController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText:
                      'Describe the historical reference piece or bespoke gem specification...',
                  hintStyle: AppTypography.bodySm.copyWith(
                    color: AppColors.slateBody,
                  ),
                  filled: true,
                  fillColor: AppColors.surfaceContainerLow,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    showCustomSnackBar(
                      context,
                      message:
                          'Commission inquiry submitted to your Private Concierge!',
                      type: SnackBarType.success,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0B3B2C),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text('Submit Commission Request'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 40,
            ),
            const SizedBox(height: 12),
            Text(
              'Failed to load categories',
              style: AppTypography.headlineSm.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.read<CategoryCubit>().getCategories(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0B3B2C),
                foregroundColor: Colors.white,
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            const Icon(
              Icons.search_off_rounded,
              size: 40,
              color: AppColors.outline,
            ),
            const SizedBox(height: 12),
            Text(
              'No matching collections found',
              style: AppTypography.headlineSm.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              'Try adjusting your search or filters.',
              style: AppTypography.bodySm.copyWith(color: AppColors.slateBody),
            ),
          ],
        ),
      ),
    );
  }
}
