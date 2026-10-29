import 'dart:async';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/utils/app_constants.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/splash/presentation/widgets/splash_gold_particles_painter.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:aura/core/theme/app_typography.dart';
import 'package:flutter/material.dart';

/// Interactive Luxury Animated Splash View in Light Mode
/// Matching the Aura Atelier & Concierge visual identity.
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {
  late final AnimationController _introController;
  late final AnimationController _ambientController;
  late final AnimationController _shimmerController;

  late final Animation<double> _logoFadeAnimation;
  late final Animation<double> _logoScaleAnimation;
  late final Animation<double> _textFadeAnimation;
  late final Animation<Offset> _textSlideAnimation;

  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // 1. Entrance animation (1.2 seconds with Curve.easeOutCubic)
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // 2. Continuous ambient floating stardust rotation & pulse
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    // 3. Golden shimmer sweep moving over the logo
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    // Logo animations: 0 to 1 fade, 0.92 to 1.0 scale
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutCubic,
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.92, end: 1.0).animate(
      CurvedAnimation(
        parent: _introController,
        curve: Curves.easeOutCubic,
      ),
    );

    // Staggered typography animations (revealed after logo establishes)
    _textFadeAnimation = CurvedAnimation(
      parent: _introController,
      curve: const Interval(0.40, 1.0, curve: Curves.easeOutCubic),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.22),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _introController,
        curve: const Interval(0.40, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    _startSplashSequence();
  }

  void _startSplashSequence() {
    _introController.forward();
    _navigationTimer = Timer(AppConstants.splashDelay, () {
      if (!mounted) return;
      _navigateToNextScreen();
    });
  }

  void _navigateToNextScreen() {
    final token = CacheHelper.getDataString(key: ApiKey.token);
    final hasValidToken = token != null && token.isNotEmpty;
    final targetRoute = hasValidToken ? Routes.homeView : Routes.signInView;

    if (hasValidToken) {
      di.sl<CartCubit>().fetchCart();
      di.sl<WishlistCubit>().fetchWishlist();
      di.sl<ProfileCubit>().fetchProfile();
    }

    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(targetRoute);
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    _introController.dispose();
    _ambientController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0.0, -0.08),
            radius: 0.95,
            colors: [
              Color(0xFFFDFBF7), // Pearlescent light center
              Color(0xFFF2EFE9), // Warm ivory edges
            ],
            stops: [0.35, 1.0],
          ),
        ),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // 1. Subtle Gold Dust Ring & Floating Particles
              Positioned(
                top: screenSize.height * 0.24,
                child: AnimatedBuilder(
                  animation: _ambientController,
                  builder: (context, _) {
                    return CustomPaint(
                      size: const Size(300, 300),
                      painter: SplashGoldParticlesPainter(
                        animationValue: _ambientController.value,
                      ),
                    );
                  },
                ),
              ),

              // 2. Central Logo with Shimmer Sweep, Fade & Scale Transitions
              Positioned(
                top: screenSize.height * 0.24,
                child: FadeTransition(
                  opacity: _logoFadeAnimation,
                  child: ScaleTransition(
                    scale: _logoScaleAnimation,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: Center(
                        child: AnimatedBuilder(
                          animation: _shimmerController,
                          builder: (context, child) {
                            final shimmerVal = _shimmerController.value;
                            return ShaderMask(
                              blendMode: BlendMode.srcATop,
                              shaderCallback: (bounds) {
                                return LinearGradient(
                                  begin: Alignment(
                                    -2.5 + shimmerVal * 5.0,
                                    -0.5,
                                  ),
                                  end: Alignment(
                                    -1.0 + shimmerVal * 5.0,
                                    0.5,
                                  ),
                                  colors: const [
                                    Colors.transparent,
                                    Color(0x22FFFFFF),
                                    Color(0x66FFE7B0),
                                    Color(0x99FFF6DF),
                                    Color(0x66FFE7B0),
                                    Color(0x22FFFFFF),
                                    Colors.transparent,
                                  ],
                                  stops: const [
                                    0.0,
                                    0.25,
                                    0.45,
                                    0.50,
                                    0.55,
                                    0.75,
                                    1.0,
                                  ],
                                ).createShader(bounds);
                              },
                              child: child,
                            );
                          },
                          child: Image.asset(
                            'assets/images/aura_logo_transparent.png',
                            width: 220,
                            height: 220,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 3. Staggered Native Brand Typography
              Positioned(
                top: screenSize.height * 0.60,
                child: FadeTransition(
                  opacity: _textFadeAnimation,
                  child: SlideTransition(
                    position: _textSlideAnimation,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'A U R A',
                          style: AppTypography.brandSplashTitle,
                        ),
                        const SizedBox(height: AppSpacing.spaceSm),
                        Text(
                          'ATELIER & CONCIERGE',
                          style: AppTypography.brandSplashSubtitle,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
