import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';

class EditPersonalInfoScreen extends ConsumerStatefulWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  ConsumerState<EditPersonalInfoScreen> createState() =>
      _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState
    extends ConsumerState<EditPersonalInfoScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  final List<String> _countryCodes = [
    '+1 (USA)',
    '+44 (UK)',
    '+92 (PK)',
    '+91 (IND)',
    '+49 (GER)',
    '+33 (FRA)',
    '+81 (JPN)',
  ];
  String? _selectedCountryCode = '+92 (PK)';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget buildInputField(String hintText, TextEditingController controller,
      {Widget? prefixIcon}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: appMainTextColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: appTextColor.withAlpha(150)),
          filled: true,
          fillColor: appCardColor,
          prefixIcon: prefixIcon != null
              ? Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 12.0),
            child: prefixIcon,
          )
              : null,
          prefixIconConstraints:
          const BoxConstraints(minWidth: 0, minHeight: 0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding:
          const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- Header ---
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // Back Button (Fixed on Left)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: appMainTextColor, size: 28),
                      onPressed: () {
                        ref.read(goRouterProvider).pop();
                      },
                    ),
                  ),
                  // Title (Centered)
                  const Text(
                    'Edit profile',
                    style: TextStyle(
                      color: appMainTextColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32.0),

              // --- Profile Avatar Section ---
              Center(
                child: Stack(
                  children: <Widget>[
                    const CircleAvatar(
                      radius: 60,
                      backgroundColor: appCardColor,
                      child: Icon(Icons.person, size: 70, color: appTextColor),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: appButtonColor,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48.0),

              // --- Form Fields ---
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      buildInputField('Full name', _nameController),
                      buildInputField('Email', _emailController),

                      // Phone Number Row
                      Row(
                        children: [
                          // Country Code Dropdown
                          Container(
                            margin:
                            const EdgeInsets.only(right: 8.0, bottom: 16.0),
                            padding:
                            const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: appCardColor,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: _selectedCountryCode,
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: appTextColor),
                                dropdownColor: appCardColor,
                                style: const TextStyle(
                                    color: appMainTextColor, fontSize: 16),
                                items: _countryCodes.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value.split(' ')[0]),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedCountryCode = newValue;
                                  });
                                },
                              ),
                            ),
                          ),

                          // Phone Number Input
                          Expanded(
                            child: buildInputField(
                                'Phone Number', _phoneController),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8.0),

                      // Reset Password Link
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Handle reset password logic
                          },
                          child: const Text(
                            'Reset Password?',
                            style: TextStyle(
                              color: appMainTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24.0),

              // --- Save Button ---
              SizedBox(
                height: 60.0,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle save logic
                    ref.read(goRouterProvider).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: appButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}