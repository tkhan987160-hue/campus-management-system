import 'package:flutter/material.dart';
import 'admin_attendance_page.dart'; 
import 'admin_assignments_page.dart';
import 'admin_results_page.dart';
import 'admin_fees_page.dart';
import 'admin_notices_page.dart';

class AdminDashboardPage extends StatelessWidget {
  const AdminDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Row(
          children: [
            Icon(Icons.admin_panel_settings, color: Color(0xFFFF6B35)),
            SizedBox(width: 10),
            Text(
              'Admin Panel',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 30),
            const Text(
              'Manage Campus Data',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: [
                _buildAdminCard(
                  context,
                  'Manage Attendance',
                  Icons.calendar_today,
                  Colors.green,
                  const AdminAttendancePage(),
                ),
                _buildAdminCard(
                  context,
                  'Manage Assignments',
                  Icons.assignment,
                  Colors.orange,
                  const AdminAssignmentsPage(),
                ),
                _buildAdminCard(
                  context,
                  'Manage Results',
                  Icons.assessment,
                  Colors.blue,
                  const AdminResultsPage(),
                ),
                _buildAdminCard(
                  context,
                  'Manage Fees',
                  Icons.payment,
                  Colors.red,
                  const AdminFeesPage(),
                ),
                _buildAdminCard(
                  context,
                  'Manage Notices',
                  Icons.notifications,
                  Colors.cyan,
                  const AdminNoticesPage(),
                ),
                _buildAdminCard(
                  context,
                  'Student Reports',
                  Icons.people,
                  Colors.purple,
                  null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42), Color(0xFFFFB142)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Row(
        children: [
          Icon(Icons.admin_panel_settings, size: 50, color: Colors.white),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Admin!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Manage all campus activities from here',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdminCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget? page,
  ) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coming Soon!')),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: color),
            const SizedBox(height: 15),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
