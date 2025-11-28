import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';

// Data model for a single post
class Post {
  final String contentTitle;
  final String authorName;
  final int rating;
  final int comments;

  const Post({
    required this.contentTitle,
    required this.authorName,
    required this.rating,
    required this.comments,
  });
}

class MyPostsScreen extends ConsumerWidget {
  const MyPostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sample data for the posts
    final List<Post> samplePosts = const [
      Post(
        contentTitle:
        'After heavy rain, the bike refused to start. The self-start... more',
        authorName: 'Rizwan Ahmed',
        rating: 5,
        comments: 1872,
      ),
      Post(
        contentTitle:
        'My engine is making a strange ticking noise only at high RPMs... more',
        authorName: 'Fatima Waseem',
        rating: 4,
        comments: 550,
      ),
      Post(
        contentTitle:
        'Brake pads are worn down unevenly, should I replace the rotor too? ... more',
        authorName: 'Tariq Khan',
        rating: 3,
        comments: 90,
      ),
      Post(
        contentTitle:
        'Looking for advice on a long-distance bike trip itinerary through the north... more',
        authorName: 'Zainab Ali',
        rating: 5,
        comments: 1200,
      ),
    ];

    return Scaffold(
      backgroundColor: appBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: appMainTextColor, size: 28),
          onPressed: () {
            ref.read(goRouterProvider).pop();
          },
        ),
        title: const Text(
          'My Posts',
          style: TextStyle(
            color: appMainTextColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        itemCount: samplePosts.length,
        itemBuilder: (context, index) {
          final post = samplePosts[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: appCardColor,
              borderRadius: BorderRadius.circular(15.0), // Rounded corners
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Post Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.contentTitle,
                          style: const TextStyle(
                            color: appMainTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          post.authorName,
                          style: const TextStyle(
                            color: appMainTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Row(
                          children: <Widget>[
                            const Icon(Icons.star,
                                color: Color(0xFFE5B800), size: 16), // Gold star
                            const SizedBox(width: 4.0),
                            Text(
                              '${post.rating}',
                              style: TextStyle(
                                color: appTextColor.withAlpha(180),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '|',
                              style: TextStyle(
                                color: appTextColor.withAlpha(180),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '${post.comments} Comments',
                              style: TextStyle(
                                color: appTextColor.withAlpha(180),
                                fontSize: 12,
                              ),
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
        },
      ),
    );
  }
}