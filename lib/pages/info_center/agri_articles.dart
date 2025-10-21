import 'package:flutter/material.dart';
import '../../pages/info_center/data/article_info.dart';
import '../info_center/models/article.dart';

class AgriArticlesPage extends StatefulWidget {
  const AgriArticlesPage({Key? key}) : super(key: key);

  @override
  State<AgriArticlesPage> createState() => _AgriArticlesPageState();
}

class _AgriArticlesPageState extends State<AgriArticlesPage> {
  String selectedCategory = 'All';

  List<Article> get filteredArticles {
    if (selectedCategory == 'All') return articlesData;
    return articlesData.where((a) => a.category == selectedCategory).toList();
  }

  final List<String> categories = ['All', 'Soil', 'Pests', 'Irrigation', 'Finance'];

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
            // Category filter chips
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final label = categories[index];
                  final selected = label == selectedCategory;
                  return ActionChip(
                    label: Text(label),
                    onPressed: () {
                      setState(() => selectedCategory = label);
                    },
                    backgroundColor: selected ? Colors.green.shade700 : Colors.green.shade50,
                    labelStyle: TextStyle(color: selected ? Colors.white : Colors.green.shade800),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Dynamic Article List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                itemCount: filteredArticles.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final a = filteredArticles[index];
                  return _ArticleCard(
                    article: a,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ArticleDetailPage(article: a)),
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

class _ArticleCard extends StatelessWidget {
  final Article article;
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

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

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
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(article.image, width: double.infinity, height: 200, fit: BoxFit.cover),
              ),
              const SizedBox(height: 12),
              Text(article.title, style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text('Published: ${article.date}', style: TextStyle(color: Colors.grey.shade600)),
              const SizedBox(height: 12),
              Text(article.body, style: const TextStyle(height: 1.5)),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  // future share function
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

