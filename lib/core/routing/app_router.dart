import 'package:aura/core/di/injection_container.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/views/create_account_view.dart';
import 'package:aura/features/auth/presentation/views/sign_in_view.dart';
import 'package:aura/features/auth/presentation/views/verify_reset_password_view.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/home/presentation/views/home_view.dart';
import 'package:aura/features/product/presentation/views/product_details_view.dart';
import 'package:aura/features/product/presentation/views/product_reviews_view.dart';
import 'package:aura/features/checkout/presentation/views/checkout_view.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/profile/presentation/views/edit_profile_view.dart';
import 'package:aura/features/orders/presentation/views/order_success_receipt_view.dart';
import 'package:aura/features/orders/presentation/views/order_tracking_details_view.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.homeView:
        final initialIndex = (arguments is int) ? arguments : 0;
        return _buildPageRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => sl<HomeCubit>()..fetchHomeFeed(),
              ),
              BlocProvider(
                create: (context) => sl<WishlistCubit>()..fetchWishlist(),
              ),
              BlocProvider(
                create: (context) => sl<CartCubit>()..fetchCart(),
              ),
              BlocProvider(
                create: (context) => sl<ProfileCubit>()..fetchProfile(),
              ),
            ],
            child: HomeView(initialIndex: initialIndex),
          ),
          settings: settings,
        );

      case Routes.productDetailsView:
        final product = arguments as Map<String, dynamic>;
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<CartCubit>(),
            child: ProductDetailsView(product: product),
          ),
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
      case Routes.createAccountView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const CreateAccountView(),
          ),
          settings: settings,
        );
      case Routes.signInView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const SignInView(),
          ),
          settings: settings,
        );
      case Routes.profileView:
        return _buildPageRoute(
          const HomeView(initialIndex: 3),
          settings: settings,
        );
      case Routes.editProfileView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<ProfileCubit>()..fetchProfile(),
            child: const EditProfileView(),
          ),
          settings: settings,
        );
      case Routes.cartView:
        return _buildPageRoute(
          const HomeView(initialIndex: 2),
          settings: settings,
        );
      case Routes.checkoutView:
        return _buildPageRoute(const CheckoutView(), settings: settings);

      case Routes.orderSuccessReceiptView:
        return _buildPageRoute(
          const OrderSuccessReceiptView(),
          settings: settings,
        );

      case Routes.orderTrackingDetailsView:
        return _buildPageRoute(
          const OrderTrackingDetailsView(),
          settings: settings,
        );

      case Routes.verifyResetPasswordView:
        return _buildPageRoute(
          const VerifyResetPasswordView(),
          settings: settings,
        );

      case Routes.wishlistView:
        return _buildPageRoute(
          const HomeView(initialIndex: 1),
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
