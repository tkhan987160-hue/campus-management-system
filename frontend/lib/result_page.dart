import 'package:campus_link/widgets/app_scroll_wrapper.dart';
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SubjectResult> results = [
      SubjectResult('Data Structures', 85, 90, 88, 'A', Colors.blue),
      SubjectResult('Database Management', 78, 82, 80, 'A', Colors.green),
      SubjectResult('Web Development', 92, 88, 90, 'A+', Colors.orange),
      SubjectResult('Operating Systems', 75, 80, 77, 'B+', Colors.purple),
      SubjectResult('Computer Networks', 88, 85, 87, 'A', Colors.red),
    ];

    double totalMarks = results.fold(0, (sum, r) => sum + r.total);
    double averageMarks = totalMarks / results.length;
    String overallGrade = _getGrade(averageMarks);

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
          'Results',
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
              _buildOverallCard(averageMarks, overallGrade),
              const SizedBox(height: 30),
              const Text(
                'Subject-wise Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              ...results.map((result) => _buildResultCard(result)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallCard(double average, String grade) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Text(
                'Overall Average',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${average.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Container(
            width: 1,
            height: 80,
            color: Colors.white30,
          ),
          Column(
            children: [
              const Text(
                'Grade',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  grade,
                  style: const TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard(SubjectResult result) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: result.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  result.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                  color: result.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  result.grade,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildMarkItem('Mid-Term', result.midTerm, result.color),
              _buildMarkItem('End-Term', result.endTerm, result.color),
              _buildMarkItem('Total', result.total, result.color),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMarkItem(String label, int marks, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$marks',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  String _getGrade(double marks) {
    if (marks >= 90) return 'A+';
    if (marks >= 80) return 'A';
    if (marks >= 70) return 'B+';
    if (marks >= 60) return 'B';
    if (marks >= 50) return 'C';
    return 'F';
  }
}

class SubjectResult {
  final String subject;
  final int midTerm;
  final int endTerm;
  final int total;
  final String grade;
  final Color color;

  SubjectResult(
    this.subject,
    this.midTerm,
    this.endTerm,
    this.total,
    this.grade,
    this.color,
  );
}
