import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../services/etopay_sdk_bridge.dart';
import 'package:flutter/foundation.dart';
// Add these imports for web support
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:http/http.dart' as http;
import 'package:eto_pay/screens/choose_network_screen.dart';
import 'package:eto_pay/widgets/onboarding.dart';
import 'package:go_router/go_router.dart';
import 'package:eto_pay/screens/terms_and_conditions_screen.dart';
import 'package:eto_pay/env.dart'; // Add this import for config

const String AUTH_DOMAIN =
    'https://auth-etopay-demo.etospheres.com/realms/6f2f6c69393f40369647f9fed8dd65ee';
const String CLIENT_ID = 'builtin-client';
const String REDIRECT_URI = kIsWeb
    ? 'http://localhost:59636' // or your deployed web URL
    : 'com.etospheres.etopay:/oauthredirect';
const String AUTHORIZATION_ENDPOINT =
    '$AUTH_DOMAIN/protocol/openid-connect/auth';
const String TOKEN_ENDPOINT = '$AUTH_DOMAIN/protocol/openid-connect/token';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? _mnemonic;
  String? _error;
  String? _username;
  String? _accessToken;
  bool _sdkReady = false;

  void _navigateToChooseNetwork() {
    if (!mounted) return;
    context.go('/choose-network');
  }

  void _navigateToTermsAndConditions() {
    if (!mounted) return;
    context.go('/terms');
  }

  @override
  void initState() {
    super.initState();
    _initializeSdk();
    if (kIsWeb) {
      final uri = Uri.parse(html.window.location.href);
      final code = uri.queryParameters['code'];
      if (code != null) {
        _exchangeCodeForToken(code);
      }
    }
  }

  Future<void> _initializeSdk() async {
    try {
      await EtopaySdkBridge.initWasm();
      await EtopaySdkBridge.setupSdk(
          envConfigJson); // envConfigJson from env.dart
      setState(() {
        _sdkReady = true;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to initialize ETOPay SDK: $e';
      });
    }
  }

  Future<void> _exchangeCodeForToken(String code) async {
    try {
      final response = await http.post(
        Uri.parse(TOKEN_ENDPOINT),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': REDIRECT_URI,
          'client_id': CLIENT_ID,
        },
      );
      if (response.statusCode != 200) {
        _removeCodeFromUrl();
        throw Exception(
            'Failed to get token: HTTP ${response.statusCode}\n${response.body}');
      }
      final Map<String, dynamic> tokenData = json.decode(response.body);
      final accessToken = tokenData['access_token'] as String?;
      final idToken = tokenData['id_token'] as String?;
      if (accessToken == null || idToken == null) {
        _removeCodeFromUrl();
        throw Exception('No access token or id token in response: $tokenData');
      }
      final username = _parseUsernameFromIdToken(idToken);
      setState(() {
        _accessToken = accessToken;
        _username = username;
      });
      // Call ETOPay SDK bridge for user creation and initialization
      if (username != null && accessToken != null) {
        await EtopaySdkBridge.createNewUser(username);
        await EtopaySdkBridge.initializeUser(username);
      }
      _removeCodeFromUrl();
      _navigateToTermsAndConditions();
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  void _removeCodeFromUrl() {
    if (kIsWeb) {
      final uri = Uri.parse(html.window.location.href);
      final params = Map<String, String>.from(uri.queryParameters);
      params.remove('code');
      final newUri = uri.replace(queryParameters: params);
      html.window.history.replaceState(null, '', newUri.toString());
    }
  }

  Future<void> _authenticate() async {
    setState(() {
      _error = null;
      _accessToken = null;
      _username = null;
    });

    if (kIsWeb) {
      final url =
          '$AUTHORIZATION_ENDPOINT?client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI&response_type=code&scope=openid%20profile%20email';
      html.window.location.href = url;
      return;
    }

    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          CLIENT_ID,
          REDIRECT_URI,
          issuer: AUTH_DOMAIN,
          scopes: ['openid', 'profile', 'email'],
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: AUTHORIZATION_ENDPOINT,
            tokenEndpoint: TOKEN_ENDPOINT,
          ),
        ),
      );

      if (result == null || result.accessToken == null) {
        throw Exception('Failed to authenticate or retrieve access token');
      }

      // Parse the ID token to get the username (sub or preferred_username)
      final idToken = result.idToken;
      final username = _parseUsernameFromIdToken(idToken);

      setState(() {
        _accessToken = result.accessToken;
        _username = username;
      });
      // Call ETOPay SDK bridge for user creation and initialization
      if (username != null && result.accessToken != null) {
        await EtopaySdkBridge.createNewUser(username);
        await EtopaySdkBridge.initializeUser(username);
      }
      _navigateToTermsAndConditions();
      // Optionally store tokens securely
      await secureStorage.write(key: 'access_token', value: result.accessToken);
      await secureStorage.write(key: 'id_token', value: result.idToken);
    } catch (e) {
      setState(() {
        _error = e.toString();
      });
    }
  }

  String _parseUsernameFromIdToken(String? idToken) {
    if (idToken == null) return '';
    final parts = idToken.split('.');
    if (parts.length != 3) return '';
    final decoded =
        String.fromCharCodes(base64Url.decode(base64Url.normalize(parts[1])));
    final username = RegExp(r'"preferred_username"\s*:\s*"([^"]+)"')
        .firstMatch(decoded)
        ?.group(1);
    return username ?? '';
  }

  @override
  Widget build(BuildContext context) {
    if (!_sdkReady) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    // If logged in, immediately navigate to terms screen
    if (_username != null) {
      Future.microtask(() {
        if (mounted) _navigateToTermsAndConditions();
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ElevatedButton(
              onPressed: _authenticate,
              child: const Text('Login with ETOPay'),
            ),
            if (_mnemonic != null) ...[
              const SizedBox(height: 16),
              const Text('Mnemonic:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_mnemonic!),
            ],
            if (_error != null) ...[
              const SizedBox(height: 16),
              Text('Error: $_error', style: const TextStyle(color: Colors.red)),
            ],
          ],
        ),
      ),
    );
  }
}
