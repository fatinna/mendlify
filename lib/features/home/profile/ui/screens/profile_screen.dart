import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/shared/widgets/app_image.dart';
import '../../../../../core/route/go_router_provider.dart';
import '../../../../../core/route/route_names.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route=ref.watch(goRouterProvider);
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  const AppImage(
                    path: appProfileGradientPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),


                  Positioned(
                    top: 220,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const CircleAvatar(
                          radius: 70,
                          backgroundColor: appBackgroundColor,
                          child: CircleAvatar(
                            radius: 65,
                            backgroundColor: appCardColor,
                            child: Icon(Icons.person, size: 60, color: appTextColor),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: appButtonColor,
                            child: IconButton(
                              icon: const Icon(Icons.edit, size: 22, color: Colors.white),
                              onPressed: () {
                                // Handle profile picture edit
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80),
            const Text(
              'Fatima Waseem',
              style: TextStyle(
                color: appMainTextColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'youremail@domain.com | +92 23456789',
              style: TextStyle(
                color: appTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _ProfileActionButton(
                    icon: Icons.edit_outlined,
                    label: 'Edit Personal Info',
                    onTap: () {
                      route.push(getRoutePath(editPersonalInfoRoute));
                    },
                  ),
                  const SizedBox(width: 16),
                  _ProfileActionButton(
                    icon: Icons.edit_outlined,
                    label: 'Edit Bike Info',
                    onTap: () {
                      route.push(getRoutePath(editBikeInfoRoute));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  _ProfileListTile(
                    icon: Icons.menu_book_outlined,
                    label: 'My Guides',
                    onTap: () {
                      route.push(getRoutePath(myGuidesRoute));
                    },
                  ),
                  const SizedBox(height: 12),
                  _ProfileListTile(
                    icon: Icons.article_outlined,
                    label: 'My Posts',
                    onTap: () {
                      route.push(getRoutePath(myPostsRoute));
                    },
                  ),
                  const SizedBox(height: 12),
                  _ProfileListTile(
                    icon: Icons.history_outlined,
                    label: 'Diagnosis History',
                    onTap: () {
                      route.push(getRoutePath(diagnosisHistoryRoute));
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    route.push(getRoutePath(loginRoute));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appButtonColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Padding at the bottom
          ],
        ),
      ),
    );
  }
}

// Helper widget for the top two buttons
class _ProfileActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: appCardColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: appTextColor, size: 32),
              const SizedBox(height: 10),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: appMainTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Helper widget for the list items
class _ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ProfileListTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: appCardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: appTextColor, size: 24),
            const SizedBox(width: 16),
            Text(
              label,
              style: const TextStyle(
                color: appMainTextColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: appTextColor, size: 16),
          ],
        ),
      ),
    );
  }
}

