import 'package:flutter/material.dart';
import 'package:govimansala/pages/info_center/models/crop_essentials.dart';
import 'package:govimansala/pages/info_center/data/essentials.dart';

class AgriEssentialsPage extends StatelessWidget {
  const AgriEssentialsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final crops = cropsData; // imported from crops_data.dart

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Essentials'),
        // backgroundColor: Colors.green.shade600,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Hero Section ---
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

              // --- Title + Subtitle ---
              Text(
                'Grow Smart. Farm Easy.',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(
                      color: Colors.green.shade800,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Find essential tools, crop guides, and trusted suppliers to boost your yield sustainably.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.grey[700]),
              ),

              const SizedBox(height: 20),

              // --- Crop Section ---
              _sectionTitle('Top Crops This Season'),
              const SizedBox(height: 8),

              Column(
                children: crops
                    .map(
                      (crop) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: _CropCard(crop: crop),
                      ),
                    )
                    .toList(),
              ),

              const SizedBox(height: 20),

              // --- Tips Section ---
              _sectionTitle('Quick Tips'),
              const SizedBox(height: 8),
              const _TipCard(
                icon: Icons.grass,
                title: 'Soil Health First',
                content:
                    'Test soil pH (ideal: 6.0–7.5) before planting for better nutrient uptake.',
              ),
              const SizedBox(height: 8),
              const _TipCard(
                icon: Icons.wb_sunny,
                title: 'Smart Watering',
                content:
                    'Use drip irrigation to save up to 50% water during dry seasons.',
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _sectionTitle(String text) => Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.green.shade700,
      ),
    );

class _CropCard extends StatelessWidget {
  final Crop crop;
  const _CropCard({required this.crop});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.green.shade50,
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: 2,
          )
        ],
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            crop.image,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          crop.name,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Season: ${crop.season}'),
            Text('Duration: ${crop.duration}'),
            Text('Soil: ${crop.soil}'),
            Text('Rainfall: ${crop.rainfall}'),
          ],
        ),
      ),
    );
  }
}

class _TipCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const _TipCard({
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.12),
            blurRadius: 6,
            spreadRadius: 2,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.green.shade700, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

