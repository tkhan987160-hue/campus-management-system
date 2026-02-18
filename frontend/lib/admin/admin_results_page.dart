import 'package:flutter/material.dart';

class AdminResultsPage extends StatefulWidget {
  const AdminResultsPage({super.key});

  @override
  State<AdminResultsPage> createState() => _AdminResultsPageState();
}

class _AdminResultsPageState extends State<AdminResultsPage> {
  final List<ResultData> resultsList = [
    ResultData('Data Structures', 85, 90),
    ResultData('DBMS', 78, 82),
    ResultData('Web Development', 92, 88),
  ];

  void _showAddDialog() {
    final subjectController = TextEditingController();
    final midTermController = TextEditingController();
    final endTermController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text('Add Result', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: subjectController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Subject Name',
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
              controller: midTermController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Mid-Term Marks',
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
              controller: endTermController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'End-Term Marks',
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
              if (subjectController.text.isNotEmpty &&
                  midTermController.text.isNotEmpty &&
                  endTermController.text.isNotEmpty) {
                setState(() {
                  resultsList.add(
                    ResultData(
                      subjectController.text,
                      int.parse(midTermController.text),
                      int.parse(endTermController.text),
                    ),
                  );
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Result Added!'),
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
    final item = resultsList[index];
    final subjectController = TextEditingController(text: item.subject);
    final midTermController = TextEditingController(text: item.midTerm.toString());
    final endTermController = TextEditingController(text: item.endTerm.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text('Edit Result', style: TextStyle(color: Colors.white)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: subjectController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Subject Name',
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
              controller: midTermController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Mid-Term Marks',
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
              controller: endTermController,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'End-Term Marks',
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
                resultsList[index] = ResultData(
                  subjectController.text,
                  int.parse(midTermController.text),
                  int.parse(endTermController.text),
                );
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('✅ Result Updated!'),
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
        title: const Text('Manage Results', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: resultsList.length,
        itemBuilder: (context, index) {
          final item = resultsList[index];
          final total = item.midTerm + item.endTerm;

          return Container(
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.blue.withOpacity(0.3)),
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
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildMarkItem('Mid', item.midTerm),
                          _buildMarkItem('End', item.endTerm),
                          _buildMarkItem('Total', total),
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
                      resultsList.removeAt(index);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🗑️ Result Deleted!'),
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
        label: const Text('Add Result'),
      ),
    );
  }

  Widget _buildMarkItem(String label, int marks) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
        ),
        const SizedBox(height: 5),
        Text(
          '$marks',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class ResultData {
  String subject;
  int midTerm;
  int endTerm;

  ResultData(this.subject, this.midTerm, this.endTerm);
}
