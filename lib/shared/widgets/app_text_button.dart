import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_text_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/app_values_const.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton(
      {super.key,
      required this.text,
      this.onPressed,
      required this.height,
      required this.width});

  final String text;
  final VoidCallback? onPressed;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(appAccentColorLight),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(commonCornerRadius.r),
          ),
        ),
        splashFactory: InkRipple.splashFactory,
        minimumSize: WidgetStateProperty.all(
          Size(width.w, height.h),
        ),
      ),
      child: AppTextView(
        data: text,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Colors.white,
            ),
      ),
    );
  }
}
