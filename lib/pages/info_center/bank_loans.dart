import 'package:flutter/material.dart';
import '../../pages/info_center/data/loan_info.dart';
import 'loan_details_page.dart';

class BankLoansPage extends StatelessWidget {
  const BankLoansPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECF7EE),
      appBar: AppBar(
        title: const Text("Agricultural Loan Programs"),
        // backgroundColor: const Color(0xFF1B5E20),
        foregroundColor: Colors.black87,
        elevation: 8,
        shadowColor: const Color(0xFF1B5E20).withValues(alpha: 0.3),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: loanList.length,
        itemBuilder: (context, index) {
          final loan = loanList[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LoanDetailsPage(loan: loan),
              ),
            ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF1B5E20).withValues(alpha: 0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.horizontal(left: Radius.circular(18)),
                    child: Image.asset(
                      loan.image,
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loan.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B5E20),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            loan.description,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color:
                                  const Color(0xFF1B5E20).withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

