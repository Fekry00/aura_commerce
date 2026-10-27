import 'package:aura/aura_app.dart';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/routing/app_router.dart';
import 'package:aura/core/routing/routes.dart';
import 'package:flutter/material.dart';

export 'aura_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();
  await di.initDependencies();

  final appRouter = AppRouter();

  runApp(
    AuraApp(
      initialRoute: Routes.splashView,
      appRouter: appRouter,
    ),
  );
}
