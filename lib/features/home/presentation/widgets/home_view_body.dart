import 'package:aura/core/theme/app_typography.dart';
import 'package:aura/core/widgets/shimmer/home_shimmer_skeleton.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/home/presentation/cubit/home_state.dart';
import 'package:aura/features/home/presentation/widgets/home_feed_section.dart';
import 'package:aura/features/home/presentation/widgets/home_header_section.dart';
import 'package:aura/features/home/presentation/widgets/home_server_error_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Pure declarative layout assembling the Home screen with 100% Cubit reactivity.
class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();
          final feed = state is HomeSuccessState ? state.homeFeed : null;

          return RefreshIndicator(
            color: const Color(0xFF1E382B),
            onRefresh: () => cubit.fetchHomeFeed(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.margin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.spaceSm),
                  const HomeHeaderSection(),
                  const SizedBox(height: AppSpacing.spaceMd),
                  if (state is HomeLoadingState && feed == null)
                    const HomeShimmerSkeleton()
                  else ...[
                    if (state is HomeErrorState && feed == null) ...[
                      HomeServerErrorBanner(
                        onRetry: () => cubit.fetchHomeFeed(),
                      ),
                      const SizedBox(height: AppSpacing.spaceMd),
                    ],
                    if (state is HomeSuccessState)
                      HomeFeedSection(state: state),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
