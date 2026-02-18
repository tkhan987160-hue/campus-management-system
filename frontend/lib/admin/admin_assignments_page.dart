import 'package:flutter/material.dart';

class AdminAssignmentsPage extends StatefulWidget {
  const AdminAssignmentsPage({super.key});

  @override
  State<AdminAssignmentsPage> createState() => _AdminAssignmentsPageState();
}

class _AdminAssignmentsPageState extends State<AdminAssignmentsPage> {
  final List<AssignmentData> assignmentsList = [
    AssignmentData('Data Structures', 'Binary Tree Implementation', 'Nov 10, 2025', 'High'),
    AssignmentData('DBMS', 'SQL Query Optimization', 'Nov 8, 2025', 'Medium'),
    AssignmentData('Web Development', 'Responsive Portfolio', 'Nov 12, 2025', 'High'),
  ];

  void _showAddDialog() {
    final subjectController = TextEditingController();
    final titleController = TextEditingController();
    final dateController = TextEditingController();
    String selectedPriority = 'Medium';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          title: const Text('Add Assignment', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: subjectController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Assignment Title',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: dateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Due Date (e.g., Nov 15, 2025)',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: selectedPriority,
                  dropdownColor: const Color(0xFF1a1a1a),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                  items: ['Low', 'Medium', 'High'].map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedPriority = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
              onPressed: () {
                if (subjectController.text.isNotEmpty &&
                    titleController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  setState(() {
                    assignmentsList.add(
                      AssignmentData(
                        subjectController.text,
                        titleController.text,
                        dateController.text,
                        selectedPriority,
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Assignment Added!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(int index) {
    final item = assignmentsList[index];
    final subjectController = TextEditingController(text: item.subject);
    final titleController = TextEditingController(text: item.title);
    final dateController = TextEditingController(text: item.dueDate);
    String selectedPriority = item.priority;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          title: const Text('Edit Assignment', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: subjectController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Assignment Title',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: dateController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Due Date',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                DropdownButtonFormField<String>(
                  initialValue: selectedPriority,
                  dropdownColor: const Color(0xFF1a1a1a),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Priority',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                  items: ['Low', 'Medium', 'High'].map((priority) {
                    return DropdownMenuItem(
                      value: priority,
                      child: Text(priority),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedPriority = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
              onPressed: () {
                setState(() {
                  assignmentsList[index] = AssignmentData(
                    subjectController.text,
                    titleController.text,
                    dateController.text,
                    selectedPriority,
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Assignment Updated!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text('Manage Assignments', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: assignmentsList.length,
        itemBuilder: (context, index) {
          final item = assignmentsList[index];
          Color priorityColor = item.priority == 'High'
              ? Colors.red
              : item.priority == 'Medium'
                  ? Colors.orange
                  : Colors.green;

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: priorityColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.subject,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        item.title,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                          const SizedBox(width: 5),
                          Text(
                            'Due: ${item.dueDate}',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                          ),
                          const SizedBox(width: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: priorityColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item.priority,
                              style: TextStyle(
                                fontSize: 11,
                                color: priorityColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () => _showEditDialog(index),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      assignmentsList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🗑️ Assignment Deleted!'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddDialog,
        backgroundColor: const Color(0xFFFF6B35),
        icon: const Icon(Icons.add),
        label: const Text('Add Assignment'),
      ),
    );
  }
}

class AssignmentData {
  String subject;
  String title;
  String dueDate;
  String priority;

  AssignmentData(this.subject, this.title, this.dueDate, this.priority);
}
