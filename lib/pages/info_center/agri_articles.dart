import 'package:flutter/material.dart';

class AgriArticlesPage extends StatelessWidget {
  const AgriArticlesPage({Key? key}) : super(key: key);

  // Example sample data (replace with real data source)
  static final List<_Article> _samples = [
    _Article(
      title: 'Soil Health Basics',
      excerpt: 'Learn how to test and improve soil fertility for better yields.',
      image: '../../../assets/samplePic.png',
      date: '2024-05-12',
    ),
    _Article(
      title: 'Integrated Pest Management',
      excerpt: 'Practical IPM techniques that reduce pesticide use.',
      image: '../../../assets/samplePic.png',
      date: '2024-04-02',
    ),
    _Article(
      title: 'Water-Saving Irrigation',
      excerpt: 'How drip and micro-sprinklers can save water and boost productivity.',
      image: '../../../assets/samplePic.png',
      date: '2024-03-20',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agri Articles'),
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
                  hintText: 'Search articles...',
                  prefixIcon: const Icon(Icons.search),
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(99)),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
                  // implement search filtering if needed
                },
              ),
            ),

            // Categories horizontal chips
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  const SizedBox(width: 4),
                  _CategoryChip(label: 'All', selected: true),
                  const SizedBox(width: 8),
                  _CategoryChip(label: 'Soil'),
                  const SizedBox(width: 8),
                  _CategoryChip(label: 'Pests'),
                  const SizedBox(width: 8),
                  _CategoryChip(label: 'Irrigation'),
                  const SizedBox(width: 8),
                  _CategoryChip(label: 'Finance'),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Article list
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: _samples.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final a = _samples[index];
                  return _ArticleCard(
                    article: a,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => _ArticleDetailPage(article: a)),
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

class _Article {
  final String title;
  final String excerpt;
  final String image;
  final String date;

  const _Article({
    required this.title,
    required this.excerpt,
    required this.image,
    required this.date,
  });
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  const _CategoryChip({Key? key, required this.label, this.selected = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        // filter by category
      },
      backgroundColor: selected ? Colors.green.shade700 : Colors.green.shade50,
      labelStyle: TextStyle(color: selected ? Colors.white : Colors.green.shade800),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final _Article article;
  final VoidCallback? onTap;

  const _ArticleCard({Key? key, required this.article, this.onTap}) : super(key: key);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  article.image,
                  width: 96,
                  height: 72,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    Text(article.excerpt, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade600),
                        const SizedBox(width: 6),
                        Text(article.date, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ArticleDetailPage extends StatelessWidget {
  final _Article article;
  const _ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(article.image, width: double.infinity, height: 200, fit: BoxFit.cover)),
              const SizedBox(height: 12),
              Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Published: ${article.date}', style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 12),
              Text(
                // placeholder body; replace with real article content
                '${article.excerpt}\n\nDetailed content goes here. Replace with the full article text or loaded HTML/Markdown content.',
                style: const TextStyle(height: 1.5),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // share or save
                },
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}