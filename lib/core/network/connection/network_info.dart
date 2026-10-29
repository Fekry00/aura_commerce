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
    // 1. Fast check: is local backend directly reachable (via adb reverse / localhost:8000)
    try {
      final socket = await Socket.connect(
        '127.0.0.1',
        8000,
        timeout: const Duration(milliseconds: 500),
      );
      socket.destroy();
      return true;
    } catch (_) {}

    // 2. General internet connection check
    try {
      final hasNet = await connectionChecker.hasConnection;
      if (hasNet) return true;
    } catch (_) {}

    return false;
  }
}