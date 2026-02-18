import 'package:flutter/material.dart';

class AdminNoticesPage extends StatefulWidget {
  const AdminNoticesPage({super.key});

  @override
  State<AdminNoticesPage> createState() => _AdminNoticesPageState();
}

class _AdminNoticesPageState extends State<AdminNoticesPage> {
  final List<NoticeData> noticesList = [
    NoticeData(
      'Mid-Term Exam Schedule Released',
      'The schedule for mid-term examinations has been posted.',
      'Academics',
    ),
    NoticeData(
      'College Fest - Tech Carnival 2025',
      'Annual tech fest will be held on Nov 20-22.',
      'Events',
    ),
  ];

  void _showAddDialog() {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    String selectedCategory = 'Academics';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          title: const Text('Add Notice', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Notice Title',
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
                  controller: descController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
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
                  initialValue: selectedCategory,
                  dropdownColor: const Color(0xFF1a1a1a),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                  items: ['Academics', 'Events', 'Important', 'Sports', 'Announcement']
                      .map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedCategory = value!;
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
                if (titleController.text.isNotEmpty && descController.text.isNotEmpty) {
                  setState(() {
                    noticesList.insert(
                      0,
                      NoticeData(
                        titleController.text,
                        descController.text,
                        selectedCategory,
                      ),
                    );
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('✅ Notice Published!'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              child: const Text('Publish'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(int index) {
    final item = noticesList[index];
    final titleController = TextEditingController(text: item.title);
    final descController = TextEditingController(text: item.description);
    String selectedCategory = item.category;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF1a1a1a),
          title: const Text('Edit Notice', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Notice Title',
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
                  controller: descController,
                  maxLines: 3,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Description',
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
                  initialValue: selectedCategory,
                  dropdownColor: const Color(0xFF1a1a1a),
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Category',
                    labelStyle: TextStyle(color: Colors.grey.shade400),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFF6B35)),
                    ),
                  ),
                  items: ['Academics', 'Events', 'Important', 'Sports', 'Announcement']
                      .map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setDialogState(() {
                      selectedCategory = value!;
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
                  noticesList[index] = NoticeData(
                    titleController.text,
                    descController.text,
                    selectedCategory,
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Notice Updated!'),
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
        title: const Text('Manage Notices', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: noticesList.length,
        itemBuilder: (context, index) {
          final item = noticesList[index];
          Color categoryColor = _getCategoryColor(item.category);

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: categoryColor.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.description,
                            style: TextStyle(fontSize: 14, color: Colors.grey.shade400),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: categoryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              item.category,
                              style: TextStyle(
                                fontSize: 11,
                                color: categoryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _showEditDialog(index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              noticesList.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('🗑️ Notice Deleted!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
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
        label: const Text('Add Notice'),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Academics':
        return Colors.blue;
      case 'Events':
        return Colors.orange;
      case 'Important':
        return Colors.red;
      case 'Sports':
        return Colors.green;
      case 'Announcement':
        return Colors.purple;
      default:
        return Colors.cyan;
    }
  }
}

class NoticeData {
  String title;
  String description;
  String category;

  NoticeData(this.title, this.description, this.category);
}
