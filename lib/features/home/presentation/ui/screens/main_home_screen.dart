import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/bottom_navbar.dart';

// --- Theme Colors from your app's theme ---
const Color kCardBackground = Color(0xFF1B2A41);
const Color kAccentRed = Color(0xFFD90429);
const Color kTextPrimary = Colors.white;
const Color kTextSecondary = Color(0xFFB0BEC5);

class MainHomeScreen extends ConsumerStatefulWidget {
  const MainHomeScreen({super.key});

  @override
  ConsumerState<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends ConsumerState<MainHomeScreen> {
  int _currentIndex = 0;

  // Placeholder pages for each nav bar item
  final List<Widget> _pages = [
    const _DashboardContent(), // Your main dashboard content
    const Center(child: Text('Chat Page', style: TextStyle(color: kTextPrimary))),
    const Center(child: Text('Service Page', style: TextStyle(color: kTextPrimary))),
    const Center(child: Text('History Page', style: TextStyle(color: kTextPrimary))),
    const Center(child: Text('Profile Page', style: TextStyle(color: kTextPrimary))),
  ];

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Important for the background to show
        body: IndexedStack(
          index: _currentIndex,
          children: _pages,
        ),
        bottomNavigationBar: AnimatedBottomNavBar(
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            NavBarItem(icon: Icons.home_outlined, label: 'Home'),
            NavBarItem(icon: Icons.chat_outlined, label: 'Chat'),
            NavBarItem(icon: Icons.build_outlined, label: 'Service'),
            NavBarItem(icon: Icons.history_outlined, label: 'History'),
            NavBarItem(icon: Icons.person_outline, label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// The main content of your dashboard
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
              child: Row(
                children: [
                  _ActionCard(
                    title: 'Find Mechanics',
                    icon: Icons.car_repair_outlined,
                  ),
                  SizedBox(width: 16),
                  _ActionCard(
                    title: 'Repair Guide',
                    icon: Icons.menu_book_outlined,
                  ),
                ],
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


// --- All the sub-widgets from your provided code ---

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
              color: kTextPrimary,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Hi Rizwan',
            style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 32, color: kTextPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            'what do you want to do today?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: kTextSecondary,
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

  const _ActionCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Card(
        color: kCardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: kAccentRed, size: 36),
                const SizedBox(height: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kTextPrimary),
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
          width: 16,
          decoration: BoxDecoration(
            color: kAccentRed,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kTextSecondary),
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
      color: kCardBackground,
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
                Text('Kilometres Driven', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: kTextPrimary)),
                Text('15,000 km', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kTextSecondary)),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 180,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(barHeights.length, (index) {
                  return _ChartBar(
                    label: months[index],
                    value: barHeights[index],
                  );
                }),
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
      color: kCardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Maintenance', style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: kTextPrimary)),
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
                          valueColor: const AlwaysStoppedAnimation<Color>(kAccentRed),
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
                              color: kTextPrimary,
                            ),
                          ),
                          Text(
                            'Health',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kTextSecondary),
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
        Icon(icon, color: kAccentRed, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kTextPrimary)),
            Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: kTextSecondary)),
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
      color: kCardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.lightbulb_outline, color: kAccentRed, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tip of the day', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: kTextPrimary)),
                  const SizedBox(height: 8),
                  Text(
                    'Change engine oil every 2,000 km for smooth performance',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: kTextPrimary),
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
