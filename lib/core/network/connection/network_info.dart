import 'dart:io';
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
      final hasNet = await connectionChecker.hasConnection;
      if (hasNet) return true;
    } catch (_) {}

    // Fallback: Check if local backend is reachable (via adb reverse / localhost:8000)
    try {
      final socket = await Socket.connect(
        '127.0.0.1',
        8000,
        timeout: const Duration(seconds: 2),
      );
      socket.destroy();
      return true;
    } catch (_) {
      return false;
    }
  }
}