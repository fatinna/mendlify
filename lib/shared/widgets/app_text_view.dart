import 'package:flutter/material.dart';

class AppTextView extends StatelessWidget {
  const AppTextView(
      {super.key, required this.data, this.style, this.textAlign});

  final String data;
  final TextStyle? style;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style,
      textAlign: textAlign,
    );
  }
}
