import 'package:flutter/material.dart';
import '../info_center/models/gov_policy.dart';
import '../info_center/data/gov_info.dart';

class GovernmentPoliciesPage extends StatefulWidget {
  const GovernmentPoliciesPage({super.key});

  @override
  State<GovernmentPoliciesPage> createState() => _GovernmentPoliciesPageState();
}

class _GovernmentPoliciesPageState extends State<GovernmentPoliciesPage> {
  String selectedCategory = 'All';

  List<String> get categories {
    final allCategories =
        policyList.map((policy) => policy.category).toSet().toList();
    allCategories.sort();
    return ['All', ...allCategories];
  }

  @override
  Widget build(BuildContext context) {
    final filteredPolicies = selectedCategory == 'All'
        ? policyList
        : policyList.where((p) => p.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Government Agriculture Policies',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        // backgroundColor: Colors.green.shade700,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─────────────── INTRO ───────────────
            const Text(
              'Learn about key agricultural programs that help Sri Lankan farmers. '
              'These include subsidies, insurance, irrigation, and land-use policies to improve farming and livelihoods.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            // ─────────────── CATEGORY FILTER ───────────────
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat;
                  return ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: Colors.green.shade600,
                    backgroundColor: Colors.grey.shade200,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    onSelected: (_) {
                      setState(() => selectedCategory = cat);
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // ─────────────── POLICY LIST ───────────────
            ...filteredPolicies.map((policy) => _PolicyCard(policy: policy)),

            const SizedBox(height: 30),

            // ─────────────── HOW TO APPLY ───────────────
            const Text(
              'How to Apply',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Farmers interested in benefiting from these programs should visit their nearest Agrarian Service Center or Divisional Secretariat. '
              'Applications are typically open during each cultivation season and require proof of land ownership or registration as a farmer. '
              'Most schemes now also allow online registration through the Ministry of Agriculture’s e-agri portal.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 10),
            const Text(
              'Key steps:\n'
              '• Check eligibility for the specific scheme\n'
              '• Collect required documents (NIC, land permit, bank account)\n'
              '• Submit form at your local office or online portal\n'
              '• Await confirmation and follow updates via SMS or notice board',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),

            const SizedBox(height: 30),

            // ─────────────── FAQ ───────────────
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _FaqItem(
              question: 'Who can apply for agricultural subsidies?',
              answer:
                  'Registered farmers who cultivate eligible crops such as paddy, maize, or vegetables can apply. Youth and women farmers are given priority in most programs.',
            ),
            _FaqItem(
              question: 'Is insurance mandatory for all farmers?',
              answer:
                  'No, but it is strongly recommended. The government covers part of the premium, making it affordable and helpful in times of crop loss.',
            ),
            _FaqItem(
              question:
                  'Do I need to own land to apply for irrigation support?',
              answer:
                  'You can apply if you are a registered cultivator with legal cultivation rights, even if you do not fully own the land.',
            ),
            _FaqItem(
              question: 'Where can I get more information?',
              answer:
                  'You can contact your local Agrarian Service Center or the Department of Agriculture hotline for details on available programs in your district.',
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────── POLICY CARD ───────────────
class _PolicyCard extends StatefulWidget {
  final Policy policy;
  const _PolicyCard({required this.policy});

  @override
  State<_PolicyCard> createState() => _PolicyCardState();
}

class _PolicyCardState extends State<_PolicyCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final policy = widget.policy;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              policy.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 6),
            Text(policy.summary, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  policy.category,
                  style: const TextStyle(
                      color: Colors.grey, fontStyle: FontStyle.italic),
                ),
                Text(
                  policy.date,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (expanded)
              Text(
                policy.details,
                style: const TextStyle(fontSize: 15, height: 1.4),
              ),
            TextButton(
              onPressed: () => setState(() => expanded = !expanded),
              child: Text(expanded ? 'Show Less' : 'Read More'),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────── FAQ ITEM ───────────────
class _FaqItem extends StatelessWidget {
  final String question;
  final String answer;
  const _FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            answer,
            style: const TextStyle(fontSize: 15, height: 1.5),
          ),
        ),
      ],
    );
  }
}



