import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';

// --- Data Model for History Entries ---
class DiagnosisEntry {
  final String id;
  final String title;
  final DateTime date;
  final String description;

  DiagnosisEntry({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
  });
}

class DiagnosisHistoryScreen extends ConsumerStatefulWidget {
  const DiagnosisHistoryScreen({super.key});

  @override
  ConsumerState<DiagnosisHistoryScreen> createState() =>
      _DiagnosisHistoryScreenState();
}

class _DiagnosisHistoryScreenState
    extends ConsumerState<DiagnosisHistoryScreen> {
  // Mock data to populate the list
  List<DiagnosisEntry> historyEntries = [
    DiagnosisEntry(
      id: '1',
      title: 'Probable Diagnosis',
      date: DateTime(2025, 2, 7),
      description:
      'Your bike likely has loose valve clearance (sometimes called tappet noise). This is a normal wear issue and happens when the gap between the valve and rocker arm gets bigger with time.',
    ),
    DiagnosisEntry(
      id: '2',
      title: 'Probable Diagnosis',
      date: DateTime(2025, 1, 15),
      description:
      'Possible issue with the clutch cable tension or worn clutch plates. Check the free play on the clutch lever.',
    ),
    DiagnosisEntry(
      id: '3',
      title: 'Probable Diagnosis',
      date: DateTime(2024, 11, 20),
      description:
      'Tire pressure low in the rear wheel. Recommended pressure for your model is 32 PSI.',
    ),
  ];

  // Helper function to format the date as DD/MM/YYYY
  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // Function for deleting an entry
  void _deleteEntry(String id) {
    setState(() {
      historyEntries.removeWhere((entry) => entry.id == id);
    });
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
          'History',
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
        itemCount: historyEntries.length,
        itemBuilder: (context, index) {
          final entry = historyEntries[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: DiagnosisCard(
              entry: entry,
              formattedDate: _formatDate(entry.date),
              onDelete: () => _deleteEntry(entry.id),
            ),
          );
        },
      ),
    );
  }
}

// Reusable Widget for displaying a single diagnosis entry card
class DiagnosisCard extends StatelessWidget {
  final DiagnosisEntry entry;
  final String formattedDate;
  final VoidCallback onDelete;

  const DiagnosisCard({
    super.key,
    required this.entry,
    required this.formattedDate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: appCardColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(50),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Delete Button Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                entry.title,
                style: const TextStyle(
                  color: appMainTextColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: onDelete,
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: appMainTextColor, // Keeping high contrast
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),

          // Date
          Text(
            formattedDate,
            style: TextStyle(
              color: appTextColor.withAlpha(180), // Subtitle color effect
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            entry.description,
            style: const TextStyle(
              color: appMainTextColor,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}