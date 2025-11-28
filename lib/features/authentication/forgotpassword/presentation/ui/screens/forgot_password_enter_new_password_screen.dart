import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/route/route_names.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/app_image.dart';
import 'package:mendlify/shared/widgets/app_text_form_field.dart';

class ForgotPasswordEnterNewPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordEnterNewPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordEnterNewPasswordScreen> createState() =>
      _ForgotPasswordEnterNewPasswordScreenState();
}

class _ForgotPasswordEnterNewPasswordScreenState
    extends ConsumerState<ForgotPasswordEnterNewPasswordScreen> {
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;
  late FocusNode _passwordFocusNode;
  late FocusNode _confirmFocusNode;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _passwordFocusNode = FocusNode();
    _confirmFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmFocusNode.dispose();
    super.dispose();
  }

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      // Logic to reset password
      print('Password: ${_passwordController.text}');
      print('Confirm Password: ${_confirmPasswordController.text}');

      // Navigate to login or success screen
      ref.read(goRouterProvider).go(getRoutePath(loginRoute));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 50),

                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: const AppImage(
                        path: appLogoPath, // Keeping consistency with previous screens
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 1.0),

                  // "Create new password" Title
                  const Text(
                    'Create new password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: appMainTextColor,
                    ),
                  ),
                  const SizedBox(height: 8.0),

                  // Instruction Text
                  const Text(
                    'Your new password must be different from previously used password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: appTextColor, // Using the hint/secondary color
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40.0),

                  // Password Input Field
                  AppTextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    hint: 'Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline, color: appTextColor),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),

                  // Confirm Password Input Field
                  AppTextFormField(
                    controller: _confirmPasswordController,
                    focusNode: _confirmFocusNode,
                    hint: 'Confirm Password',
                    obscureText: true,
                    prefixIcon: const Icon(Icons.lock_outline, color: appTextColor),
                    textInputAction: TextInputAction.done,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40.0),

                  // Reset Password Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appButtonColor,
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      child: const Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}