import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/app_image.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBackground(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [

            AppImage(
              path: appBikepath,
              width: 300,
              height: 300,
              fit: BoxFit.contain,

              color: Colors.white.withValues(alpha: 0.5),
            ),
            const AppImage(
              path: appLogoPath,
              width: 220,
              height: 220,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

