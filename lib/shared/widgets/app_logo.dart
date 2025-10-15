import 'package:mendlify/shared/widgets/app_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/image_resources.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return AppImage(
      path: appLogoPath,
      width: 100.w,
      height: 100.h,
    );
  }
}
