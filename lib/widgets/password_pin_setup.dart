import 'package:eto_pay/core/colors.dart';
import 'package:flutter/material.dart';
import 'package:eto_pay/widgets/conditional_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eto_pay/core/theme.dart';
import 'package:local_auth/local_auth.dart';

class PasswordPinSetupWidget extends StatefulWidget {
  final String imageAsset;
  final String title;
  final String subtext;
  final bool isPin;
  final VoidCallback onContinue;
  final double imageHeight;

  const PasswordPinSetupWidget({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.subtext,
    required this.onContinue,
    this.isPin = false,
    this.imageHeight = 180,
  });

  @override
  State<PasswordPinSetupWidget> createState() => _PasswordPinSetupWidgetState();
}

class _PasswordPinSetupWidgetState extends State<PasswordPinSetupWidget> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  bool _obscure1 = true;
  bool _obscure2 = true;
  String _strength = '';
  bool _valid = false;
  bool _biometricsEnabled = false;
  bool _biometricsAvailable = false;

  @override
  void initState() {
    super.initState();
    _controller1.addListener(_validate);
    _controller2.addListener(_validate);
    _checkBiometrics();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Future<void> _checkBiometrics() async {
    final localAuth = LocalAuthentication();
    final available = await localAuth.canCheckBiometrics;
    setState(() {
      _biometricsAvailable = available;
    });
  }

  Future<void> _toggleBiometrics(bool value) async {
    if (value) {
      final localAuth = LocalAuthentication();
      final didAuth = await localAuth.authenticate(
        localizedReason: 'Enable biometric unlock',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (didAuth) {
        setState(() => _biometricsEnabled = true);
      }
    } else {
      setState(() => _biometricsEnabled = false);
    }
  }

  void _validate() {
    final v1 = _controller1.text;
    final v2 = _controller2.text;
    bool valid = false;
    String strength = '';
    if (widget.isPin) {
      valid = v1.length == 6 && v1 == v2 && RegExp(r'^\d{6}$').hasMatch(v1);
      strength = v1.length == 6 ? 'Strong' : 'Weak';
    } else {
      valid = v1 == v2 && _isStrongPassword(v1);
      strength = _passwordStrength(v1);
    }
    setState(() {
      _valid = valid;
      _strength = strength;
    });
  }

  bool _isStrongPassword(String value) {
    return value.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(value) &&
        RegExp(r'[a-z]').hasMatch(value) &&
        RegExp(r'[0-9]').hasMatch(value) &&
        RegExp(r'[!@#\$&*~]').hasMatch(value);
  }

  String _passwordStrength(String value) {
    if (value.length < 8) return 'Too short';
    int score = 0;
    if (RegExp(r'[A-Z]').hasMatch(value)) score++;
    if (RegExp(r'[a-z]').hasMatch(value)) score++;
    if (RegExp(r'[0-9]').hasMatch(value)) score++;
    if (RegExp(r'[!@#\$&*~]').hasMatch(value)) score++;
    if (score <= 2) return 'Weak';
    if (score == 3) return 'Medium';
    return 'Strong';
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.imageAsset.toLowerCase().endsWith('.svg'))
              SvgPicture.asset(widget.imageAsset, height: widget.imageHeight)
            else
              Image.asset(widget.imageAsset, height: widget.imageHeight),
            const SizedBox(height: 24),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              widget.subtext,
              style: const TextStyle(color: AppColors.subtext),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller1,
              obscureText: _obscure1,
              keyboardType:
                  widget.isPin ? TextInputType.number : TextInputType.text,
              maxLength: widget.isPin ? 6 : null,
              decoration: InputDecoration(
                labelText: widget.isPin ? 'Enter PIN' : 'Enter password',
                filled: true,
                fillColor: AppTheme.inputFieldBackground,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.inputFieldBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.inputFieldBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon:
                      Icon(_obscure1 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure1 = !_obscure1),
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller2,
              obscureText: _obscure2,
              keyboardType:
                  widget.isPin ? TextInputType.number : TextInputType.text,
              maxLength: widget.isPin ? 6 : null,
              decoration: InputDecoration(
                labelText: widget.isPin ? 'Confirm PIN' : 'Confirm password',
                filled: true,
                fillColor: AppTheme.inputFieldBackground,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.inputFieldBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppTheme.inputFieldBackground),
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon:
                      Icon(_obscure2 ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _obscure2 = !_obscure2),
                ),
              ),
            ),
            if (widget.isPin)
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Allow unlocking with biometrics'),
                value: _biometricsEnabled,
                onChanged: _biometricsAvailable ? _toggleBiometrics : null,
              ),
            if (widget.isPin)
              const Padding(
                padding: EdgeInsets.only(top: 4.0),
                child: Text(
                  'PIN must be 6 digits',
                  style: TextStyle(color: AppColors.subtext, fontSize: 13),
                ),
              ),
            if (!widget.isPin)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Text(
                      'Password strength: ',
                      style: const TextStyle(
                          color: AppColors.subtext, fontSize: 13),
                    ),
                    Text(
                      _strength,
                      style: TextStyle(
                        color: _strength == 'Strong'
                            ? Colors.green
                            : _strength == 'Medium'
                                ? Colors.orange
                                : Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            ConditionalButton(
              isActive: _valid,
              onPressed: _valid ? widget.onContinue : () {},
              text: 'Continue',
            ),
          ],
        ),
      ),
    );
  }
}
