import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/route/route_names.dart'; // Added import for route names
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';

class NewPostScreen extends ConsumerStatefulWidget {
  const NewPostScreen({super.key});

  @override
  ConsumerState<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends ConsumerState<NewPostScreen> {
  late TextEditingController _postController;

  @override
  void initState() {
    super.initState();
    _postController = TextEditingController();
  }

  @override
  void dispose() {
    _postController.dispose();
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
          title: const Text(
            'New Post',
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
              // 1. Large Text Area ("Add")
              Container(
                height: 200, // Fixed height similar to the image
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: appCardColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: _postController,
                  decoration: const InputDecoration(
                    hintText: 'Add',
                    hintStyle: TextStyle(
                      color: appTextColor,
                      fontSize: 16,
                    ),
                    border: InputBorder.none, // Removes the default text field border
                    contentPadding: EdgeInsets.zero,
                  ),
                  // Updated text color to appCardColor as requested
                  style: const TextStyle(color: appCardColor, fontSize: 16),
                  maxLines: null, // Allows for multiline input
                  expands: true, // Takes up the container's height
                  keyboardType: TextInputType.multiline,
                ),
              ),
              const SizedBox(height: 24),

              // 2. Pictures or Videos Button
              InkWell(
                onTap: () {
                  print('Pictures or Videos selected');
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: appCardColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Pictures or Videos',
                        style: TextStyle(
                          color: appMainTextColor,
                          fontSize: 16,
                        ),
                      ),
                      Icon(
                        Icons.add_box_outlined, // Icon matching the image
                        color: appTextColor,
                      ),
                    ],
                  ),
                ),
              ),

              // Spacer to push the Post button to the bottom
              SizedBox(height: MediaQuery.of(context).size.height * 0.4),

              // 3. Post Button (Long button with circular radius)
              ElevatedButton(
                onPressed: () {
                  // Implement post logic here
                  print('Post button pressed!');
                  // Navigate to Post Detail Screen
                  ref.read(goRouterProvider).push(getRoutePath(postDetailRoute));
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
                  'Post',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
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