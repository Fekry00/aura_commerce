import 'package:aura/features/home/presentation/views/home_view.dart';
import 'package:aura/features/product/presentation/views/product_details_view.dart';
import 'package:aura/features/product/presentation/views/product_reviews_view.dart';
import 'package:flutter/material.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeView:
        return _buildPageRoute(const HomeView(), settings: settings);

      case Routes.productDetailsView:
        final product = arguments as Map<String, dynamic>;
        return _buildPageRoute(
          ProductDetailsView(product: product),
          settings: settings,
        );
      case Routes.productReviewsView:
        final product = (arguments is Map<String, dynamic>)
            ? arguments
            : <String, dynamic>{};
        return _buildPageRoute(
          ProductReviewsView(product: product),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  PageRouteBuilder _buildPageRoute(
    Widget page, {
    required RouteSettings settings,
  }) {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: const Duration(milliseconds: 320),
      reverseTransitionDuration: const Duration(milliseconds: 260),
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );

        return FadeTransition(
          opacity: curvedAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 0.05),
              end: Offset.zero,
            ).animate(curvedAnimation),
            child: child,
          ),
        );
      },
    );
  }
}
