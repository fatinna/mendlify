import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/shared/widgets/app_image.dart';

class VendorScreen extends ConsumerWidget {
  const VendorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child:Padding(
              padding: EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0, bottom: 16.0),
              //alignment: Alignment.centerLeft,
              child: Text(
                'Vendors',
                style: TextStyle(
                  color: appMainTextColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                height: 200,
                color: appCardColor,
                child: const AppImage(
                  path: fatimaImagePath,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  // As a fallback, show an icon
                  // child: Icon(Icons.map, size: 100, color: appTextColor),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              children: [
                _VendorListTile(
                  icon: Icons.local_car_wash,
                  iconColor: Colors.teal,
                  title: 'AutoFix Pro',
                  subtitle: '4.8 (120 reviews) - 0.5 miles',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _VendorListTile(
                  icon: Icons.speed,
                  iconColor: Colors.orange,
                  title: 'QuickTune Auto',
                  subtitle: '4.5 (85 reviews) - 1.2 miles',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _VendorListTile(
                  icon: Icons.build,
                  iconColor: Colors.blueGrey,
                  title: 'Precision Auto Care',
                  subtitle: '4.2 (60 reviews) - 2.5 miles',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VendorListTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _VendorListTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: appCardColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: iconColor.withAlpha(50),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: appMainTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: appTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: appTextColor, size: 16),
          ],
        ),
      ),
    );
  }
}
