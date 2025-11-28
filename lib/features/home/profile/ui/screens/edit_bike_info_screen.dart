import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';

class EditBikeInfoScreen extends ConsumerStatefulWidget {
  const EditBikeInfoScreen({super.key});

  @override
  ConsumerState<EditBikeInfoScreen> createState() => _EditBikeInfoScreenState();
}

class _EditBikeInfoScreenState extends ConsumerState<EditBikeInfoScreen> {
  // State variables for text inputs
  late TextEditingController _brandController;
  late TextEditingController _modelController;
  late TextEditingController _yearController;

  // State variables for the date inputs
  DateTime? _lastServiceDate;
  DateTime? _lastTireChangeDate;
  DateTime? _lastOilChangeDate;

  @override
  void initState() {
    super.initState();
    _brandController = TextEditingController();
    _modelController = TextEditingController();
    _yearController = TextEditingController();
  }

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  // Helper function to format the date
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  // Generic function to show the date picker and update state
  Future<void> _selectDate(
      BuildContext context, ValueChanged<DateTime> onDateSelected) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        // Apply custom theme to the DatePicker dialog using your app colors
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: appButtonColor, // Header background & selected day
              onPrimary: Colors.white, // Text on primary
              surface: appCardColor, // Calendar background
              onSurface: appMainTextColor, // Calendar text
            ),
            dialogBackgroundColor: appBackgroundColor,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Ensures the background color shows through
        elevation: 0, // Removes the shadow
        centerTitle: true, // Centers the title horizontally
        title: const Text(
          'Enter your Bike Info',
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. Bike Brand
            _StyledTextField(
              controller: _brandController,
              labelText: 'Bike Brand',
            ),
            const SizedBox(height: 16),

            // 2. Model
            _StyledTextField(
              controller: _modelController,
              labelText: 'Model',
            ),
            const SizedBox(height: 16),

            // 3. Year
            _StyledTextField(
              controller: _yearController,
              labelText: 'Year',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24), // Extra space before dates

            // 4. Last Service Date
            _DateInputField(
              labelText: 'Last Service Date',
              dateText: _formatDate(_lastServiceDate),
              onTap: () => _selectDate(context, (date) {
                setState(() {
                  _lastServiceDate = date;
                });
              }),
            ),
            const SizedBox(height: 16),

            // 5. Last Tire Change
            _DateInputField(
              labelText: 'Last Tire Change',
              dateText: _formatDate(_lastTireChangeDate),
              onTap: () => _selectDate(context, (date) {
                setState(() {
                  _lastTireChangeDate = date;
                });
              }),
            ),
            const SizedBox(height: 16),

            // 6. Last Oil Change
            _DateInputField(
              labelText: 'Last Oil Change',
              dateText: _formatDate(_lastOilChangeDate),
              onTap: () => _selectDate(context, (date) {
                setState(() {
                  _lastOilChangeDate = date;
                });
              }),
            ),

            const SizedBox(height: 60),

            // Save Button
            ElevatedButton(
              onPressed: () {
                // Implement save logic here
                // print('Brand: ${_brandController.text}');
                // print('Service Date: ${_formatDate(_lastServiceDate)}');
                ref.read(goRouterProvider).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: appButtonColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 8,
              ),
              child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Custom widget for the standard text input fields
class _StyledTextField extends StatelessWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController? controller;

  const _StyledTextField({
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(color: appMainTextColor),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: appTextColor.withOpacity(0.7)),
        filled: true,
        fillColor: appCardColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none, // Hide default border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: appButtonColor, width: 2), // Accent color focus
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      ),
    );
  }
}

// Custom widget for the date input fields (simulating a non-editable field with an icon)
class _DateInputField extends StatelessWidget {
  final String labelText;
  final String dateText;
  final VoidCallback onTap;

  const _DateInputField({
    required this.labelText,
    required this.dateText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: appCardColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Display the label or the selected date
            Text(
              dateText.isEmpty ? labelText : dateText,
              style: TextStyle(
                color: dateText.isEmpty
                    ? appTextColor.withOpacity(0.7)
                    : appMainTextColor,
                fontSize: 16,
              ),
            ),
            // Calendar Icon
            Icon(
              Icons.calendar_today_outlined,
              color: appTextColor.withOpacity(0.7),
            ),
          ],
        ),
      ),
    );
  }
}