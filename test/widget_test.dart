import 'package:aura/aura_app.dart';
import 'package:aura/core/databases/cache/cache_helper.dart';
import 'package:aura/core/di/injection_container.dart' as di;
import 'package:aura/core/routing/app_router.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await CacheHelper.init();
    await di.initDependencies();
  });

  tearDown(() async {
    await di.sl.reset();
  });

  testWidgets('AuraApp smoke test builds successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      AuraApp(appRouter: AppRouter()),
    );
    await tester.pump();
    expect(find.byType(AuraApp), findsOneWidget);
  });
}
