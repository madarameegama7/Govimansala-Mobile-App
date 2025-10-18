import 'package:flutter/material.dart';

class AgriEssentialsPage extends StatelessWidget {
  const AgriEssentialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Essentials'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/homePage/agri_services.jpeg',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Title + subtitle
              Text('Buy or Rent what you need',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text(
                'Tools, equipment and services to start or scale your plantation — listed by local suppliers and renters.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Category chips row
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const [
                  _CategoryChip(label: 'Tractors'),
                  _CategoryChip(label: 'Seeds & Seedlings'),
                  _CategoryChip(label: 'Irrigation'),
                  _CategoryChip(label: 'Fertilizers'),
                  _CategoryChip(label: 'Tools'),
                  _CategoryChip(label: 'Rentals'),
                ],
              ),
              const SizedBox(height: 16),

              // Quick filters and sort
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // open filter sheet
                    },
                    icon: const Icon(Icons.filter_list),
                    label: const Text('Filters'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton.icon(
                    onPressed: () {
                      // open sort options
                    },
                    icon: const Icon(Icons.sort),
                    label: const Text('Sort'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Featured listings heading
              Text('Featured listings', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),

              // Example listing cards (repeatable)
              Column(
                children: const [
                  _ListingCard(
                    title: '4WD Tractor (For Rent)',
                    subtitle: 'Per day / Per week options · Near you',
                    price: 'LKR 8,500 / day',
                    image: '../../../assets/samplePic.png',
                  ),
                  SizedBox(height: 12),
                  _ListingCard(
                    title: 'Quality Paddy Seed Pack',
                    subtitle: 'Certified seeds · 20kg pack',
                    price: 'LKR 2,200',
                    image: '../../../assets/samplePic.png',
                  ),
                  SizedBox(height: 12),
                  _ListingCard(
                    title: 'Drip Irrigation Kit',
                    subtitle: 'Covers 1 acre · Includes pipes & drippers',
                    price: 'LKR 45,000',
                    image: '../../../assets/samplePic.png',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // How it works section
              Text('How it works', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _stepItem('Search or browse categories', 'Find items for buy or rent in your area'),
              _stepItem('Compare prices and availability', 'Check seller ratings and terms'),
              _stepItem('Contact the seller', 'Message or call to confirm details'),
              const SizedBox(height: 16),

              // CTA: Post an ad / Request rental
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // navigate to create listing
                      },
                      icon: const Icon(Icons.add_box),
                      label: const Text('Post an item'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 140,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // navigate to requests
                      },
                      icon: const Icon(Icons.request_page),
                      label: const Text('Requests'),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  const _CategoryChip({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        // filter by category
      },
      backgroundColor: Colors.green.shade50,
      labelStyle: TextStyle(color: Colors.green.shade800),
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class _ListingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String image;

  const _ListingCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          // open listing details
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(image, width: 88, height: 72, fit: BoxFit.cover),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 6),
                    Text(subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 8),
                    Text(price, style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // quick call or message
                },
                icon: const Icon(Icons.phone),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _stepItem(String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(width: 28, height: 28, decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(Icons.check, color: Colors.green.shade700, size: 18)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(fontWeight: FontWeight.w600)), const SizedBox(height: 4), Text(subtitle, style: const TextStyle(color: Colors.grey))])),
      ],
    ),
  );
}