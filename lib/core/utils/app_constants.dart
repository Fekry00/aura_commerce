class AppConstants {
  static const String appName = 'Aura';
  static const String currency = '\$';

  static const Duration connectTimeout = Duration(seconds: 20);
  static const Duration receiveTimeout = Duration(seconds: 20);

  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration splashDelay = Duration(milliseconds: 2000);

  static const int defaultPageSize = 10;

  static final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
  );
  static final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,14}$');
}
