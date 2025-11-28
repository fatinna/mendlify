import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/core/utils/image_resources.dart'; // Placeholder for images
import 'package:mendlify/shared/widgets/app_background.dart';
import 'package:mendlify/shared/widgets/app_image.dart';

class GuideDetailScreen extends ConsumerStatefulWidget {
  const GuideDetailScreen({super.key});

  @override
  ConsumerState<GuideDetailScreen> createState() => _GuideDetailScreenState();
}

class _GuideDetailScreenState extends ConsumerState<GuideDetailScreen> {
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

  // --- Helper Widgets ---

  Widget _buildCard(Widget child) {
    return Card(
      elevation: 5,
      color: appCardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildProblemDetailsCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(
          title: "Bike Won't Start After Rain",
          subtitle: "Posted by Anas Tawneer . 2 days ago",
          showAvatar: true,
        ),
        const SizedBox(height: 20),
        _buildSectionHeader('Problem Details', appButtonColor),
        _buildDetailSection(
          'Description:',
          "After heavy rain, the bike refused to start. The self-start didn't work and even with the kick, it wouldn't fire up. Headlight and indicators were dim.",
        ),
      ],
    );
  }

  Widget _buildSolutionAndStatsCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Solution Provided', appButtonColor),
        _buildDetailSection(
          'Diagnosis:',
          'Checked spark plug condition, ignition coil, and wiring. Found moisture inside the plug cap and ignition wiring.',
        ),
        const Divider(color: Colors.white24, height: 30, thickness: 1),
        _buildDetailSection(
          'Fix:',
          'Dried the spark plug, plug cap, and ignition coil with a clean cloth. Used a hair dryer to remove moisture. Applied dielectric grease to spark plug cap and sprayed WD-40 on exposed connectors to prevent water entry.',
        ),
        const Divider(color: Colors.white24, height: 30, thickness: 1),
        _buildDetailSection(
          'Parts/Tools:',
          'WD-40 spray, dielectric grease, clean cloth, hair dryer.',
        ),
        const SizedBox(height: 15),
        _buildStatRow('Time Taken:', '45 minutes'),
        _buildStatRow('Cost:', '500 PKR'),
        const Divider(color: Colors.white24, height: 30, thickness: 1),
        Row(
          children: const [
            Icon(Icons.thumb_up_alt, color: appButtonColor, size: 24),
            SizedBox(width: 15),
            Icon(Icons.comment_outlined, color: Colors.white70, size: 24),
          ],
        )
      ],
    );
  }

  Widget _buildImagePlaceholderCard() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: appCardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.image_outlined, size: 50, color: Colors.white54),
          SizedBox(height: 8),
          Text('Image Placeholder', style: TextStyle(color: Colors.white54)),
        ],
      ),
    );
  }

  Widget _buildExtraRecommendationCardContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Extra', appButtonColor),
        _buildDetailSection(
          'Mechanic Recommendation:',
          'Local Yamaha Service Center',
        ),
      ],
    );
  }

  Widget _buildHeader({
    required String title,
    required String subtitle,
    bool showAvatar = false,
  }) {
    return Row(
      children: [
        if (showAvatar)
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 25,
              // Use AppImage or placeholder icon
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: appMainTextColor,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: appTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 15, color: Colors.white70),
            children: [
              TextSpan(
                text: '$title ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: appMainTextColor,
                ),
              ),
              TextSpan(text: content),
            ],
          ),
        ),
        const SizedBox(height: 4),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: appMainTextColor,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentsSection() {
    final List<Map<String, String>> sampleComments = [
      {
        'name': 'Rizwan Ahmed',
        'time': '. 2 days ago',
        'text':
        'Check your spark plugs and ignition system. Moisture can cause issues there.',
      },
      {
        'name': 'Rizwan Ahmed',
        'time': '. 2 days ago',
        'text':
        'Check your spark plugs and ignition system. Moisture can cause issues there.',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Comments', appButtonColor),
        ...sampleComments
            .map((comment) => _buildCommentTile(comment))
            .toList(),
      ],
    );
  }

  Widget _buildCommentTile(Map<String, String> comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color:appMainTextColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        comment['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: appMainTextColor,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        ' ${comment['time']!}',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    comment['text']!,
                    style: const TextStyle(
                      color: appMainTextColor,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentInputBar() {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.transparent,
      child: SafeArea(
        child: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, color: Colors.white),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    hintText: 'Add a comment...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(color: appMainTextColor),
                ),
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.send, color: appButtonColor, size: 28),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This allows us to use the go_router provider if needed
    // final route = ref.watch(goRouterProvider);

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
            'Repair Guide',
            style: TextStyle(
              color: appMainTextColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildCard(_buildProblemDetailsCardContent()),
                      const SizedBox(height: 16),
                      _buildCard(_buildSolutionAndStatsCardContent()),
                      const SizedBox(height: 16),
                      _buildImagePlaceholderCard(),
                      const SizedBox(height: 16),
                      _buildCard(_buildExtraRecommendationCardContent()),
                      const SizedBox(height: 16),
                      _buildCard(_buildCommentsSection()),
                    ],
                  ),
                ),
              ),
            ),
            _buildCommentInputBar(),
          ],
        ),
      ),
    );
  }
}