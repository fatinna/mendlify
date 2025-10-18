import 'package:flutter/material.dart';

// A model for the navigation bar items.
class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}

class AnimatedBottomNavBar extends StatefulWidget {
  final List<NavBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int selectedIndex;

  const AnimatedBottomNavBar({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.selectedIndex = 0,
  });

  @override
  State<AnimatedBottomNavBar> createState() => _AnimatedBottomNavBarState();
}

class _AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedBottomNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIndex != _selectedIndex) {
      _controller.reset();
      _controller.forward();
      setState(() {
        _selectedIndex = widget.selectedIndex;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double navBarHeight = 65.0;
    final double itemWidth = MediaQuery.of(context).size.width / widget.items.length;

    return SizedBox(
      height: navBarHeight,
      width: double.infinity,
      child: Stack(
        children: [
          // The custom painted background
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                size: Size(MediaQuery.of(context).size.width, navBarHeight),
                painter: NavBarPainter(
                  itemCount: widget.items.length,
                  selectedIndex: _selectedIndex,
                  animation: _animation.value,
                  color: const Color(0xFF2B2D42), // Matches your design
                ),
              );
            },
          ),
          // The icons and labels
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(widget.items.length, (index) {
                return _buildNavItem(index, itemWidth);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, double itemWidth) {
    final bool isSelected = _selectedIndex == index;
    final NavBarItem item = widget.items[index];

    return GestureDetector(
      onTap: () => widget.onItemSelected(index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: itemWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated container for the selected icon
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: isSelected
                  ? Matrix4.translationValues(0, -22, 0)
                  : Matrix4.translationValues(0, 0, 0),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? const Color(0xFFD90429) : Colors.transparent,
                ),
                child: Icon(
                  item.icon,
                  color: isSelected ? Colors.white : Colors.white54,
                  size: 28,
                ),
              ),
            ),
            // Label for the selected item
            if (isSelected)
              Padding(
                padding: const EdgeInsets.only(top: 2.0),
                child: Text(
                  item.label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Custom painter for the navigation bar's shape
class NavBarPainter extends CustomPainter {
  final int itemCount;
  final int selectedIndex;
  final double animation;
  final Color color;

  NavBarPainter({
    required this.itemCount,
    required this.selectedIndex,
    required this.animation,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final double itemWidth = size.width / itemCount;
    final double notchCenter = (selectedIndex * itemWidth) + (itemWidth / 2);

    final Path path = Path();
    path.moveTo(0, 20); // Start with a rounded corner effect

    // Draw the notch
    path.lineTo(notchCenter - 40, 20);
    path.cubicTo(
        notchCenter - 20, 20, notchCenter - 25, 0, notchCenter, 0);
    path.cubicTo(
        notchCenter + 25, 0, notchCenter + 20, 20, notchCenter + 40, 20);

    path.lineTo(size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}