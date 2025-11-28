import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';

// --- Data Model for Guide Entries ---
enum GuideStatus { approved, pending, rejected }

class GuideEntry {
  final String id;
  final String title;
  final DateTime date;
  final String description;
  final GuideStatus status;

  GuideEntry({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
    required this.status,
  });
}

class MyGuidesScreen extends ConsumerStatefulWidget {
  const MyGuidesScreen({super.key});

  @override
  ConsumerState<MyGuidesScreen> createState() => _MyGuidesScreenState();
}

class _MyGuidesScreenState extends ConsumerState<MyGuidesScreen> {
  // Mock data to populate the list with different statuses
  List<GuideEntry> guideEntries = [
    GuideEntry(
      id: '1',
      title: 'Engine Overheating',
      date: DateTime(2025, 2, 7),
      description:
      'The vehicle\'s engine temperature is consistently rising above the normal operating range, indicating a potential cooling system failure.',
      status: GuideStatus.approved,
    ),
    GuideEntry(
      id: '2',
      title: 'Engine Overheating',
      date: DateTime(2025, 2, 7),
      description:
      'The vehicle\'s engine temperature is consistently rising above the normal operating range, indicating a potential cooling system failure.',
      status: GuideStatus.pending,
    ),
    GuideEntry(
      id: '3',
      title: 'Engine Overheating',
      date: DateTime(2025, 2, 7),
      description:
      'The vehicle\'s engine temperature is consistently rising above the normal operating range, indicating a potential cooling system failure.',
      status: GuideStatus.rejected,
    ),
    GuideEntry(
      id: '4',
      title: 'Tire Pressure Check',
      date: DateTime(2025, 1, 15),
      description:
      'Guide to checking and adjusting tire pressure to optimal levels for safety and performance.',
      status: GuideStatus.approved,
    ),
  ];

  // Helper function to format the date as DD/MM/YYYY
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // Function for deleting an entry
  void _deleteEntry(String id) {
    setState(() {
      guideEntries.removeWhere((entry) => entry.id == id);
    });
  }

  // Placeholder function for viewing the guide
  void _viewGuide(String id) {
    // Actual navigation/guide display logic would go here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Guides',
          style: TextStyle(
            color: appMainTextColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appMainTextColor),
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: guideEntries.length,
        itemBuilder: (context, index) {
          final entry = guideEntries[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: GuideCard(
              entry: entry,
              formattedDate: _formatDate(entry.date),
              onDelete: () => _deleteEntry(entry.id),
              onViewGuide: () => _viewGuide(entry.id),
            ),
          );
        },
      ),
    );
  }
}

// Reusable Widget for displaying a single guide entry card
class GuideCard extends StatelessWidget {
  final GuideEntry entry;
  final String formattedDate;
  final VoidCallback onDelete;
  final VoidCallback onViewGuide;

  const GuideCard({
    super.key,
    required this.entry,
    required this.formattedDate,
    required this.onDelete,
    required this.onViewGuide,
  });

  Map<String, dynamic> _getStatusStyle() {
    switch (entry.status) {
      case GuideStatus.approved:
        return {'text': 'Approved', 'color': appApproveColor};
      case GuideStatus.pending:
        return {'text': 'Pending', 'color': appPendingColor};
      case GuideStatus.rejected:
      // Using the appButtonColor (Red) for rejected status
        return {'text': 'Rejected', 'color': appButtonColor};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle();
    final statusText = statusStyle['text'] as String;
    final statusColor = statusStyle['color'] as Color;

    return Container(
      decoration: BoxDecoration(
        color: appCardColor,
        borderRadius: BorderRadius.circular(15), // Updated to match other screens
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50), // Replaces withOpacity(0.2)
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Title and Status Tag
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    entry.title,
                    style: const TextStyle(
                      color: appMainTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Status Tag
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(
                      color: entry.status == GuideStatus.pending
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),

            // Row 2: Date
            Text(
              formattedDate,
              style: TextStyle(
                color: appTextColor.withAlpha(180), // Similar to Colors.white70
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),

            // Row 3: Description
            Text(
              entry.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: appMainTextColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),

            // Row 4: Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Delete Button
                TextButton(
                  onPressed: onDelete,
                  style: TextButton.styleFrom(
                    foregroundColor: appButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: appButtonColor, width: 1),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  child: const Text('Delete',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 8),

                // View Guide Button
                ElevatedButton(
                  onPressed: onViewGuide,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appButtonColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                  ),
                  child: const Text('View Guide',
                      style:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}