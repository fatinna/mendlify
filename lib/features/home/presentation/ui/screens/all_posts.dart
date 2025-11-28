import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/shared/widgets/app_image.dart';

import '../../../../../core/route/go_router_provider.dart';
import '../../../../../core/route/route_names.dart';

class AllPostsScreen extends ConsumerWidget {
  const AllPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final route = ref.watch(goRouterProvider);

    final posts = [
      {
        'image': fatimaImagePath,
        'title': 'After heavy rain, the bike refused to start. The self-start...',
        'author': 'Rizwan Ahmed',
        'rating': 5,
        'comments': 1872,
      },
      {
        'image': fatimaImagePath, // Replace with actual user image
        'title': 'My bike is making a weird rattling sound near the engine...',
        'author': 'Anas Tanweer',
        'rating': 5,
        'comments': 1872,
      },
      {
        'image': fatimaImagePath, // Replace with actual user image
        'title': 'Best way to clean a rusty chain? Looking for DIY hacks...',
        'author': 'Fatima Waseem',
        'rating': 5,
        'comments': 1872,
      },
      {
        'image': fatimaImagePath, // Replace with actual user image
        'title': 'Any recommendations for long-distance touring tires?',
        'author': 'Abdullah Mohsin Ali',
        'rating': 5,
        'comments': 1872,
      },
    ];
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: appMainTextColor),
                      onPressed: () {
                        // This will be handled by your MainHomeScreen's back logic
                        // Or, if this screen was pushed, pop it:
                        if (route.canPop()) {
                          route.pop();
                        }
                      },
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'All Posts',
                          style: TextStyle(
                            color: appMainTextColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: appCardColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const TextField(
                    style: TextStyle(color: appMainTextColor),
                    decoration: InputDecoration(
                      hintText: 'Search issue...',
                      hintStyle: TextStyle(color: appTextColor),
                      prefixIcon: Icon(Icons.search, color: appTextColor),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return _PostCard(
                      imagePath: post['image'] as String,
                      title: post['title'] as String,
                      author: post['author'] as String,
                      rating: post['rating'] as int,
                      comments: post['comments'] as int,
                      onTap: () {
                        // --- NAVIGATION ADDED ---
                        // You might also want to pass the post ID or data
                        // route.push(getRoutePath(postDetailRoute), extra: post);
                        route.push(getRoutePath(postDetailRoute));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
            child: FloatingActionButton(
              onPressed: () {
                route.push(getRoutePath(newPostRoute));
              },
              backgroundColor: appButtonColor,
              child: const Icon(Icons.add, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String author;
  final int rating;
  final int comments;
  final VoidCallback onTap; // <-- Added onTap

  const _PostCard({
    required this.imagePath,
    required this.title,
    required this.author,
    required this.rating,
    required this.comments,
    required this.onTap, // <-- Added onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell( // <-- Wrapped in InkWell
      onTap: onTap, // <-- Added onTap functionality
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: appCardColor,
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            ClipOval(
              child: AppImage(
                path: imagePath,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            // Post Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: appMainTextColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    author,
                    style: const TextStyle(
                      color: appTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: const TextStyle(color: appTextColor, fontSize: 13),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '|   ${comments.toString()} Comments',
                        style: const TextStyle(color: appTextColor, fontSize: 13),
                      ),
                    ],
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

