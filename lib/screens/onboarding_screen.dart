import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import '../services/etopay_sdk_bridge.dart';
import 'package:flutter/foundation.dart';
// Add these imports for web support
// ignore: avoid_web_libraries_in_flutter
import 'package:web/web.dart' as web;
import 'package:go_router/go_router.dart';
import 'package:eto_pay/env.example.dart'; // Add this import for config
import 'package:http/http.dart' as http;

const String authDomain =
    'https://auth-etopay-demo.etospheres.com/realms/6f2f6c69393f40369647f9fed8dd65ee';
const String clientID = 'builtin-client';
const String redirectURI = kIsWeb
    ? 'http://localhost:3000' // or your deployed web URL
    : 'com.etospheres.etopay:/oauthredirect';
const String authorizationEndpoint = '$authDomain/protocol/openid-connect/auth';
const String tokenEndpoint = '$authDomain/protocol/openid-connect/token';

final FlutterAppAuth appAuth = FlutterAppAuth();
final FlutterSecureStorage secureStorage = FlutterSecureStorage();

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  String? _error;
  String? _username;
  bool _sdkReady = false;

  void _navigateToTermsAndConditions() {
    if (!mounted) return;
    context.go('/terms');
  }

  @override
  void initState() {
    super.initState();
    _initializeSdk();
    if (kIsWeb) {
      final uri = Uri.parse(web.window.location.href);
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
        Uri.parse(tokenEndpoint),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'authorization_code',
          'code': code,
          'redirect_uri': redirectURI,
          'client_id': clientID,
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
        _username = username;
      });
      // Call ETOPay SDK bridge for user creation and initialization
      if (_username != null) {
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
      final uri = Uri.parse(web.window.location.href);
      final params = Map<String, String>.from(uri.queryParameters);
      params.remove('code');
      final newUri = uri.replace(queryParameters: params);
      web.window.history.replaceState(null, '', newUri.toString());
    }
  }

  Future<void> _authenticate() async {
    setState(() {
      _error = null;
      _username = null;
    });

    if (kIsWeb) {
      final url =
          '$authorizationEndpoint?client_id=$clientID&redirect_uri=$redirectURI&response_type=code&scope=openid%20profile%20email';
      web.window.location.href = url;
      return;
    }

    try {
      final AuthorizationTokenResponse? result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clientID,
          redirectURI,
          issuer: authDomain,
          scopes: ['openid', 'profile', 'email'],
          serviceConfiguration: AuthorizationServiceConfiguration(
            authorizationEndpoint: authorizationEndpoint,
            tokenEndpoint: tokenEndpoint,
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
        _username = username;
      });
      // Call ETOPay SDK bridge for user creation and initialization
      if (result.accessToken != null) {
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
