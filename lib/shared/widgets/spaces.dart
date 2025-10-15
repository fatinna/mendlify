import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceHorizontal extends StatelessWidget {
  const SpaceHorizontal({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return RSizedBox.horizontal(
      width,
    );
  }
}

class SpaceVertical extends StatelessWidget {
  const SpaceVertical({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return RSizedBox.vertical(height);
  }
}
