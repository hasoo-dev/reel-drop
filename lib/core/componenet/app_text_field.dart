// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.validator,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.isBorderless = false,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final AutovalidateMode autovalidateMode;
  final bool isBorderless;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface.withOpacity(0.4),
        ),
        prefixIcon: prefixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: prefixIcon,
              )
            : null,
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        suffixIcon: suffixIcon,
        border: isBorderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                  width: 1.3,
                ),
              ),
        enabledBorder: isBorderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary.withOpacity(0.5),
                  width: 1.3,
                ),
              ),
        focusedBorder: isBorderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2.3,
                ),
              ),
        errorBorder: isBorderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 3.0,
                ),
              ),
        focusedErrorBorder: isBorderless
            ? InputBorder.none
            : OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 2.5,
                ),
              ),
        errorStyle: const TextStyle(fontSize: 12, color: Colors.redAccent),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        filled: !isBorderless,
        fillColor: Colors.transparent,
      ),
    );
  }
}
