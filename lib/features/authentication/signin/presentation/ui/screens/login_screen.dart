import 'package:mendlify/generated/l10n.dart';
import 'package:mendlify/shared/widgets/app_logo.dart';
import 'package:mendlify/shared/widgets/app_svg.dart';
import 'package:mendlify/shared/widgets/app_text_button.dart';
import 'package:mendlify/shared/widgets/app_text_view.dart';
import 'package:mendlify/shared/widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/utils/app_values_const.dart';
import '../../../../../../core/utils/image_resources.dart';
import '../../../../../../shared/widgets/app_text_form_field.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(formPaddingFromSides.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SpaceVertical(
              height: 30.h,
            ),
            AppLogo(),
            SpaceVertical(
              height: 20.h,
            ),
            Material(
              borderRadius: BorderRadius.circular(commonCornerRadius.r),
              color: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(formFieldPaddingFromSides.w),
                child: Column(
                  children: [
                    SpaceVertical(
                      height: verticalSpaceBWFormFields.h,
                    ),
                    AppTextView(
                      data: S.of(context).auth_sign_in_title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: Colors.white),
                    ),
                    SpaceVertical(
                      height: verticalSpaceBWFormFields.h,
                    ),
                    AppTextFormField(
                      label: S.of(context).auth_sign_in_email_label,
                      hint: S.of(context).auth_sign_in_email_label,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      textInputAction: TextInputAction.next,
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.grey,
                      ),
                    ),
                    SpaceVertical(
                      height: verticalSpaceBWFormFields.h,
                    ),
                    AppTextFormField(
                      label: S.of(context).auth_sign_in_password_label,
                      hint: S.of(context).auth_sign_in_password_label,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.grey,
                      ),
                    ),
                    SpaceVertical(
                      height: verticalSpaceBWFormFields.h,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppTextView(
                          data: S.of(context).auth_sign_in_forgot_password,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        ),
                        AppTextButton(
                          onPressed: () async {
                          },
                          text: S.of(context).auth_sign_in_button,
                          width: 120,
                          height: commonButtonHeight,
                        ),
                      ],
                    ),
                    SpaceVertical(
                      height: verticalSpaceBWFormFields.h,
                    ),
                  ],
                ),
              ),
            ),
            SpaceVertical(
              height: verticalSpaceBWFormFields.h,
            ),
            AppTextView(
              data: S.of(context).auth_sign_in_social,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white),
            ),
            SpaceVertical(
              height: verticalSpaceBWFormFields.h,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: AppSvg(
                      path: iconGooglePath,
                      width: 18.w,
                      height: 18.h,
                    ),
                    label: AppTextView(
                      data: "Google",
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                  ),
                ),
                SpaceHorizontal(
                  width: 10.w,
                ),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: AppSvg(
                      path: icFBPath,
                      width: 18.w,
                      height: 18.h,
                    ),
                    label: AppTextView(
                      data: "Facebook",
                      style: Theme.of(context).textTheme.bodySmall!,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


