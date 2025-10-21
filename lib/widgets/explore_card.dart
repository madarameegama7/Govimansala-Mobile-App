import 'package:govimansala/models/explore.dart';
import 'package:flutter/material.dart';

import '../pages/explore_details_page.dart';

class ExploreCard extends StatelessWidget {
  const ExploreCard({Key? key, required this.explore, this.onTap})
      : super(key: key);

  final Explore explore;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      color: Theme.of(context).cardColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    explore.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                explore.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      shadows: [
                        Shadow(
                          offset: const Offset(0, 1.2),
                          blurRadius: 3,
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha:0.4),
                        ),
                        // Shadow(
                        //   offset: const Offset(0, 0),
                        //   blurRadius: 6,
                        //   color: Theme.of(context)
                        //       .colorScheme
                        //       .primary
                        //       .withValues(alpha:0.25),
                        // ),
                      ],
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                explore.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
