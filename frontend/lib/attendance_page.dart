import 'package:campus_link/widgets/app_scroll_wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AttendancePage extends StatefulWidget {
  final String studentId;
  const AttendancePage({super.key, required this.studentId});

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Subject> subjects = [];

  double attendancePercentage = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchAttendancePercentage();
    fetchSubjectWiseAttendance();
  }

  Future<void> fetchAttendancePercentage() async {
    final url = Uri.parse(
      'http://10.0.2.2:5000/api/attendance/stats/${widget.studentId}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        attendancePercentage = double.parse(data['percentage']);
        isLoading = false;
      });
    }
  }

  Future<void> fetchSubjectWiseAttendance() async {
    final url = Uri.parse(
      'http://10.0.2.2:5000/api/attendance/subject-wise/${widget.studentId}',
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);

      setState(() {
        subjects = data.map<Subject>((item) {
          return Subject(
            item['subject'],
            item['present'],
            item['total'],
            Colors.orange,
          );
        }).toList();

        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double overallPercentage = attendancePercentage;

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
          'Attendance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: AppScrollWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _buildOverallCard(overallPercentage),
              const SizedBox(height: 30),
              const Text(
                'Subject-wise Attendance',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              ...subjects.map((subject) => _buildSubjectCard(subject)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOverallCard(double percentage) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: percentage >= 75
              ? [const Color(0xFF4CAF50), const Color(0xFF66BB6A)]
              : [const Color(0xFFF44336), const Color(0xFFEF5350)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: (percentage >= 75 ? Colors.green : Colors.red).withOpacity(
              0.3,
            ),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Overall Attendance',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '${percentage.toStringAsFixed(1)}%',
            style: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            percentage >= 75 ? '✓ Required: 75%' : '⚠ Below Required: 75%',
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(Subject subject) {
    double percentage = (subject.present / subject.total) * 100;

    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: subject.color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  subject.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: subject.color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: TextStyle(
                    color: subject.color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: percentage / 100,
              backgroundColor: Colors.grey.shade800,
              valueColor: AlwaysStoppedAnimation<Color>(subject.color),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Present: ${subject.present}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
              ),
              Text(
                'Total: ${subject.total}',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Subject {
  final String name;
  final int present;
  final int total;
  final Color color;

  Subject(this.name, this.present, this.total, this.color);
}
