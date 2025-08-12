import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> isBiometricAvailable(LocalAuthentication auth) async {
    return await auth.canCheckBiometrics && await auth.isDeviceSupported();
  }

  static Future<bool> authenticate(LocalAuthentication auth) async {
    try {
      return await auth.authenticate(
        localizedReason: 'Unlock with biometrics',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (_) {
      return false;
    }
  }
}
