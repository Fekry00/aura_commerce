import 'package:aura/core/routing/app_router.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'core/databases/cache/cache_helper.dart';
import 'core/di/injection_container.dart' as di;
import 'core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  await di.initDependencies();

  runApp(const AuraApp());
}

class AuraApp extends StatelessWidget {
  const AuraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aura',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: Routes.homeView,
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
