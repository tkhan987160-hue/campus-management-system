import 'package:flutter/material.dart';

class AdminFeesPage extends StatefulWidget {
  const AdminFeesPage({super.key});

  @override
  State<AdminFeesPage> createState() => _AdminFeesPageState();
}

class _AdminFeesPageState extends State<AdminFeesPage> {
  final List<FeeData> feesList = [
    FeeData('Semester Fee', 45000, 'Nov 15, 2025'),
    FeeData('Library Fee', 2000, 'Oct 1, 2025'),
    FeeData('Exam Fee', 3000, 'Sep 20, 2025'),
  ];

  void _showAddDialog() {
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final dateController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text('Add Fee', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Fee Title',
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
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Amount (₹)',
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
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF6B35)),
            onPressed: () {
              if (titleController.text.isNotEmpty &&
                  amountController.text.isNotEmpty &&
                  dateController.text.isNotEmpty) {
                setState(() {
                  feesList.add(
                    FeeData(
                      titleController.text,
                      int.parse(amountController.text),
                      dateController.text,
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Fee Added!'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(int index) {
    final item = feesList[index];
    final titleController = TextEditingController(text: item.title);
    final amountController = TextEditingController(text: item.amount.toString());
    final dateController = TextEditingController(text: item.dueDate);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text('Edit Fee', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Fee Title',
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
              controller: amountController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Amount (₹)',
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
          ],
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
                feesList[index] = FeeData(
                  titleController.text,
                  int.parse(amountController.text),
                  dateController.text,
                );
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ Fee Updated!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text('Manage Fees', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: feesList.length,
        itemBuilder: (context, index) {
          final item = feesList[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.red.withOpacity(0.3)),
            ),
            child: Row(
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
                        '₹${item.amount}',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
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
                      feesList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🗑️ Fee Deleted!'),
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
        label: const Text('Add Fee'),
      ),
    );
  }
}

class FeeData {
  String title;
  int amount;
  String dueDate;

  FeeData(this.title, this.amount, this.dueDate);
}
