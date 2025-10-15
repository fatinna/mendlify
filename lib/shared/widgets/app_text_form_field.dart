import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField(
      {super.key,
      required this.controller,
        required  this.focusNode,
      this.onChanged,
      this.validator,
      this.textInputAction,
      this.label,
      this.hint,
      this.obscureText,
      this.readOnly,
      this.suffixIcon,
      this.prefixIcon,
      this.enabled});

  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final String? label;
  final String? hint;
  final bool? obscureText;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      validator: validator,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        hintText: hint,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
      ),
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      enabled: enabled ?? true,
    );
  }
}
