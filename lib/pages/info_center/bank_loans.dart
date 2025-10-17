import 'package:flutter/material.dart';

class BankLoansPage extends StatelessWidget {
  const BankLoansPage({Key? key}) : super(key: key);

  static final List<_LoanOffer> _offers = [
    _LoanOffer(
      title: 'Small Farmer Loan',
      subtitle: 'Low interest for working capital',
      amountInfo: 'Up to LKR 500,000',
      image: '../../../assets/samplePic.png',
    ),
    _LoanOffer(
      title: 'Equipment Purchase Loan',
      subtitle: 'Finance tractors and equipment',
      amountInfo: 'Up to LKR 2,500,000',
      image: '../../../assets/samplePic.png',
    ),
    _LoanOffer(
      title: 'Irrigation Improvement Loan',
      subtitle: 'Support for water-saving systems',
      amountInfo: 'Up to LKR 750,000',
      image: '../../../assets/samplePic.png',
    ),
  ];

  static final List<_Faq> _faqs = [
    _Faq(question: 'Who is eligible?', answer: 'Smallholder farmers with land registration or cooperative membership.'),
    _Faq(question: 'What documents are needed?', answer: 'ID, land documents, business plan, recent bank statements.'),
    _Faq(question: 'How long is processing?', answer: 'Usually 2–4 weeks depending on documentation.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bank Loans'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero area
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/homePage/bank_loan.jpg',
                  width: double.infinity,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Intro
              Text('Loans & Financial Support', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(
                'Explore loan products, eligibility, required documents and tips for applying successfully.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[700]),
              ),
              const SizedBox(height: 16),

              // Quick steps card
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoColumn('Interest', 'Low as 6%'),
                      _infoColumn('Tenure', '1 - 7 years'),
                      _infoColumn('Processing', 'Fast track available'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Offers list
              Text('Popular loan products', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 12),
              Column(
                children: _offers
                    .map((o) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: _LoanCard(offer: o, onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => _LoanDetailPage(offer: o)));
                          }),
                        ))
                    .toList(),
              ),

              const SizedBox(height: 12),

              // How to apply
              Text('How to apply', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              _stepItem('Prepare documents', 'ID, land or lease, bank statements'),
              _stepItem('Choose product', 'Pick the loan that matches your need'),
              _stepItem('Submit application', 'Visit branch or apply online with guidance'),
              const SizedBox(height: 16),

              // FAQ
              Text('Frequently asked questions', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              ..._faqs.map((f) => ExpansionTile(title: Text(f.question), children: [Padding(padding: const EdgeInsets.all(12), child: Text(f.answer))])).toList(),

              const SizedBox(height: 16),

              // CTA
              ElevatedButton.icon(
                onPressed: () {
                  // Navigate to application helper or contact form
                },
                icon: const Icon(Icons.send),
                label: const Text('Start application'),
                style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoColumn(String k, String v) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(k, style: const TextStyle(fontSize: 12, color: Colors.grey)), const SizedBox(height: 4), Text(v, style: const TextStyle(fontWeight: FontWeight.w600))]);
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
}

class _LoanOffer {
  final String title;
  final String subtitle;
  final String amountInfo;
  final String image;
  const _LoanOffer({required this.title, required this.subtitle, required this.amountInfo, required this.image});
}

class _Faq {
  final String question;
  final String answer;
  const _Faq({required this.question, required this.answer});
}

class _LoanCard extends StatelessWidget {
  final _LoanOffer offer;
  final VoidCallback? onTap;
  const _LoanCard({Key? key, required this.offer, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.asset(offer.image, width: 88, height: 72, fit: BoxFit.cover)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(offer.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 6),
                  Text(offer.subtitle, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(offer.amountInfo, style: TextStyle(color: Colors.green.shade700, fontWeight: FontWeight.w700)),
                ]),
              ),
              const SizedBox(width: 8),
              IconButton(onPressed: () {}, icon: const Icon(Icons.info_outline), color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoanDetailPage extends StatelessWidget {
  final _LoanOffer offer;
  const _LoanDetailPage({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(offer.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.asset(offer.image, width: double.infinity, height: 200, fit: BoxFit.cover)),
            const SizedBox(height: 12),
            Text(offer.title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(offer.subtitle, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text('Amount: ${offer.amountInfo}', style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            const Text('Details', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            const Text('Full loan terms, eligibility criteria, required documents and contact details would be listed here.'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // start application flow or contact bank
              },
              child: const Text('Apply or Contact'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ]),
        ),
      ),
    );
  }
}