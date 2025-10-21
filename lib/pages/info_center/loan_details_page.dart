import 'package:flutter/material.dart';
import '../info_center/models/loan.dart';

class LoanDetailsPage extends StatelessWidget {
  final Loan loan;

  const LoanDetailsPage({super.key, required this.loan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF7EE),
      appBar: AppBar(
        title: Text(loan.name),
        // backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.black87,
        elevation: 6,
        shadowColor: const Color(0xFF1B5E20).withValues(alpha: 0.3),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(loan.image, fit: BoxFit.cover),
            ),
            const SizedBox(height: 16),
            Text(
              loan.description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            _infoRow("💰 Interest Rate", loan.interestRate),
            _infoRow("📅 Repayment Period", loan.repaymentPeriod),
            _infoRow("✅ Eligibility", loan.eligibility),
            _infoRow("🧾 Collateral", loan.collateral),
            const SizedBox(height: 24),
            _faqSection(),
            const SizedBox(height: 16),
            _applySection(),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1B5E20))),
          Text(value),
        ],
      ),
    );
  }

  Widget _faqSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B5E20).withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "❓ Frequently Asked Questions",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
          ),
          SizedBox(height: 8),
          Text("• Can I apply without collateral?\n  → Yes, small-value loans may be granted under guarantor schemes."),
          Text("• Is crop insurance required?\n  → Recommended for risk coverage, especially for paddy and maize loans."),
          Text("• Can youth apply jointly with parents?\n  → Yes, joint applications are encouraged for training-based projects."),
        ],
      ),
    );
  }

  Widget _applySection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF2E1),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1B5E20).withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📋 How to Apply",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1B5E20)),
          ),
          SizedBox(height: 8),
          Text(
            "1️⃣ Visit your nearest agricultural bank branch or cooperative society.\n"
            "2️⃣ Bring your NIC, proof of land use, and quotations (if applicable).\n"
            "3️⃣ Complete the application form and submit to the officer.\n"
            "4️⃣ Loan assessment typically takes 5–10 working days.\n"
            "5️⃣ Upon approval, funds will be credited to your account.",
            style: TextStyle(height: 1.4),
          ),
        ],
      ),
    );
  }
}
