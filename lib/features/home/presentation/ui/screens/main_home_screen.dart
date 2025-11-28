import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/route/route_names.dart'; // Import route names
import 'package:mendlify/features/home/diagnostics/ui/screens/diagnosis_one_screen.dart';
import 'package:mendlify/features/home/presentation/ui/screens/all_posts.dart';
import 'package:mendlify/features/home/presentation/ui/screens/vendor_screen.dart';
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/bottom_navbar.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';

import '../../../profile/ui/screens/profile_screen.dart';

class MainHomeScreen extends ConsumerStatefulWidget {
  const MainHomeScreen({super.key});

  @override
  ConsumerState<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends ConsumerState<MainHomeScreen> {
  final List<int> _navigationHistory = [0];

  final List<Widget> _pages = [
    const _DashboardContent(),
    const AllPostsScreen(),
    const DiagnosisOneScreen(),
    const VendorScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = _navigationHistory.last;

    return AppBackground(
      child: PopScope(
        canPop: _navigationHistory.length == 1,
        onPopInvoked: (didPop) {
          if (didPop) return;
          if (_navigationHistory.length > 1) {
            setState(() {
              _navigationHistory.removeLast();
            });
          }
        },
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: IndexedStack(
            index: currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: CurvedBottomNavBar(
            selectedIndex: currentIndex,
            onItemSelected: (index) {
              if (currentIndex != index) {
                setState(() {
                  _navigationHistory.add(index);
                });
              }
            },
            icons: const [
              Icons.home_outlined,
              Icons.chat_outlined,
              Icons.build_outlined,
              Icons.shopping_cart_outlined,
              Icons.person_outline,
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardContent extends ConsumerWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopBarSection(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ActionCard(
                      title: 'Find Mechanics',
                      icon: Icons.car_repair_outlined,
                      // We can link this to Vendor screen if you like,
                      // but typically Vendor is already on the bottom bar (index 3).
                      // For now, I'll leave it or we can link it to vendorRoute explicitly.
                      // onTap: () => ref.read(goRouterProvider).push(getRoutePath(vendorRoute)),
                    ),
                    SizedBox(width: 16),
                    _ActionCard(
                      title: 'Repair Guide',
                      icon: Icons.menu_book_outlined,
                      // --- LINK ADDED HERE ---
                      isRepairGuide: true,
                    ),
                  ],
                ),
              ),
            ),
            _KilometersChartCard(),
            _MaintenanceCard(),
            _TipOfTheDayCard(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _TopBarSection extends ConsumerWidget {
  const _TopBarSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Mendlify',
            style: TextStyle(
              color: appMainTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Hi Rizwan',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: appMainTextColor),
          ),
          const SizedBox(height: 8),
          Text(
            'what do you want to do today?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: appTextColor,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _ActionCard extends ConsumerWidget {
  final String title;
  final IconData icon;
  final bool isRepairGuide; // Helper to trigger navigation

  const _ActionCard({
    required this.title,
    required this.icon,
    this.isRepairGuide = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Card(
        color: appCardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: InkWell(
          onTap: () {
            // --- NAVIGATION LOGIC ---
            if (isRepairGuide) {
              ref.read(goRouterProvider).push(getRoutePath(findGuideRoute));
            } else if (title == 'Find Mechanics') {
              // Optional: Navigate to vendor screen via route push if not using bottom bar
              // ref.read(goRouterProvider).push(getRoutePath(vendorRoute));
            }
          },
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: appButtonColor, size: 36),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: appMainTextColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChartBar extends ConsumerWidget {
  final String label;
  final double value;
  final double maxValue = 20.0;
  final double chartHeight = 150.0;

  const _ChartBar({required this.label, required this.value});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double heightRatio = value / maxValue;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: chartHeight * heightRatio,
          width: 28,
          decoration: BoxDecoration(
            color: appButtonColor,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appTextColor),
        ),
      ],
    );
  }
}

class _KilometersChartCard extends ConsumerWidget {
  const _KilometersChartCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<double> barHeights = [10, 15, 7, 12, 16, 5];
    const List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'June'];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 12.0),
      color: appCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Kilometres Driven', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: appMainTextColor)),
                Text('15,000 km', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: appTextColor)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        if (index == 0) return const SizedBox.shrink();
                        return Divider(
                          color: Colors.white.withOpacity(0.1),
                          thickness: 1,
                        );
                      }),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(barHeights.length, (index) {
                      return _ChartBar(
                        label: months[index],
                        value: barHeights[index],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MaintenanceCard extends ConsumerWidget {
  const _MaintenanceCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      color: appCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Maintenance', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: appMainTextColor)),
            const SizedBox(height: 20),
            Row(
              children: [
                const Expanded(
                  child: Column(
                    children: [
                      _MaintenanceItem(
                        icon: Icons.oil_barrel_outlined,
                        title: 'Oil Change',
                        subtitle: '3 months ago',
                      ),
                      SizedBox(height: 16),
                      _MaintenanceItem(
                        icon: Icons.tire_repair_outlined,
                        title: 'Tire Change',
                        subtitle: '1 year ago',
                      ),
                      SizedBox(height: 16),
                      _MaintenanceItem(
                        icon: Icons.settings_outlined,
                        title: 'Last Service',
                        subtitle: '6 months ago',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: 0.75,
                          strokeWidth: 10,
                          backgroundColor: Colors.white12,
                          valueColor: const AlwaysStoppedAnimation<Color>(appButtonColor),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '75%',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: appMainTextColor,
                            ),
                          ),
                          Text(
                            'Health',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appTextColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MaintenanceItem extends ConsumerWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _MaintenanceItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Icon(icon, color: appButtonColor, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: appMainTextColor)),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: appTextColor)),
          ],
        ),
      ],
    );
  }
}

class _TipOfTheDayCard extends ConsumerWidget {
  const _TipOfTheDayCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      color: appCardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lightbulb_outline, color: appButtonColor, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tip of the day', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: appMainTextColor)),
                  const SizedBox(height: 8),
                  Text(
                    'Change engine oil every 2,000 km for smooth performance',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: appMainTextColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}