import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/app_image.dart';
import 'package:mendlify/shared/widgets/app_text_form_field.dart';

import '../../../../../../core/route/route_names.dart';

class ForgotPasswordEnterEmailScreen extends ConsumerStatefulWidget {
  const ForgotPasswordEnterEmailScreen({super.key});

  @override
  ConsumerState<ForgotPasswordEnterEmailScreen> createState() =>
      _ForgotPasswordEnterEmailScreenState();
}

class _ForgotPasswordEnterEmailScreenState
    extends ConsumerState<ForgotPasswordEnterEmailScreen> {
  late TextEditingController _emailController;
  late FocusNode _emailFocusNode;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(goRouterProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // Using SingleChildScrollView to prevent overflow on smaller screens
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(height: 50),

                // Logo Image
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 200,
                    child: const AppImage(
                      path: appLogoPath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Reset Password Header
                const Text(
                  'Reset Password?',
                  style: TextStyle(
                    color: appMainTextColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Enter your Email, we will send you a verification code.',
                  style: TextStyle(
                    color: appTextColor, // Using hint color/secondary text color
                    fontSize: 14,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Email Input Field
                AppTextFormField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  hint: 'Your Email',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 10.0),
                    child: Icon(Icons.email_outlined, color: appTextColor),
                  ),
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 30),

                // Send Code Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Send Code button pressed');
                      route.push(getRoutePath(codeVerificationRoute));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18.0),
                    ),
                    child: const Text(
                      'Send Code',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Back Button
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    route.pop();
                  },
                  child: const Text(
                    'Back to Login',
                    style: TextStyle(color: appTextColor),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}