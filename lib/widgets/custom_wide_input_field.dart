import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String value;
  final void Function(String) onChanged;
  final TextInputType keyboardType;

  const CustomInputField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isFocused = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode()
      ..addListener(() {
        setState(() {
          _isFocused = _focusNode.hasFocus;
        });
      });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.value,
      focusNode: _focusNode,
      keyboardType: widget.keyboardType,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: widget.label,
        filled: true,
        fillColor: _isFocused ? Colors.white : const Color(0xFFF5F5F5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(color: Color(0xFFF5F5F5)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      onChanged: widget.onChanged,
    );
  }
}
