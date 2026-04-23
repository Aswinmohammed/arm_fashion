import 'package:flutter/material.dart';

class AppTextInput extends StatelessWidget {
  const AppTextInput({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
    this.onChanged,
    this.textInputAction,
    this.labelColor = const Color(0xFF5F5F5F),
    this.textColor = const Color(0xFF181818),
    this.hintColor = const Color(0xFF8B8B8B),
    this.borderColor = const Color(0xFFBDBDBD),
    this.focusedBorderColor = Colors.black,
  });

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final TextInputAction? textInputAction;
  final Color labelColor;
  final Color textColor;
  final Color hintColor;
  final Color borderColor;
  final Color focusedBorderColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: labelColor,
            letterSpacing: 2.1,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          textInputAction: textInputAction,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: theme.textTheme.bodyLarge?.copyWith(
              color: hintColor,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.only(bottom: 14),
            isDense: true,
            filled: false,
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focusedBorderColor, width: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}
