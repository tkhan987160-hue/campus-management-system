import 'package:flutter/material.dart';

class AdminResultsPage extends StatefulWidget {
  const AdminResultsPage({super.key});

  @override
  State<AdminResultsPage> createState() => _AdminResultsPageState();
}

class _AdminResultsPageState extends State<AdminResultsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text(
          'Manage Results',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Container(
            width: 1200,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF1a1a1a)),
            ),
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(
                const Color(0xFF1a1a1a),
              ),
              dataRowColor: MaterialStateProperty.all(const Color(0xFF111111)),
              columns: const [
                DataColumn(
                  label: Text('Roll No', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text(
                    'Student Name',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                DataColumn(
                  label: Text('DBMS', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text('Web Dev', style: TextStyle(color: Colors.white)),
                ),
                DataColumn(
                  label: Text(
                    'Data Structure',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
              rows: const [
                DataRow(
                  cells: [
                    DataCell(
                      Text('101', style: TextStyle(color: Colors.white)),
                    ),
                    DataCell(
                      Text('Tosif Khan', style: TextStyle(color: Colors.white)),
                    ),
                    DataCell(Text('89', style: TextStyle(color: Colors.green))),
                    DataCell(
                      Text('54', style: TextStyle(color: Colors.orange)),
                    ),
                    DataCell(Text('55', style: TextStyle(color: Colors.blue))),
                  ],
                ),

                DataRow(
                  cells: [
                    DataCell(
                      Text('102', style: TextStyle(color: Colors.white)),
                    ),
                    DataCell(
                      Text('Kasif Khan', style: TextStyle(color: Colors.white)),
                    ),
                    DataCell(Text('78', style: TextStyle(color: Colors.green))),
                    DataCell(
                      Text('67', style: TextStyle(color: Colors.orange)),
                    ),
                    DataCell(Text('81', style: TextStyle(color: Colors.blue))),
                  ],
                ),

                DataRow(
                  cells: [
                    DataCell(
                      Text('103', style: TextStyle(color: Colors.white)),
                    ),
                    DataCell(
                      Text(
                        'Gungun kumari',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(Text('91', style: TextStyle(color: Colors.green))),
                    DataCell(
                      Text('88', style: TextStyle(color: Colors.orange)),
                    ),
                    DataCell(Text('79', style: TextStyle(color: Colors.blue))),
                  ],
                ),

                DataRow(
                  cells: [
                    DataCell(
                      Text('104', style: TextStyle(color: Colors.white)),
                    ),
                    DataCell(
                      Text(
                        'Pinki Nayak',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DataCell(Text('75', style: TextStyle(color: Colors.green))),
                    DataCell(
                      Text('57', style: TextStyle(color: Colors.orange)),
                    ),
                    DataCell(Text('82', style: TextStyle(color: Colors.blue))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
