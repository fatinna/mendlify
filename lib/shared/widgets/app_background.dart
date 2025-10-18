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
            top: -40,
            left: -120,
            child: AppImage(
              path: appDesign2Path,
              width: 300,
              height: 250,
              color: Colors.white.withValues(alpha: 0.50),
            ),
          ),
          Positioned(
            bottom: -40,
            right: -70,
            child: AppImage(
              path: appDesign2Path,
              width: 350,
              height: 250,
              color: Colors.white.withValues(alpha: 0.50),
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



