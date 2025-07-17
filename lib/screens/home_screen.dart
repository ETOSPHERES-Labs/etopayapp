import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import '../view_models/lock_screen_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../core/colors.dart';
import 'dart:async';
import 'main_home_screen.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  final TextEditingController _pinController = TextEditingController();
  bool _isAuthenticating = false;
  String? _error;
  bool _biometricAvailable = false;
  FocusNode _pinFocusNode = FocusNode();
  bool _pinFieldFocused = false;
  bool _showCursor = true;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    _pinController.text = ''; // Start empty, but use 444444 for test validation
    _pinFocusNode.addListener(_handlePinFocus);
  }

  void _handlePinFocus() {
    setState(() {
      _pinFieldFocused = _pinFocusNode.hasFocus;
    });
    if (_pinFocusNode.hasFocus) {
      _startCursorTimer();
    } else {
      _stopCursorTimer();
    }
  }

  void _startCursorTimer() {
    _cursorTimer?.cancel();
    _showCursor = true;
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _showCursor = !_showCursor;
      });
    });
  }

  void _stopCursorTimer() {
    _cursorTimer?.cancel();
    _showCursor = true;
  }

  Future<void> _checkBiometrics() async {
    final available = await auth.canCheckBiometrics && await auth.isDeviceSupported();
    setState(() {
      _biometricAvailable = available;
    });
  }

  Future<void> _authenticateWithBiometrics() async {
    setState(() {
      _isAuthenticating = true;
      _error = null;
    });
    try {
      final authenticated = await auth.authenticate(
        localizedReason: 'Unlock with biometrics',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (authenticated) {
        _onUnlockSuccess();
      } else {
        setState(() {
          _error = 'Biometric authentication failed.';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Error: $e';
      });
    } finally {
      setState(() {
        _isAuthenticating = false;
      });
    }
  }

  void _onUnlockSuccess() {
    if (!mounted) return;
    context.go('/main-home');
  }

  void _onPinSubmit() {
    // TODO: Replace with real PIN check logic
    if (_pinController.text == '444444') {
      _onUnlockSuccess();
    } else {
      setState(() {
        _error = 'Incorrect PIN';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LockScreenViewModel(),
      child: Consumer<LockScreenViewModel>(
        builder: (context, model, _) {
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile picture
                      CircleAvatar(
                        radius: 100, // 200x200 diameter
                        backgroundColor: Colors.grey.shade200,
                        child: SvgPicture.asset(
                          model.profileImage,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 32), // More space after profile image
                      // Username
                      Text(
                        model.username,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 40), // More space after username
                      // Remove the lock icon and fix PIN input
                      GestureDetector(
                        onTap: () {
                          FocusScope.of(context).requestFocus(_pinFocusNode);
                        },
                        child: SizedBox(
                          width: 212,
                          height: 12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(6, (index) {
                              bool hasDigit = _pinController.text.length > index;
                              bool isCursor =
                                  _pinFieldFocused && !_isAuthenticating && _pinController.text.length == index && _showCursor && _pinController.text.length < 6;
                              if (hasDigit) {
                                return Container(
                                  width: 16,
                                  height: 16,
                                  decoration: const BoxDecoration(
                                    color: AppColors.primary,
                                    shape: BoxShape.circle,
                                  ),
                                );
                              } else if (isCursor) {
                                return Container(
                                  width: 16,
                                  height: 16,
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 2,
                                    height: 16,
                                    color: Colors.black,
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 16,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24), // More space after PIN entry
                      SizedBox(
                        width: 0,
                        height: 0,
                        child: TextField(
                          focusNode: _pinFocusNode,
                          controller: _pinController,
                          keyboardType: TextInputType.number,
                          maxLength: 6,
                          autofocus: true,
                          enableInteractiveSelection: false,
                          showCursor: false,
                          style: const TextStyle(color: Colors.transparent),
                          cursorColor: Colors.transparent,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            counterText: '',
                            contentPadding: EdgeInsets.zero,
                          ),
                          onChanged: (_) => setState(() {}),
                          onSubmitted: (_) => _onPinSubmit(),
                          enabled: !_isAuthenticating,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _isAuthenticating ? null : _onPinSubmit,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(108, 39),
                          maximumSize: const Size(108, 39),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text('Enter'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_right_alt),
                          ],
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 16),
                        Text(_error!, style: const TextStyle(color: Colors.red)),
                      ],
                      const SizedBox(height: 40),
                      if (_biometricAvailable) ...[
                        Text(
                          'Or use fingerprint',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
                        ),
                        const SizedBox(height: 12),
                        IconButton(
                          icon: const Icon(Icons.fingerprint, size: 40),
                          onPressed: _isAuthenticating ? null : _authenticateWithBiometrics,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _cursorTimer?.cancel();
    super.dispose();
  }
} 