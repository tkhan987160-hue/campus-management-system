import 'package:campus_link/widgets/app_scroll_wrapper.dart';
import 'package:flutter/material.dart';

class AssignmentsPage extends StatefulWidget {
  const AssignmentsPage({super.key});

  @override
  State<AssignmentsPage> createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  final List<Assignment> assignments = [
    Assignment(
      'Data Structures Project',
      'Binary Tree Implementation',
      'Nov 10, 2025',
      false,
      'High',
      Colors.red,
    ),
    Assignment(
      'DBMS Assignment',
      'SQL Query Optimization',
      'Nov 8, 2025',
      false,
      'Medium',
      Colors.orange,
    ),
    Assignment(
      'Web Development',
      'Responsive Portfolio Website',
      'Nov 12, 2025',
      false,
      'High',
      Colors.red,
    ),
    Assignment(
      'Operating Systems',
      'Process Scheduling Algorithms',
      'Nov 15, 2025',
      true,
      'Low',
      Colors.green,
    ),
    Assignment(
      'Computer Networks',
      'Routing Protocols Report',
      'Nov 5, 2025',
      true,
      'Medium',
      Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final pendingCount = assignments.where((a) => !a.isCompleted).length;

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
          'Assignments',
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
              _buildStatsCard(pendingCount),
              const SizedBox(height: 30),
              _buildTabSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard(int pendingCount) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Pending', pendingCount.toString(), Icons.pending_actions),
          Container(width: 1, height: 50, color: Colors.white30),
          _buildStatItem('Completed', '${assignments.length - pendingCount}', Icons.check_circle),
          Container(width: 1, height: 50, color: Colors.white30),
          _buildStatItem('Total', '${assignments.length}', Icons.assignment),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildTabSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'All Assignments',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 15),
        ...assignments.map((assignment) => _buildAssignmentCard(assignment)),
      ],
    );
  }

  Widget _buildAssignmentCard(Assignment assignment) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: assignment.priorityColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Checkbox(
            value: assignment.isCompleted,
            onChanged: (value) {
              setState(() {
                assignment.isCompleted = value!;
              });
            },
            fillColor: WidgetStateProperty.resolveWith<Color>(
              (states) => assignment.priorityColor,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  assignment.subject,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: assignment.isCompleted
                        ? Colors.grey.shade600
                        : Colors.white,
                    decoration: assignment.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  assignment.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Due: ${assignment.dueDate}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: assignment.priorityColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              assignment.priority,
              style: TextStyle(
                color: assignment.priorityColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Assignment {
  final String subject;
  final String title;
  final String dueDate;
  bool isCompleted;
  final String priority;
  final Color priorityColor;

  Assignment(
    this.subject,
    this.title,
    this.dueDate,
    this.isCompleted,
    this.priority,
    this.priorityColor,
  );
}
