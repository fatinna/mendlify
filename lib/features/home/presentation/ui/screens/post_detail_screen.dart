import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/core/utils/image_resources.dart';
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/app_image.dart';
// Import your custom text form field
import 'package:mendlify/shared/widgets/app_text_form_field.dart';

class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key});

  // final String postId;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  late final TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Dummy data for comments
    final comments = [
      {
        'image': anasImagePath,
        'author': 'Rizwan Ahmed',
        'date': '2 days ago',
        'comment':
        'Agar knocking ho rahi hai to petrol quality bhi dekh lo, low-grade fuel se bhi hota hai.',
      },
      {
        'image': abdullahImagePath,
        'author': 'Rizwan Ahmed',
        'date': '2 days ago',
        'comment':
        'Fuel line check karo, mere sath bhi yehi scene tha, petrol flow ruk ruk ke aa raha tha.',
      },
    ];

    return AppBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(top: 20.0, left: 16.0, right: 16.0),
              child: Row(
                children: [
                  IconButton(
                    icon:
                    const Icon(Icons.arrow_back, color: appMainTextColor),
                    onPressed: () {
                      ref.read(goRouterProvider).pop();
                    },
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Post',
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
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: appCardColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipOval(
                                child: AppImage(
                                  path: fatimaImagePath,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bike Won\'t Start After Rain',
                                    style: TextStyle(
                                      color: appMainTextColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Posted by Anas Tawneer - 2 days ago',
                                    style: TextStyle(
                                      color: appTextColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Guys meri bike ka ek ajeeb issue chal raha hai. Jab start karta hoon to thik chalti hai, lekin thodi der baad pick drop ho jata hai aur engine se halki si knocking jesi awaaz aati hai. Kabhi kabhi idle pe bhi band ho jati hai.\n\nSpark plug aur air filter dono clean hain, tuning bhi recently karwai thi, phir bhi issue waisa hi hai. Lagta hai fuel supply ya carburetor ka masla hai, but not sure. Koi suggest kar sakta hai kya check karwaun?',
                            style: TextStyle(
                              color: appMainTextColor,
                              fontSize: 15,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Icon(Icons.thumb_up_alt_outlined,
                                  color: appButtonColor, size: 24),
                              const SizedBox(width: 8),
                              const Text('12',
                                  style: TextStyle(color: appTextColor)),
                              const SizedBox(width: 24),
                              Icon(Icons.chat_bubble_outline,
                                  color: appTextColor, size: 24),
                              const SizedBox(width: 8),
                              const Text('2',
                                  style: TextStyle(color: appTextColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    const Text(
                      'Comments',
                      style: TextStyle(
                        color: appMainTextColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListView.builder(
                      itemCount: comments.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return _CommentTile(
                          imagePath: comment['image'] as String,
                          author: comment['author'] as String,
                          date: comment['date'] as String,
                          comment: comment['comment'] as String,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            _AddCommentBar(controller: _commentController),
          ],
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  final String imagePath;
  final String author;
  final String date;
  final String comment;

  const _CommentTile({
    required this.imagePath,
    required this.author,
    required this.date,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 12.0),
      decoration: BoxDecoration(
        color: appCardColor.withAlpha(150),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: AppImage(
              path: imagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      author,
                      style: const TextStyle(
                        color: appMainTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: const TextStyle(
                        color: appTextColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  comment,
                  style: const TextStyle(
                    color: appMainTextColor,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddCommentBar extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const _AddCommentBar({required this.controller});

  @override
  ConsumerState<_AddCommentBar> createState() => _AddCommentBarState();
}

class _AddCommentBarState extends ConsumerState<_AddCommentBar> {
  late final FocusNode _commentFocusNode;

  @override
  void initState() {
    super.initState();
    _commentFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _commentFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)
          .copyWith(
        bottom: MediaQuery.of(context).padding.bottom +
            12.0,
      ),

      decoration: const BoxDecoration(
        color: Colors.transparent,
        border: Border(
          top: BorderSide(color: appCardColor, width: 1.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const ClipOval(
            child: AppImage(
              path: rizwanImagePath,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppTextFormField(
              controller: widget.controller,
              focusNode: _commentFocusNode,
              hint: 'Add a comment...',

            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 24,
            backgroundColor: appButtonColor,
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white, size: 22),
              onPressed: () {
                // Handle send comment
              },
            ),
          ),
        ],
      ),
    );
  }
}

