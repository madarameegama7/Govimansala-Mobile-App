import 'package:govimansala/models/explore.dart';
import 'package:flutter/material.dart';

import '../pages/explore_details_page.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({super.key, required this.explore});

  final Explore explore;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => ExploreDetailsPage(explore: explore)),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade200),
        ),
        elevation: 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min, // prevents card from stretching
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 3 / 2, // Controls image height relative to width
              child: Image.asset(
                explore.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                explore.name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
