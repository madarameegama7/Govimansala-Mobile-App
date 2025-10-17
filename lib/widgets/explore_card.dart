import 'package:agriplant/models/explore.dart';
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
                style: Theme.of(context).textTheme.titleSmall,
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

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//               builder: (_) => ExploreDetailsPage(explore: explore)),
//         );
//       },
//       child: Card(
//         clipBehavior: Clip.antiAlias,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//           side: BorderSide(color: Colors.grey.shade200),
//         ),
//         elevation: 0.5,
//         child: Column(
//           mainAxisSize: MainAxisSize.min, // prevents card from stretching
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             AspectRatio(
//               aspectRatio: 3 / 2, // Controls image height relative to width
//               child: Image.asset(
//                 explore.image,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: Text(
//                 explore.name,
//                 style: Theme.of(context).textTheme.bodyLarge,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
