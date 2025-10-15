import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  const AppImage(
      {super.key,
      required this.path,
      this.width,
      this.height,
      this.color,
      this.fit});

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: fit,
    );
  }
}
