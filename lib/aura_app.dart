import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/routing/app_router.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_theme.dart';
import 'package:aura/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:aura/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:aura/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuraApp extends StatelessWidget {
  final String initialRoute;
  final AppRouter appRouter;

  const AuraApp({
    super.key,
    this.initialRoute = Routes.splashView,
    required this.appRouter,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CartCubit>.value(value: di.sl<CartCubit>()),
        BlocProvider<WishlistCubit>.value(value: di.sl<WishlistCubit>()),
        BlocProvider<ProfileCubit>.value(value: di.sl<ProfileCubit>()),
      ],
      child: MaterialApp(
        title: 'Aura',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: initialRoute,
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }
}
