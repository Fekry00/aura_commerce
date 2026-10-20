import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/network/api/end_points.dart';
import 'package:aura/core/routing/app_router.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:aura/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  await di.initDependencies();

  final token = CacheHelper.getDataString(key: ApiKey.token) ??
      CacheHelper.getDataString(key: 'CACHED_AUTH_TOKEN');

  final initialRoute = (token != null && token.isNotEmpty)
      ? Routes.homeView
      : Routes.signInView;

  runApp(AuraApp(initialRoute: initialRoute));
}

class AuraApp extends StatelessWidget {
  final String initialRoute;

  const AuraApp({super.key, this.initialRoute = Routes.homeView});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
