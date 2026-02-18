import 'package:campus_link/widgets/app_scroll_wrapper.dart';
import 'package:flutter/material.dart';

class FeesPage extends StatelessWidget {
  const FeesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<FeeTransaction> transactions = [
      FeeTransaction('Semester Fee', 45000, 'Nov 15, 2025', false, 'Pending'),
      FeeTransaction('Library Fee', 2000, 'Oct 1, 2025', true, 'Paid'),
      FeeTransaction('Exam Fee', 3000, 'Sep 20, 2025', true, 'Paid'),
      FeeTransaction('Sports Fee', 1500, 'Sep 15, 2025', true, 'Paid'),
    ];

    int totalPending = transactions
        .where((t) => !t.isPaid)
        .fold(0, (sum, t) => sum + t.amount);
    int totalPaid = transactions
        .where((t) => t.isPaid)
        .fold(0, (sum, t) => sum + t.amount);

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Fees',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: AppScrollWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSummaryCard(totalPending, totalPaid),
              const SizedBox(height: 30),
              const Text(
                'Payment History',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              ...transactions.map((transaction) => _buildTransactionCard(transaction, context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCard(int pending, int paid) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF44336), Color(0xFFEF5350)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Total Pending',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '₹${pending.toStringAsFixed(0)}',
            style: const TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white30),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  const Text(
                    'Paid',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹$paid',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: 1,
                height: 40,
                color: Colors.white30,
              ),
              Column(
                children: [
                  const Text(
                    'Due',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '₹$pending',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(FeeTransaction transaction, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: (transaction.isPaid ? Colors.green : Colors.red).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: (transaction.isPaid ? Colors.green : Colors.red).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.isPaid ? Icons.check_circle : Icons.pending,
              color: transaction.isPaid ? Colors.green : Colors.red,
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Due: ${transaction.dueDate}',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹${transaction.amount}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (transaction.isPaid ? Colors.green : Colors.red).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  transaction.status,
                  style: TextStyle(
                    fontSize: 11,
                    color: transaction.isPaid ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeeTransaction {
  final String title;
  final int amount;
  final String dueDate;
  final bool isPaid;
  final String status;

  FeeTransaction(
    this.title,
    this.amount,
    this.dueDate,
    this.isPaid,
    this.status,
  );
}
