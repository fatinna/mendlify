import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppSvg extends StatelessWidget {
  const AppSvg(
      {super.key,
      required this.path,
      this.width,
      this.height,
      this.color,
      this.fit=BoxFit.scaleDown});

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width,
      height: height,
      fit: fit!,
    );
  }
}
