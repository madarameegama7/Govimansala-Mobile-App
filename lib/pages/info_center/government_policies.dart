import 'package:flutter/material.dart';

class GovernmentPoliciesPage extends StatelessWidget {
  const GovernmentPoliciesPage({Key? key}) : super(key: key);

  static final List<_Policy> _policies = [
    _Policy(
      title: 'Subsidy for Smallholders',
      summary: 'Financial support for seed, fertilizer and inputs for small farmers.',
      date: '2024-01-15',
      link: null,
    ),
    _Policy(
      title: 'Land Use Regulation Update',
      summary: 'Guidelines on land classification and permissible agricultural activities.',
      date: '2023-11-02',
      link: null,
    ),
    _Policy(
      title: 'Irrigation Development Program',
      summary: 'Funding and technical support for community irrigation projects.',
      date: '2024-03-08',
      link: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Government Policies'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search policies...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(99)),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
                  // optional: implement search/filter
                },
              ),
            ),

            // Quick filters
            SizedBox(
              height: 46,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 4),
                  _FilterChip(label: 'All', selected: true),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Subsidies'),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Land'),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Irrigation'),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Insurance'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Policies list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _policies.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final p = _policies[index];
                  return _PolicyCard(
                    policy: p,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => _PolicyDetailPage(policy: p)),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Policy {
  final String title;
  final String summary;
  final String date;
  final String? link; // optional external link to official doc
  const _Policy({required this.title, required this.summary, required this.date, this.link});
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _FilterChip({Key? key, required this.label, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        // implement filter change
      },
      backgroundColor: selected ? Colors.green.shade700 : Colors.green.shade50,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.green.shade800),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class _PolicyCard extends StatelessWidget {
  final _Policy policy;
  final VoidCallback? onTap;
  const _PolicyCard({Key? key, required this.policy, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.policy, color: Colors.green, size: 28),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(policy.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(policy.summary, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700)),
                  const SizedBox(height: 8),
                  Row(children: [Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600), const SizedBox(width: 6), Text(policy.date, style: TextStyle(color: Colors.grey.shade600, fontSize: 12))]),
                ]),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  // share or open link
                },
                icon: const Icon(Icons.open_in_new),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PolicyDetailPage extends StatelessWidget {
  final _Policy policy;
  const _PolicyDetailPage({Key? key, required this.policy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(policy.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(policy.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('Published: ${policy.date}', style: TextStyle(color: Colors.grey.shade600)),
            const SizedBox(height: 12),
            Text(policy.summary, style: const TextStyle(height: 1.5)),
            const SizedBox(height: 16),
            const Text('Details', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text(
              'Full policy text, eligibility, application process, contact points and downloadable documents should be placed here. Replace with actual content or fetch from an API.',
              style: TextStyle(height: 1.5),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // open official link or share
              },
              icon: const Icon(Icons.link),
              label: const Text('Open official document'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ]),
        ),
      ),
    );
  }
}