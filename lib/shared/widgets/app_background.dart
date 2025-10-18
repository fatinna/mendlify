import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_image.dart';

class AppBackground extends ConsumerWidget {

  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color:appBackgroundColor,
          ),
          Positioned(
            top: -50,
            left: -50,
            child: AppImage(
              path: appDesign2Path,
              width: 200,
              height: 200,
              color: Colors.white.withValues(alpha: 1),
            ),
          ),
          Positioned(
            bottom: -60,
            right: -60,
            child: AppImage(
              path: appDesign2Path,
              width: 250,
              height: 250,
              color: Colors.white.withValues(alpha: 1),
            ),
          ),

          SafeArea(
            child: child,
          ),
        ],
      ),
    );
  }
}
