import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.onChanged,
    this.validator,
    this.obscureText = false,
  });

  final String? label;
  final String? hint;
  final String? errorMessage;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(40.0),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: theme.colorScheme.primary),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: Colors.red.shade800),
        ),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        focusColor: theme.colorScheme.primary,
        errorText: errorMessage,
      ),
    );
  }
}
