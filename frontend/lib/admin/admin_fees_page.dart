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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
            ),
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
    final amountController = TextEditingController(
      text: item.amount.toString(),
    );
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
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF6B35),
            ),
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
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Container(
              width: 1300,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1a1a1a),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DataTable(
                columnSpacing: 70,
                headingRowHeight: 70,
                dataRowMinHeight: 70,

                headingRowColor: MaterialStateProperty.all(
                  const Color(0xFF222222),
                ),

                columns: const [
                  DataColumn(
                    label: Text(
                      'Roll No',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Student Name',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Total Fees',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  DataColumn(
                    label: Text('Paid', style: TextStyle(color: Colors.white)),
                  ),

                  DataColumn(
                    label: Text(
                      'Pending',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Status',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  DataColumn(
                    label: Text(
                      'Notify',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],

                rows: [
                  DataRow(
                    cells: [
                      DataCell(
                        Text('101', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text(
                          'Tosif Khan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      DataCell(
                        Text('₹45000', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text('₹45000', style: TextStyle(color: Colors.green)),
                      ),

                      DataCell(
                        Text('₹0', style: TextStyle(color: Colors.green)),
                      ),

                      DataCell(
                        Text(
                          'PAID',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      DataCell(Icon(Icons.notifications, color: Colors.green)),
                    ],
                  ),

                  DataRow(
                    cells: [
                      DataCell(
                        Text('102', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text(
                          'Kasif Khan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      DataCell(
                        Text('₹45000', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text('₹20000', style: TextStyle(color: Colors.orange)),
                      ),

                      DataCell(
                        Text('₹25000', style: TextStyle(color: Colors.red)),
                      ),

                      DataCell(
                        Text(
                          'PENDING',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      DataCell(
                        Icon(Icons.notifications_active, color: Colors.red),
                      ),
                    ],
                  ),

                  DataRow(
                    cells: [
                      DataCell(
                        Text('103', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text('Gungun', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text('₹45000', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text('₹40000', style: TextStyle(color: Colors.orange)),
                      ),

                      DataCell(
                        Text('₹5000', style: TextStyle(color: Colors.red)),
                      ),

                      DataCell(
                        Text(
                          'PENDING',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      DataCell(
                        Icon(Icons.notifications_active, color: Colors.red),
                      ),
                    ],
                  ),

                  DataRow(
                    cells: [
                      DataCell(
                        Text('104', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text(
                          'Pinki nayak',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      DataCell(
                        Text('₹45000', style: TextStyle(color: Colors.white)),
                      ),

                      DataCell(
                        Text('₹45000', style: TextStyle(color: Colors.orange)),
                      ),

                      DataCell(Text('₹0', style: TextStyle(color: Colors.red))),

                      DataCell(
                        Text(
                          'PAID',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      DataCell(Icon(Icons.notifications, color: Colors.green)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
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
