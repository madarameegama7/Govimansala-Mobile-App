import 'package:agriplant/data/explore.dart';
import 'package:agriplant/models/explore.dart';
import 'package:agriplant/widgets/explore_card.dart';
import 'package:agriplant/widgets/weather_card.dart';
import 'package:govimansala/data/explore.dart';
import 'package:govimansala/widgets/explore_card.dart';
import 'package:govimansala/widgets/weather_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchCtrl = TextEditingController();
  late List<Explore>
      _filtered; // Replace Explore with your model type if different
  String _query = '';

  @override
  void initState() {
    super.initState();
    _filtered =
        List<Explore>.from(explores); // uses explores from data/explore.dart
    _searchCtrl.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q == _query) return;
    _query = q;
    setState(() {
      if (_query.isEmpty) {
        _filtered = List<Explore>.from(explores);
      } else {
        _filtered = explores
            .where((e) =>
                e.name.toLowerCase().contains(_query) ||
                e.description.toLowerCase().contains(_query))
            .toList();
      }
    });
  }

  void _clearSearch() {
    _searchCtrl.clear();
    FocusScope.of(context).unfocus();
  }

  void _onCardTap(Explore item) {
    if (item.routeName != null) {
      Navigator.pushNamed(context, item.routeName!);
    } else {
      // fallback: open a detail page or do nothing
    }
  }

  @override
  void dispose() {
    _searchCtrl.removeListener(_onSearchChanged);
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search here...',
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(99))),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green.shade600),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(99)),
                      ),
                      prefixIcon: const Icon(IconlyLight.search),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              onPressed: () => _searchCtrl.clear(),
                              icon: const Icon(Icons.clear))
                          : null,
                    ),
                    textInputAction: TextInputAction.search,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: IconButton.filled(
                      onPressed: () {}, // open filter
                      icon: const Icon(IconlyLight.filter, color: Colors.green),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const WeatherCard())),
        SliverToBoxAdapter(child: const SizedBox(height: 20)),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Featured Products',
                    style: Theme.of(context).textTheme.titleMedium),
                TextButton(onPressed: () {}, child: const Text('See all')),
              ],
            ),
          ),
        ),
        if (_filtered.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: const [
                Icon(Icons.search_off, size: 56, color: Colors.grey),
                SizedBox(height: 12),
                Text('No products found',
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
              ]),
            ),
          )
        else
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = _filtered[index];
                  return ExploreCard(
                    explore: item,
                    onTap: () => _onCardTap(item),
                  );
                },
                childCount: _filtered.length,
              ),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 260,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}


//   SliverGridDelegate _responsiveGridDelegate(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     // For phones, prefer 1-2 columns depending on width; maxCrossAxisExtent makes it adaptive
//     return SliverGridDelegateWithMaxCrossAxisExtent(
//       maxCrossAxisExtent: 260, // card max width; adjust to taste
//       mainAxisSpacing: 16,
//       crossAxisSpacing: 16,
//       childAspectRatio: 0.9,
//     );
//   }

//   Widget _buildSearchRow() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _searchCtrl,
//               textInputAction: TextInputAction.search,
//               decoration: InputDecoration(
//                 hintText: 'Search here...',
//                 isDense: true,
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
//                 border: const OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(99)),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.green.shade600),
//                   borderRadius: const BorderRadius.all(Radius.circular(99)),
//                 ),
//                 prefixIcon: const Icon(IconlyLight.search),
//                 suffixIcon: _query.isNotEmpty
//                     ? IconButton(
//                         onPressed: _clearSearch,
//                         tooltip: 'Clear search',
//                         icon: const Icon(Icons.clear),
//                       )
//                     : null,
//               ),
//               onSubmitted: (_) => FocusScope.of(context).unfocus(),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 12),
//             child: SizedBox(
//               height: 48,
//               width: 48,
//               child: IconButton.filled(
//                 onPressed: () {
//                   // open filter modal or navigate to filter screen
//                 },
//                 icon: const Icon(
//                   IconlyLight.filter,
//                   color: Colors.green,
//                 ),
//                 tooltip: 'Open filters',
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderRow(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text('Featured Products',
//               style: Theme.of(context).textTheme.titleMedium),
//           TextButton(
//             onPressed: () {
//               // navigate to full listing
//             },
//             child: const Text('See all'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyState() {
//     return SliverFillRemaining(
//       hasScrollBody: false,
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: const [
//             Icon(Icons.search_off, size: 56, color: Colors.grey),
//             SizedBox(height: 12),
//             Text('No products found',
//                 style: TextStyle(fontSize: 16, color: Colors.grey)),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: CustomScrollView(
//         slivers: [
//           // Top content (search + weather)
//           SliverToBoxAdapter(child: _buildSearchRow()),
//           SliverToBoxAdapter(
//               child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: const WeatherCard(),
//           )),
//           SliverToBoxAdapter(child: const SizedBox(height: 20)),
//           // Header
//           SliverToBoxAdapter(child: _buildHeaderRow(context)),
//           // Grid
//           if (_filtered.isEmpty)
//             _buildEmptyState()
//           else
//             SliverPadding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               sliver: SliverGrid(
//                 delegate: SliverChildBuilderDelegate(
//                   (context, index) {
//                     final item = _filtered[index];
//                     return ExploreCard(explore: item);
//                   },
//                   childCount: _filtered.length,
//                 ),
//                 gridDelegate: _responsiveGridDelegate(context),
//               ),
//             ),
//           const SliverToBoxAdapter(
//               child: SizedBox(height: 24)), // bottom padding
//         ],
//       ),
//     );
//   }
// }



/*First Half down */




// import 'package:agriplant/data/explore.dart';
// import 'package:agriplant/widgets/explore_card.dart';
// import 'package:agriplant/widgets/weather_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';

// class ExplorePage extends StatelessWidget {
//   const ExplorePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         padding: const EdgeInsets.all(16.0),
//         children: [
//           // Search bar + filter button
//           Padding(
//             padding: const EdgeInsets.only(bottom: 15),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     decoration: InputDecoration(
//                       hintText: "Search here...",
//                       isDense: true,
//                       contentPadding: const EdgeInsets.all(12.0),
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide(),
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(99),
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Colors.green.shade600,
//                         ),
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(99),
//                         ),
//                       ),
//                       prefixIcon: const Icon(IconlyLight.search),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 12),
//                   child: IconButton.filled(
//                     onPressed: () {},
//                     icon: const Icon(
//                       IconlyLight.filter,
//                       color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           const WeatherCard(),

//           const SizedBox(height: 25),

//           //Section title
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Featured Products",
//                 style: Theme.of(context).textTheme.titleMedium,
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text("See all"),
//               ),
//             ],
//           ),

//           // GridView of explore cards
//           GridView.builder(
//             itemCount: explores.length,
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               childAspectRatio: 0.9,
//               crossAxisSpacing: 16,
//               mainAxisSpacing: 16,
//             ),
//             itemBuilder: (context, index) {
//               return ExploreCard(explore: explores[index]);
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
