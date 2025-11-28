import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mendlify/core/route/go_router_provider.dart';
import 'package:mendlify/core/route/route_names.dart';
import 'package:mendlify/core/utils/theme/app_colors.dart';
import 'package:mendlify/shared/widgets/app_background.dart';

class RepairGuide {
  final String title;
  final String author;
  final String imageUrl;
  final double rating;
  final int reviews;

  const RepairGuide({
    required this.title,
    required this.author,
    required this.imageUrl,
    this.rating = 5.0,
    this.reviews = 1872,
  });
}

class FindGuideScreen extends ConsumerStatefulWidget {
  const FindGuideScreen({super.key});

  @override
  ConsumerState<FindGuideScreen> createState() => _FindGuideScreenState();
}

class _FindGuideScreenState extends ConsumerState<FindGuideScreen> {
  String _searchText = '';

  // Placeholder Data
  final List<RepairGuide> sampleGuides = const [
    RepairGuide(
      title: 'Oil Leakage',
      author: 'Rizwan Ahmed',
      imageUrl: 'https://placehold.co/100x100/A0B9C6/000000?text=Oil',
    ),
    RepairGuide(
      title: 'Spark Plug',
      author: 'Anas Tanweer',
      imageUrl: 'https://placehold.co/100x100/6A7B8C/ffffff?text=Spark',
    ),
    RepairGuide(
      title: 'Left indicator Issue',
      author: 'Fatima Waseem',
      imageUrl: 'https://placehold.co/100x100/2A3B4C/ffffff?text=Light',
    ),
    RepairGuide(
      title: 'Clutch Wire Issue',
      author: 'Abdullah Mohsin Ali',
      imageUrl: 'https://placehold.co/100x100/1C2D3E/ffffff?text=Clutch',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final route = ref.watch(goRouterProvider);
    // Filter the list based on search text
    final filteredGuides = _searchText.isEmpty
        ? sampleGuides
        : sampleGuides.where((guide) {
      return guide.title
          .toLowerCase()
          .contains(_searchText.toLowerCase());
    }).toList();

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
            'All Repair Guides',
            style: TextStyle(
              color: appMainTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              // --- Search Bar ---
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: appCardColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  style: const TextStyle(color: appMainTextColor),
                  onChanged: (value) {
                    setState(() {
                      _searchText = value;
                    });
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search Issue...',
                    hintStyle: TextStyle(color: appCardColor),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: appTextColor),
                    contentPadding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // --- List of Guides ---
              Expanded(
                child: ListView.builder(
                  itemCount: filteredGuides.length,
                  itemBuilder: (context, index) {
                    return _GuideCard(
                      guide: filteredGuides[index],
                      onTap: () {
                        // TODO: Update the link here
                        print('Tapped on ${filteredGuides[index].title}');
                        route.push(getRoutePath(guideDetailRoute));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('Add new guide button pressed');
            // Navigate to add guide screen if needed
            route.push(getRoutePath(addGuideRoute));
          },
          backgroundColor: appButtonColor,
          shape: const CircleBorder(),
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  final RepairGuide guide;
  final VoidCallback onTap;

  const _GuideCard({
    required this.guide,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: appCardColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                guide.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  color: Colors.grey.withOpacity(0.3),
                  child: const Icon(Icons.build, color: appMainTextColor),
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    guide.title,
                    style: const TextStyle(
                      color: appMainTextColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Author
                  Text(
                    guide.author,
                    style: const TextStyle(
                      color: appTextColor,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Rating and Reviews
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Color(0xFFE5B800), // Gold/Amber color
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        guide.rating.toString(),
                        style: const TextStyle(
                          color: appTextColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text('|',
                          style: TextStyle(color: appTextColor, fontSize: 12)),
                      const SizedBox(width: 8),
                      Text(
                        '${guide.reviews} Reviews',
                        style: const TextStyle(
                          color: appTextColor,
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
  }
}