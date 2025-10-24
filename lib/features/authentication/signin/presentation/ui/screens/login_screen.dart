import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/route/route_names.dart';
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
    final route = ref.watch(goRouterProvider);

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const AppImage(
                    path: appLoginBackgroundPath,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 70,
                    left: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hi, Welcome Back!',
                          style: TextStyle(
                            color: Colors.white.withAlpha(230),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          'Login',
                          style: TextStyle(
                            color: appMainTextColor,
                            fontSize: 60,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // --- Form Section ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(flex: 2),
                    AppTextFormField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      hint: 'Email',
                      prefixIcon: const Icon(Icons.email_outlined, color: appTextColor),
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 20),
                    AppTextFormField(
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      hint: 'Password',
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline, color: appTextColor),
                      textInputAction: TextInputAction.done,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          route.push(getRoutePath(forgotPasswordEnterEmailRoute));
                        },
                        child: const Text(
                          'Forgot Password?',
                          style: TextStyle(color: appTextColor, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          route.push(getRoutePath(homeRoute));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appButtonColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
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
                    const Spacer(flex: 3),
                    const Text('- OR Continue with -', style: TextStyle(color: appTextColor)),
                    const SizedBox(height: 20),
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
                    const Spacer(flex: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Create An Account ", style: TextStyle(color: appTextColor)),
                        GestureDetector(
                          onTap: () {
                            route.push(getRoutePath(singUpRoute));
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
                    const Spacer(flex: 1),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({required String imagePath}) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(24),
      child: CircleAvatar(
        radius: 24,
        backgroundColor: appSocialColor,
        child: AppSvg(path: imagePath, width: 24, height: 24),
      ),
    );
  }
}

