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

    // if (kIsWeb) {
    //   final url =
    //       '$authorizationEndpoint?client_id=$clientID&redirect_uri=$redirectURI&response_type=code&scope=openid%20profile%20email';
    //   web.window.location.href = url;
    //   return;
    // }

    try {
      // final AuthorizationTokenResponse? result =
      //     await appAuth.authorizeAndExchangeCode(
      //   AuthorizationTokenRequest(
      //     clientID,
      //     redirectURI,
      //     issuer: authDomain,
      //     scopes: ['openid', 'profile', 'email'],
      //     serviceConfiguration: AuthorizationServiceConfiguration(
      //       authorizationEndpoint: authorizationEndpoint,
      //       tokenEndpoint: tokenEndpoint,
      //     ),
      //   ),
      // );
      String accessToken = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJaQ2hvZ0c4TXhmSGlqUTVhVF9QTHQ1ekRtOG9EbW83TElUQ1dXbE1JNzVnIn0.eyJleHAiOjE3NTIyNjYwOTcsImlhdCI6MTc1MjIzMDA5NywianRpIjoiZmM4ZjhiZGItMGM0My00ZDQ4LWJhYzMtOWE1OGUzYmM4N2E0IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLWV0b3BheS1kZW1vLmV0b3NwaGVyZXMuY29tL3JlYWxtcy85YmJkMDIwYjk4YTQ0NzUzOTQ4ZWRmN2FkZGM2YjU1ZSIsImF1ZCI6ImFjY291bnQiLCJzdWIiOiIyNGFhZDRkOC04MWMzLTQzZTAtYmUyNy1hNDcyNTZhNGZjNDUiLCJ0eXAiOiJCZWFyZXIiLCJhenAiOiJidWlsdGluLWNsaWVudCIsInNpZCI6IjIyZmE5OGY4LWQ2NTgtNDIxNi05OGViLTQyZmY4MmMzMGIzNSIsImFjciI6IjEiLCJyZWFsbV9hY2Nlc3MiOnsicm9sZXMiOlsib2ZmbGluZV9hY2Nlc3MiLCJ1bWFfYXV0aG9yaXphdGlvbiIsImRlZmF1bHQtcm9sZXMtOWJiZDAyMGI5OGE0NDc1Mzk0OGVkZjdhZGRjNmI1NWUiXX0sInJlc291cmNlX2FjY2VzcyI6eyJhY2NvdW50Ijp7InJvbGVzIjpbIm1hbmFnZS1hY2NvdW50IiwibWFuYWdlLWFjY291bnQtbGlua3MiLCJ2aWV3LXByb2ZpbGUiXX19LCJzY29wZSI6Im9wZW5pZCBlbWFpbCBwcm9maWxlIiwiZW1haWxfdmVyaWZpZWQiOnRydWUsIm5hbWUiOiJPemphc3ogR29sZGJlcmciLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJvemphc3oiLCJnaXZlbl9uYW1lIjoiT3pqYXN6IiwiZmFtaWx5X25hbWUiOiJHb2xkYmVyZyIsImVtYWlsIjoibC5zemN6ZXBhbnNraSsxQGV0b2dydXBwZS5jb20ifQ.MR3Zesi8MvzUpGwOEfyL7kTPR_-7kKviuaMY5-13YtCyjjh2YS1_jTJzuzg129QTjegLEuek5PQUyv7ULwd3jas2qYCmhptWU4wK3rMSrjI0ZFHX9vESOGJj2N7kI-1bkPbzJZY4drdtKEysuJCnapwrh9ZT7_vYXDfum8ReIxp5OWssa9dImj25_q2PPWdyl2OmOYowdLxmoYfOQ3BY5wZ6UG8NzyardEi8u8pbUWQLetfWzmaKNa-wspQvUdp3SdlQtwqUdXKvSHKiv9EXQm0LYpylMQoYq247elm20koNfojqhatLvbMadv19_BVDugGyaIruMC1k0PAKSlwYQw";
      String refreshToken = "eyJhbGciOiJIUzUxMiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0N2FkNGQ4NC0xMzJiLTQ0NGItODViNy1kYzYxYzM0MDE0OTUifQ.eyJleHAiOjE3NTIyMzE4OTcsImlhdCI6MTc1MjIzMDA5NywianRpIjoiNmMzZjIwNzgtYjNjOC00N2M1LThmYjYtNDEzNGFkNTA5YzJlIiwiaXNzIjoiaHR0cHM6Ly9hdXRoLWV0b3BheS1kZW1vLmV0b3NwaGVyZXMuY29tL3JlYWxtcy85YmJkMDIwYjk4YTQ0NzUzOTQ4ZWRmN2FkZGM2YjU1ZSIsImF1ZCI6Imh0dHBzOi8vYXV0aC1ldG9wYXktZGVtby5ldG9zcGhlcmVzLmNvbS9yZWFsbXMvOWJiZDAyMGI5OGE0NDc1Mzk0OGVkZjdhZGRjNmI1NWUiLCJzdWIiOiIyNGFhZDRkOC04MWMzLTQzZTAtYmUyNy1hNDcyNTZhNGZjNDUiLCJ0eXAiOiJSZWZyZXNoIiwiYXpwIjoiYnVpbHRpbi1jbGllbnQiLCJzaWQiOiIyMmZhOThmOC1kNjU4LTQyMTYtOThlYi00MmZmODJjMzBiMzUiLCJzY29wZSI6Im9wZW5pZCB3ZWItb3JpZ2lucyByb2xlcyBiYXNpYyBhY3IgZW1haWwgcHJvZmlsZSJ9.DI7BEDonWA4P2QmhHUdI_kxy9oJWdmrgDPRe1UAFbu7vjvf2faEnUuag1cBw37K7CsZfxtjITalqZgGfndVzUQ";
      DateTime accessTokenExpirationDateTime = DateTime(2030);
      String idToken = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJaQ2hvZ0c4TXhmSGlqUTVhVF9QTHQ1ekRtOG9EbW83TElUQ1dXbE1JNzVnIn0.eyJleHAiOjE3NTIyNjYwOTcsImlhdCI6MTc1MjIzMDA5NywianRpIjoiOGYxNjAzMWQtYjI3Ni00Y2I2LWI3ODMtYWU1Y2FhOGJhZTI1IiwiaXNzIjoiaHR0cHM6Ly9hdXRoLWV0b3BheS1kZW1vLmV0b3NwaGVyZXMuY29tL3JlYWxtcy85YmJkMDIwYjk4YTQ0NzUzOTQ4ZWRmN2FkZGM2YjU1ZSIsImF1ZCI6ImJ1aWx0aW4tY2xpZW50Iiwic3ViIjoiMjRhYWQ0ZDgtODFjMy00M2UwLWJlMjctYTQ3MjU2YTRmYzQ1IiwidHlwIjoiSUQiLCJhenAiOiJidWlsdGluLWNsaWVudCIsInNpZCI6IjIyZmE5OGY4LWQ2NTgtNDIxNi05OGViLTQyZmY4MmMzMGIzNSIsImF0X2hhc2giOiJaRkp6eVRseHl0UmJrc0Z6bm5oS1RnIiwiYWNyIjoiMSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiT3pqYXN6IEdvbGRiZXJnIiwicHJlZmVycmVkX3VzZXJuYW1lIjoib3pqYXN6IiwiZ2l2ZW5fbmFtZSI6Ik96amFzeiIsImZhbWlseV9uYW1lIjoiR29sZGJlcmciLCJlbWFpbCI6Imwuc3pjemVwYW5za2krMUBldG9ncnVwcGUuY29tIn0.lx0Uu0EU4-9Ki009_Z7O5SUSAX9ewqsMIIq72HIN65pduu2TtUX4-c8993XgJRk24jWAXDnd8EdCAjp1whgdw0rbLGlGPifXgTvZrwlMgjIiTPxjX-bjS0ZvmteZrK6CC4F81tiq20JjzU1ON1CEdaQ0Cyy0zfIwMSPCYmYUr_Y95jO3KxXdjWNZLclStsT7JkQTgokCFsD6Hfbgf2qBES4S8bMWG8PmB6jPqsVrLSztQmmzbAPID9wDrN-zrt83MClyHlP1LJptuGfY3UoRO128vyKPQUsGwcxbKlDsX7XGCR-65Vj1bgMNpZmCk6zK2J5SvCV9IOgLVjDPHOyGYQ";
      String tokenType = "Bearer";
      String scopes = "openid email profile";
      String authorizationAdditionalParameters = "";
      String tokenAdditionalParameters = "";


      // AuthorizationTokenResponse? result = 
      // AuthorizationTokenResponse(accessToken, refreshToken, accessTokenExpirationDateTime, zidToken, tokenType, scopes, authorizationAdditionalParameters, tokenAdditionalParameters);

      // if (result == null || result.accessToken == null) {
      //   throw Exception('Failed to authenticate or retrieve access token');
      // }

      // Parse the ID token to get the username (sub or preferred_username)
      // final idToken = result.idToken;
      final username = _parseUsernameFromIdToken(idToken);

      setState(() {
        _username = username;
      });
      // Call ETOPay SDK bridge for user creation and initialization
      if (accessToken != null) {
        await EtopaySdkBridge.createNewUser(username);
        await EtopaySdkBridge.initializeUser(username);
      }
      _navigateToTermsAndConditions();
      // Optionally store tokens securely
      await secureStorage.write(key: 'access_token', value: accessToken);
      await secureStorage.write(key: 'id_token', value: idToken);
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
