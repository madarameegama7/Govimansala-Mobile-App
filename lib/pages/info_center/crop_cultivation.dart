import 'package:flutter/material.dart';
import 'data/crops.dart';
import 'models/crop_info.dart';

class CropCultivationPage extends StatefulWidget {
  const CropCultivationPage({Key? key}) : super(key: key);

  @override
  State<CropCultivationPage> createState() => _CropCultivationPageState();
}

class _CropCultivationPageState extends State<CropCultivationPage> {
  late CropInfo selectedCrop;

  @override
  void initState() {
    super.initState();
    selectedCrop = crops.first; // default to first crop (Rice)
  }

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
              // Dropdown crop selector
              DropdownButton<CropInfo>(
                value: selectedCrop,
                isExpanded: true,
                icon: const Icon(Icons.arrow_drop_down),
                underline: const SizedBox(),
                onChanged: (crop) {
                  if (crop != null) setState(() => selectedCrop = crop);
                },
                items: crops.map((crop) {
                  return DropdownMenuItem(
                    value: crop,
                    child: Text(crop.name,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),

              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  selectedCrop.image,
                  width: double.infinity,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              Text(selectedCrop.name,
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 6),
              Text(selectedCrop.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey.withValues(alpha: 0.7))),
              const SizedBox(height: 16),

              // Quick facts
              _buildQuickFacts(selectedCrop),
              const SizedBox(height: 16),

              // Getting started
              _buildGettingStarted(selectedCrop),
              const SizedBox(height: 16),

              // Schedule
              _buildSchedule(selectedCrop),
              const SizedBox(height: 16),

              // Pests
              _buildPests(selectedCrop),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickFacts(CropInfo crop) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: crop.quickFacts.entries
              .map((e) => Column(
                    children: [
                      Text(e.key,
                          style: const TextStyle(
                              fontSize: 12, color: Colors.grey)),
                      const SizedBox(height: 4),
                      Text(e.value,
                          style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildGettingStarted(CropInfo crop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Getting Started', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...crop.gettingStarted.map(
          (tip) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 6, right: 8),
                  child: Icon(Icons.circle, size: 8, color: Colors.green),
                ),
                Expanded(child: Text(tip, style: const TextStyle(height: 1.4))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSchedule(CropInfo crop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Planting Schedule',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),

        // --- Visual Timeline ---
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: crop.schedule.asMap().entries.map((entry) {
              final index = entry.key;
              final stage = entry.value.keys.first;
              final duration = entry.value.values.first;

              return Row(
                children: [
                  Column(
                    children: [
                      // Stage Circle
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withValues(alpha: 0.9),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withValues(alpha: 0.4),
                              blurRadius: 6,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.eco, size: 14, color: Colors.white),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        stage,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        duration,
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      ),
                    ],
                  ),
                  if (index < crop.schedule.length - 1)
                    Container(
                      width: 60,
                      height: 2,
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withValues(alpha: 0.5),
                    ),
                ],
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

        // --- Textual Reference (kept for detail) ---
        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: crop.schedule
                  .map((item) => Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.keys.first,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600)),
                              Text(item.values.first,
                                  style: const TextStyle(color: Colors.grey)),
                            ],
                          ),
                          if (item != crop.schedule.last) const Divider(),
                        ],
                      ))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPests(CropInfo crop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Pest & Disease Management',
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ...crop.pests.map((p) => ExpansionTile(
              title: Text(p.keys.first),
              children: [ListTile(title: Text(p.values.first))],
            )),
      ],
    );
  }
}

