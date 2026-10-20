import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    try {
      final hasConnection = await connectionChecker.hasConnection;
      if (hasConnection) return true;
    } catch (_) {}
    // Fallback to true to let Dio attempt local network/localhost connections
    return true;
  }
}