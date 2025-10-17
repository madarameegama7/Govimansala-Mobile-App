import 'package:flutter/material.dart';

class CropCultivationPage extends StatelessWidget {
  const CropCultivationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Cultivation'),
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
                  'assets/homePage/crop_cultivation.jpeg',
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Title + subtitle
              Text('Crop Cultivation', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text(
                'Practical guides, schedules and pest management for successful planting',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Quick facts card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoColumn('Season', 'Yala / Maha'),
                      _infoColumn('Soil', 'Loamy / Sandy'),
                      _infoColumn('Irrigation', 'Drip / Flood'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Section: Getting started
              Text('Getting started', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _bulletText('Select appropriate crop variety for your region.'),
              _bulletText('Prepare the soil with organic matter and proper tillage.'),
              _bulletText('Follow recommended sowing depth and spacing.'),

              const SizedBox(height: 16),

              // Section: Calendar / schedule
              Text('Planting schedule', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      _rowKeyValue('Sowing', 'Week 1 - Week 2'),
                      const Divider(),
                      _rowKeyValue('Vegetative', 'Week 3 - Week 8'),
                      const Divider(),
                      _rowKeyValue('Harvest', 'Week 9 - Week 12'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Section: Pest & Disease (collapsible)
              Text('Pest & Disease Management', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ExpansionTile(
                title: const Text('Common pests'),
                children: const [
                  ListTile(title: Text('Stem borer — Monitor and use traps')),
                  ListTile(title: Text('Aphids — Encourage natural predators')),
                ],
              ),
              const SizedBox(height: 8),

              // Section: Resources CTA
              ElevatedButton.icon(
                onPressed: () {
                  // navigate to deeper resource or external link
                },
                icon: const Icon(Icons.book),
                label: const Text('Open detailed guide'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size.fromHeight(48),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _bulletText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6, right: 8),
            child: Icon(Icons.circle, size: 8, color: Colors.green),
          ),
          Expanded(child: Text(text, style: const TextStyle(height: 1.4))),
        ],
      ),
    );
  }

  Widget _rowKeyValue(String k, String v) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(k, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(v, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}