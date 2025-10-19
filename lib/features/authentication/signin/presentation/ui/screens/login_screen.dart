import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_image.dart';
import 'package:mendlify/shared/widgets/app_svg.dart';
import 'package:mendlify/shared/widgets/app_text_form_field.dart';
import 'package:mendlify/shared/widgets/app_background.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Top decorative image
              const AppImage(
                path: appLoginBackground,
                width: 412,
                height: 291,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome Text
                    const Text(
                      'Hi, Welcome Back!',
                      style: TextStyle(
                        color: appTextColor,
                        fontSize: 16,
                      ),
                    ),
                    const Text(
                      'Login',
                      style: TextStyle(
                        color: appMainTextColor,
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Email Field
                    AppTextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      hint: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined, color: appTextColor),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    AppTextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      hint: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline, color: appTextColor),
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 12),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: appTextColor),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appButtonColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Social Login Divider
                    const Row(
                      children: [
                        Expanded(child: Divider(color: appTextColor)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('- OR Continue with -', style: TextStyle(color: appTextColor)),
                        ),
                        Expanded(child: Divider(color: appTextColor)),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Social Login Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(imagePath: iconGooglePath),
                        const SizedBox(width: 20),
                        _buildSocialButton(imagePath: appleSvgPath),
                        const SizedBox(width: 20),
                        _buildSocialButton(imagePath: icFBPath),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Sign Up Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Create An Account ", style: TextStyle(color: appTextColor)),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Sign Up Screen
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: appButtonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String imagePath}) {
    return CircleAvatar(
      radius: 24,
      backgroundColor: appSocialColor,
      child: AppSvg(path: imagePath, width: 24, height: 24),
    );
  }
}
