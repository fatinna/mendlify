import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';

class AddGuideScreen extends ConsumerStatefulWidget {
  const AddGuideScreen({super.key});

  @override
  ConsumerState<AddGuideScreen> createState() => _AddGuideScreenState();
}

class _AddGuideScreenState extends ConsumerState<AddGuideScreen> {
  // Controllers for the input fields
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _stepsController;
  late TextEditingController _solutionController;
  late TextEditingController _partsController;
  late TextEditingController _costController;
  late TextEditingController _mechanicController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _stepsController = TextEditingController();
    _solutionController = TextEditingController();
    _partsController = TextEditingController();
    _costController = TextEditingController();
    _mechanicController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _stepsController.dispose();
    _solutionController.dispose();
    _partsController.dispose();
    _costController.dispose();
    _mechanicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: appMainTextColor),
            onPressed: () {
              ref.read(goRouterProvider).pop();
            },
          ),
          title: const Text(
            'Add Guide',
            style: TextStyle(
              color: appMainTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title of Problem
              _CustomInputField(
                controller: _titleController,
                hintText: 'Title of Problem',
              ),

              // Describe the Problem
              _CustomInputField(
                controller: _descriptionController,
                hintText: 'Describe the Problem',
                isMultiLine: true,
                maxLines: 5,
              ),

              // Steps Taken
              _CustomInputField(
                controller: _stepsController,
                hintText: 'Steps Taken to Diagnose the Problem',
                isMultiLine: true,
                maxLines: 5,
              ),

              // Solution Applied
              _CustomInputField(
                controller: _solutionController,
                hintText: 'Solution Applied',
                isMultiLine: true,
                maxLines: 5,
              ),

              // Parts/Tools Used
              _CustomInputField(
                controller: _partsController,
                hintText: 'Parts/Tools Used (if any)',
                isMultiLine: true,
                maxLines: 3,
              ),

              // Cost of Repair
              _CustomInputField(
                controller: _costController,
                hintText: 'Cost of Repair (if any)',
              ),

              // Pictures or Videos (Simulated Input Field)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: InkWell(
                  onTap: () {
                    print('Pictures or Videos tapped');
                  },
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      color: appCardColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pictures or Videos',
                          style: TextStyle(
                            color: appTextColor.withAlpha(180),
                            fontSize: 16,
                          ),
                        ),
                        const Icon(
                          Icons.camera_alt_outlined,
                          color: appMainTextColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Mechanic/Shop Recommendation
              _CustomInputField(
                controller: _mechanicController,
                hintText:
                'Any trusted mechanic, shop, or source you\'d recommend?',
              ),

              const SizedBox(height: 32),

              // Post Button
              ElevatedButton(
                onPressed: () {
                  print('Post Guide button pressed');
                  // Add logic to save guide
                  ref.read(goRouterProvider).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: appButtonColor,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

// --- Helper Widget for Input Fields ---
class _CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isMultiLine;
  final int maxLines;

  const _CustomInputField({
    required this.controller,
    required this.hintText,
    this.isMultiLine = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiLine ? null : 1,
        minLines: isMultiLine ? maxLines : 1,
        keyboardType:
        isMultiLine ? TextInputType.multiline : TextInputType.text,
        style: const TextStyle(color: appMainTextColor),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: appTextColor.withAlpha(180)),
          fillColor: appCardColor,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: isMultiLine
              ? const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0)
              : const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
        ),
      ),
    );
  }
}