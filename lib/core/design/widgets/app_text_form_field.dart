import 'package:flutter/material.dart';

class AppTextFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool passwordEye;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;

  const AppTextFormField({
    super.key,
    required this.labelText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.passwordEye = false,
    this.focusNode,
    this.nextFocus,
  });

  @override
  State<AppTextFormField> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends State<AppTextFormField> {
  late bool _obscureText = widget.obscureText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: _obscureText,
      focusNode: widget.focusNode,
      onFieldSubmitted: (String text) {
        if (widget.nextFocus != null) {
          FocusScope.of(context).requestFocus(widget.nextFocus);
        }
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        fillColor: Colors.grey[800],
        filled: true,
        contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(14.0),
        ),
        suffixIcon: widget.passwordEye
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
              )
            : null,
      ),
    );
  }
}
