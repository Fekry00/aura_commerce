import 'package:aura/core/di/injection_container.dart';
import 'package:aura/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:aura/features/auth/presentation/views/create_account_view.dart';
import 'package:aura/features/auth/presentation/views/forgot_password_view.dart';
import 'package:aura/features/auth/presentation/views/reset_password_view.dart';
import 'package:aura/features/auth/presentation/views/sign_in_view.dart';
import 'package:aura/features/auth/presentation/views/verify_otp_view.dart';
import 'package:aura/features/auth/presentation/views/verify_reset_password_view.dart';
import 'package:aura/features/home/presentation/cubit/home_cubit.dart';
import 'package:aura/features/home/presentation/views/home_view.dart';
import 'package:aura/features/product/data/models/sub_models/product_item_model.dart';
import 'package:aura/features/product/domain/entities/sub_entities/product_item_entity.dart';
import 'package:aura/features/product/presentation/views/product_details_view.dart';
import 'package:aura/features/product/presentation/views/product_reviews_view.dart';
import 'package:aura/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:aura/features/checkout/presentation/views/checkout_view.dart';
import 'package:aura/features/orders/domain/entities/order_entity.dart';
import 'package:aura/features/orders/domain/usecases/get_order_tracking_usecase.dart';
import 'package:aura/features/orders/presentation/cubit/orders_cubit.dart';
import 'package:aura/features/orders/presentation/views/orders_view.dart';
import 'package:aura/features/orders/presentation/views/order_success_receipt_view.dart';
import 'package:aura/features/orders/presentation/views/order_tracking_details_view.dart';
import 'package:aura/features/profile/presentation/views/edit_profile_view.dart';
import 'package:aura/features/category/domain/entities/category_entity.dart';
import 'package:aura/features/category/presentation/cubit/category_cubit.dart';
import 'package:aura/features/category/presentation/views/categories_view.dart';
import 'package:aura/features/category/presentation/views/category_details_view.dart';
import 'package:aura/features/product/presentation/cubit/product_cubit.dart';
import 'package:aura/features/product/presentation/cubit/review_cubit.dart';
import 'package:aura/features/splash/presentation/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.splashView:
        return _buildPageRoute(
          const SplashView(),
          settings: settings,
        );

      case Routes.homeView:
        final initialIndex = (arguments is int) ? arguments : 0;
        return _buildHomeRoute(initialIndex, settings);

      case Routes.productDetailsView:
        final ProductItemEntity product = (arguments is ProductItemEntity)
            ? arguments
            : (arguments is Map<String, dynamic>
                ? ProductItemModel.fromJson(arguments)
                : const ProductItemEntity(
                    id: 1,
                    name: 'Product Details',
                    minPrice: 0,
                  ));
        return _buildPageRoute(
          BlocProvider(
            create: (context) {
              final cubit = sl<ProductCubit>();
              if (product.id > 0) {
                cubit.fetchProductDetails(product.id.toString());
              }
              return cubit;
            },
            child: ProductDetailsView(product: product),
          ),
          settings: settings,
        );
      case Routes.productReviewsView:
        final ProductItemEntity product = (arguments is ProductItemEntity)
            ? arguments
            : (arguments is Map<String, dynamic>
                ? ProductItemModel.fromJson(arguments)
                : const ProductItemEntity(
                    id: 1,
                    name: 'Product Reviews',
                    minPrice: 0,
                  ));
        return _buildPageRoute(
          BlocProvider(
            create: (context) =>
                sl<ReviewCubit>()..fetchReviews(product.id.toString()),
            child: ProductReviewsView(product: product),
          ),
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
        final initialEmail = (arguments is String) ? arguments : null;
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: SignInView(initialEmail: initialEmail),
          ),
          settings: settings,
        );
      case Routes.profileView:
        return _buildHomeRoute(3, settings);
      case Routes.editProfileView:
        return _buildPageRoute(
          const EditProfileView(),
          settings: settings,
        );
      case Routes.cartView:
        return _buildHomeRoute(2, settings);
      case Routes.checkoutView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<CheckoutCubit>(),
            child: const CheckoutView(),
          ),
          settings: settings,
        );

      case Routes.orderSuccessReceiptView:
        final order = arguments is OrderEntity ? arguments : null;
        return _buildPageRoute(
          OrderSuccessReceiptView(order: order),
          settings: settings,
        );

      case Routes.ordersView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<OrdersCubit>(),
            child: const OrdersView(),
          ),
          settings: settings,
        );

      case Routes.orderTrackingDetailsView:
        final args = settings.arguments;
        int? orderId;
        OrderEntity? order;
        if (args is int) {
          orderId = args;
        } else if (args is OrderEntity) {
          order = args;
          orderId = args.id;
        }
        return _buildPageRoute(
          OrderTrackingDetailsView(
            orderId: orderId,
            initialOrder: order,
            getOrderTrackingUseCase: sl<GetOrderTrackingUseCase>(),
          ),
          settings: settings,
        );

      case Routes.verifyResetPasswordView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const VerifyResetPasswordView(),
          ),
          settings: settings,
        );

      case Routes.wishlistView:
        return _buildHomeRoute(1, settings);

      case Routes.categoriesView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<CategoryCubit>()..getCategories(),
            child: const CategoriesView(),
          ),
          settings: settings,
        );

      case Routes.categoryDetailsView:
        CategoryEntity category;
        String? initialSubDepartment;
        if (arguments is CategoryEntity) {
          category = arguments;
        } else if (arguments is Map<String, dynamic>) {
          category = arguments['category'] as CategoryEntity;
          initialSubDepartment = arguments['subDepartment'] as String?;
        } else {
          category = const CategoryEntity(
            id: 1,
            name: 'Electronics',
            slug: 'electronics',
          );
        }
        return _buildPageRoute(
          MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => sl<CategoryCubit>()),
              BlocProvider(
                create: (context) => sl<ProductCubit>()
                  ..fetchProducts(categoryId: category.id),
              ),
            ],
            child: CategoryDetailsView(
              category: category,
              initialSubDepartment: initialSubDepartment,
            ),
          ),
          settings: settings,
        );

      // ── Password Reset Flow ──────────────────────────────────────────
      case Routes.forgotPasswordView:
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: const ForgotPasswordView(),
          ),
          settings: settings,
        );

      case Routes.verifyOtpView:
        final otpArgs = arguments as Map<String, dynamic>? ?? {};
        final email = otpArgs['email'] as String? ?? '';
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: VerifyOtpView(email: email),
          ),
          settings: settings,
        );

      case Routes.resetPasswordView:
        final resetArgs = arguments as Map<String, dynamic>? ?? {};
        final otp = resetArgs['otp'] as String? ?? '';
        return _buildPageRoute(
          BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: ResetPasswordView(otp: otp),
          ),
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

  PageRouteBuilder _buildHomeRoute(int initialIndex, RouteSettings settings) {
    return _buildPageRoute(
      BlocProvider(
        create: (context) => sl<HomeCubit>()..fetchHomeFeed(),
        child: HomeView(initialIndex: initialIndex),
      ),
      settings: settings,
    );
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
