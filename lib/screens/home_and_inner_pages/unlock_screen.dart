import 'dart:async';
import 'package:eto_pay/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import '../../services/auth_service.dart';
import '../../widgets/pin_input_display.dart';
import '../../widgets/biometric_section.dart';

class UnlockScreen extends ConsumerStatefulWidget {
  const UnlockScreen({super.key});

  @override
  ConsumerState<UnlockScreen> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends ConsumerState<UnlockScreen> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  final LocalAuthentication _auth = LocalAuthentication();

  Timer? _cursorTimer;
  bool _showCursor = true;
  bool _isAuthenticating = false;
  bool _biometricAvailable = true;
  bool _pinFieldFocused = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    _pinFocusNode.addListener(_handlePinFocus);
    _startCursorTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_pinFocusNode);
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    _cursorTimer?.cancel();
    super.dispose();
  }

  void _handlePinFocus() {
    setState(() {
      _pinFieldFocused = _pinFocusNode.hasFocus;
    });
  }

  void _startCursorTimer() {
    _cursorTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      setState(() {
        _showCursor = !_showCursor;
      });
    });
  }

  Future<void> _checkBiometrics() async {
    final available = await AuthService.isBiometricAvailable(_auth);
    setState(() => _biometricAvailable = available);
  }

  Future<void> _authenticateWithBiometrics() async {
    setState(() {
      _isAuthenticating = true;
      _error = null;
    });

    final success = await AuthService.authenticate(_auth);
    setState(() {
      _isAuthenticating = false;
      _error = success ? null : 'Biometric authentication failed.';
    });

    if (success) _onUnlockSuccess();
  }

  void _onPinSubmit(String pin) {
    if (_pinController.text == pin) {
      _onUnlockSuccess();
    } else {
      setState(() {
        _error = 'Incorrect PIN';
        _pinController.clear();
      });

      FocusScope.of(context).requestFocus(_pinFocusNode);
    }
  }

  void _onUnlockSuccess() {
    if (!mounted) return;
    context.go('/home-and-inner-pages');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey.shade200,
                  child: Image.asset(
                    user.avatar,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  user.name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 40),
                GestureDetector(
                  onTap: () =>
                      FocusScope.of(context).requestFocus(_pinFocusNode),
                  child: PinInputDisplay(
                    pin: _pinController.text,
                    isFocused: _pinFieldFocused,
                    isAuthenticating: _isAuthenticating,
                    showCursor: _showCursor,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: 0,
                  height: 0,
                  child: TextField(
                    focusNode: _pinFocusNode,
                    controller: _pinController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    autofocus: true,
                    obscureText: true,
                    enableInteractiveSelection: false,
                    showCursor: false,
                    style: const TextStyle(color: Colors.transparent),
                    cursorColor: Colors.transparent,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (_) {
                      setState(() {
                        if (_error != null) _error = null;
                      });
                    },
                    onSubmitted: (_) => _onPinSubmit(user.pin),
                    enabled: !_isAuthenticating,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed:
                      _isAuthenticating ? null : () => _onPinSubmit(user.pin),
                  style: ButtonStyle(
                    minimumSize: WidgetStateProperty.all(const Size(108, 39)),
                    maximumSize: WidgetStateProperty.all(const Size(108, 39)),
                    padding: WidgetStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    backgroundColor:
                        WidgetStateProperty.resolveWith<Color>((states) {
                      if (states.contains(WidgetState.hovered)) {
                        return const Color(0x26005CA9);
                      }
                      return const Color(0x1A005CA9);
                    }),
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    elevation: WidgetStateProperty.all(0),
                    shadowColor: WidgetStateProperty.all(Colors.transparent),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    animationDuration: Duration.zero,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Enter'),
                      SizedBox(width: 10),
                      Icon(Icons.arrow_right_alt),
                    ],
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 16),
                  Text(
                    _error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ],
                const SizedBox(height: 40),
                if (_biometricAvailable)
                  BiometricSection(
                    isAuthenticating: _isAuthenticating,
                    onAuthenticate: _authenticateWithBiometrics,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
