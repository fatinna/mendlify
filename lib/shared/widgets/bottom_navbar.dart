import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart'; // Placeholder for your colors

/// A reusable bottom navigation bar widget that uses the 'curved_navigation_bar' package.
class CurvedBottomNavBar extends StatelessWidget {
  /// The index of the currently selected item.
  final int selectedIndex;

  /// Callback function that is called when an item is tapped.
  final ValueChanged<int> onItemSelected;

  /// The list of icons to display in the navigation bar.
  final List<IconData> icons;

  const CurvedBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: selectedIndex,
      height: 65.0, // A bit more height for a better look
      items: icons
          .map((icon) => Icon(icon, size: 30, color: appMainTextColor))
          .toList(),
      color: appCardColor, // The color of the bar itself
      buttonBackgroundColor: appButtonColor, // Color of the circle behind the selected icon
      backgroundColor: Colors.transparent, // VERY IMPORTANT for your AppBackground to be visible
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 400),
      onTap: onItemSelected,
      letIndexChange: (index) => true,
    );
  }
}

