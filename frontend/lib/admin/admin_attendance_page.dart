import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AdminAttendancePage extends StatefulWidget {
  final String subject;

  const AdminAttendancePage({super.key, required this.subject});

  @override
  State<AdminAttendancePage> createState() => _AdminAttendancePageState();
}

class _AdminAttendancePageState extends State<AdminAttendancePage> {
  Map<String, List<Map<String, dynamic>>> attendanceRegister = {};
  // 🔹 STEP 3.1: Class & Section selection
  String selectedClass = 'BCA 2nd Year';
  String selectedSection = 'A';

  Future<void> fetchStudents() async {
    final url = Uri.parse('http://10.0.2.2:5000/api/students');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        setState(() {
          students = data.map((s) {
            return {
              'id': s['_id'],
              'rollNumber': s['rollNumber'],
              'name': s['name'],
              'status': 'P', // default Present
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load students');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ $e'), backgroundColor: Colors.red),
      );
    }
  }

  // 🔹 STEP 3.3: Filtered students list
  List<Map<String, dynamic>> students = [];

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void _loadAttendanceForDate() {
    fetchStudents();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _loadAttendanceForDate();
      });
    }
  }

  Future<void> _saveAttendance() async {
    final date =
        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';

    for (final student in students) {
      final url = Uri.parse('http://10.0.2.2:5000/api/attendance/mark');

      await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'studentId': student['id'],
          'subject': widget.subject,
          'date': date,
          'status': student['status'], // P / A / L
        }),
      );
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Attendance saved successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  String _dateKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  String _attendanceKey() {
    return '${widget.subject}_$selectedClass'
        '_$selectedSection${_dateKey(selectedDate)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),

      // 🔹 TOP BAR (Attendance + Back Arrow)
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Attendance",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Class Dropdown
                DropdownButton<String>(
                  value: selectedClass,
                  dropdownColor: Colors.grey.shade900,
                  items: ['BCA 2nd Year', 'BCA 1st Year']
                      .map(
                        (c) => DropdownMenuItem(
                          value: c,
                          child: Text(
                            c,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClass = value!;
                      _loadAttendanceForDate();
                    });
                  },
                ),

                // Section Dropdown
                DropdownButton<String>(
                  value: selectedSection,
                  dropdownColor: Colors.grey.shade900,
                  items: ['A', 'B']
                      .map(
                        (s) => DropdownMenuItem(
                          value: s,
                          child: Text(
                            s,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSection = value!;
                      _loadAttendanceForDate();
                    });
                  },
                ),
              ],
            ),
            // 📅 Date Picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Date: ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                IconButton(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.calendar_today, color: Colors.orange),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // 📋 Table Header
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      'RollNumber',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      'Name',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Status',
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 👥 Students List
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];

                  student['status'] ??= 'P'; // default Present

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a1a),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        // 🔢 Roll No
                        Expanded(
                          flex: 2,
                          child: Text(
                            student['rollNumber'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),

                        // 👤 Name
                        Expanded(
                          flex: 4,
                          child: Text(
                            student['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),

                        // ✅ Status (P / A / L)
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              _statusButton(student, 'P', Colors.green),
                              _statusButton(student, 'A', Colors.red),
                              _statusButton(student, 'L', Colors.orange),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // 💾 Save Button
            SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(14),
                elevation: 8,
                shadowColor: Colors.black,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14),
                  splashColor: Colors.black.withOpacity(0.2), // 🔥 click ripple
                  highlightColor: Colors.black.withOpacity(
                    0.1,
                  ), // 🔥 press effect
                  onTap: _saveAttendance,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.save, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          'SAVE ATTENDANCE',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusButton(
    Map<String, dynamic> student,
    String value,
    Color color,
  ) {
    final bool isSelected = student['status'] == value;

    return GestureDetector(
      onTap: () {
        setState(() {
          student['status'] = value;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: isSelected ? Colors.white : color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
