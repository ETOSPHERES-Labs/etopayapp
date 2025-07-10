// ignore_for_file: deprecated_member_use, avoid_web_libraries_in_flutter
import 'etopay_sdk_bridge_web.dart';
import 'dart:js_util';

class EtopaySdkBridge {
  static ETOPaySdk? _sdk;

  static Future<void> initWasm() async {
    await promiseToFuture(etopayInit());
  }

  static Future<void> setupSdk(String configJson) async {
    _sdk = ETOPaySdk();
    _sdk!.setConfig(configJson);
  }

  static Future<void> createNewUser(String username) async {
    await promiseToFuture(_sdk!.createNewUser(username));
  }

  static Future<void> initializeUser(String username) async {
    await promiseToFuture(_sdk!.initializeUser(username));
  }

  static Future<void> refreshAccessToken(String token) async {
    await promiseToFuture(_sdk!.refreshAccessToken(token));
  }

  static Future<List<dynamic>> getNetworks() async {
    return await promiseToFuture(_sdk!.getNetworks());
  }

  static Future<void> setNetwork(String networkKey) async {
    await promiseToFuture(_sdk!.setNetwork(networkKey));
  }
}
