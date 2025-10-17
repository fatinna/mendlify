import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import '../../../../../core/route/go_router_provider.dart';
import '../../../../../core/route/route_names.dart';
import '../../../../../core/utils/image_resources.dart';
import '../../../../../shared/widgets/app_image.dart';


class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {
      'title': 'Know before you go',
      'description':
      'Get quick AI powered checks so you understand the issue before visiting a mechanic.',
      'image': appLanding1path,
    },
    {
      'title': 'Two wheels, one tribe.',
      'description':
      'A space for bikers to swap hacks, troubleshoot, and ride smarter together.',
      'image': appLanding2path,
    },
    {
      'title': 'Trusted hands, trusted parts',
      'description':
      'Connect with mechanics and vendors who deliver honesty and quality.',
      'image': appLanding3path,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(goRouterProvider);

    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: Stack(
        children: [
          // Background design elements
          Positioned(
            top: -20,
            left: -170,
            child: AppImage(
              path: appDesign2Path,
              width: 350,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),
          Positioned(
            bottom: -20,
            right: -70,
            child: AppImage(
              path: appDesign2Path,
              width: 350,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _pages.length,
            itemBuilder: (context, index) {
              final page = _pages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                // This Column now holds everything and centers it all together
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, // This is the key change
                  children: [
                    // --- Content Block ---
                    const SizedBox(height: 20),
                    AppImage(
                      path: page['image']!,
                      width: 269,
                      height: 252,
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      page['title']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: appTextColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arvo',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      page['description']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: appTextColor,
                        fontSize: 15,
                        fontFamily: 'Arvo',
                      ),
                    ),
                    // Add space between text and button to match your screenshot
                    const SizedBox(height: 10),

                    // --- Controls Block (now part of the main column) ---
                    SizedBox(
                      width: 311,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_currentPage == _pages.length - 1) {
                            route.push(getRoutePath(loginRoute));
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appButtonColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(61),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1 ? 'Finish' : 'Next',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Space Grotesk',
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // Space for indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _pages.length,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? appMainTextColor
                                : Colors.white24,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => route.push(getRoutePath(loginRoute)),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 10, bottom: 25),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: appTextColor,
                            fontSize: 16,
                            fontFamily: 'Arvo',
                            //fontWeight: FontWeight.w300, need to repl
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}