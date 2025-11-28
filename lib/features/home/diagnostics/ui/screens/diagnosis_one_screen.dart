import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';

import '../../../../../core/route/go_router_provider.dart';
import '../../../../../core/route/route_names.dart';

class DiagnosisOneScreen extends ConsumerStatefulWidget {
  const DiagnosisOneScreen({super.key});

  @override
  ConsumerState<DiagnosisOneScreen> createState() => _DiagnosisOneScreenState();
}

class _DiagnosisOneScreenState extends ConsumerState<DiagnosisOneScreen> {
  String? _selectedIssue;

  final List<String> issues = const [
    'Engine won\'t start',
    'Strange noises',
    'Overheating',
    'Brakes feel off',
    'Other',
  ];

  Widget _buildIssueTile(String issue) {
    final bool isSelected = _selectedIssue == issue;

    final Color tileColor =
    isSelected ? appMainTextColor.withOpacity(0.3) : appCardColor;

    final Color textColor = isSelected ? appMainTextColor : appTextColor;

    return Card(
      elevation: 0,
      color: tileColor,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            if (isSelected) {
              _selectedIssue = null;
            } else {
              _selectedIssue = issue;
            }
          });
        },
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          alignment: Alignment.centerLeft,
          child: Text(
            issue,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // --- Header Text ---
            const SizedBox(height: 20),
            const Text(
              'Welcome to Bike Diagnostic Expert',
              style: TextStyle(
                color: appMainTextColor,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 48.0),

            // --- Question Text ---
            const Text(
              'What is the primary issue?',
              style: TextStyle(
                color: appMainTextColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24.0),

            // --- Issue Selection Options ---
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: issues.map((issue) => _buildIssueTile(issue)).toList(),
                ),
              ),
            ),
            const SizedBox(height: 32.0),

            // --- Next Button ---
            SizedBox(
              height: 60.0,
              child: ElevatedButton(
                // Button remains disabled if nothing is selected
                onPressed: _selectedIssue == null
                    ? null
                    : () {
                  // Navigate to the next diagnosis screen
                   ref.read(goRouterProvider).push(getRoutePath(diagnosisTwoRoute));
                  print('Next button pressed for issue: $_selectedIssue');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appButtonColor,
                  // Disabled color styling
                  disabledBackgroundColor: appButtonColor.withOpacity(0.5),
                  disabledForegroundColor: Colors.white.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // Bottom padding
          ],
        ),
      ),
    );
  }
}