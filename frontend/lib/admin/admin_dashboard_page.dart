import 'package:flutter/material.dart';
import 'admin_attendance_page.dart';
import 'admin_assignments_page.dart';
import 'admin_results_page.dart';
import 'admin_fees_page.dart';
import 'admin_notices_page.dart';
import '../widgets/hover_card.dart';

class AdminDashboardPage extends StatelessWidget {
  final String subject;
  final String adminName;

  const AdminDashboardPage({
    super.key,
    required this.adminName,
    required this.subject,
  });

  bool _isAllowed(String feature) {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => {Navigator.pop(context)},
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, $adminName',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Subject: $subject',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
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
      body: Scrollbar(
        thumbVisibility: true, // 👈 scrollbar hamesha visible
        thickness: 8,
        radius: const Radius.circular(10),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isMobile ? 12 : 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeCard(isMobile),
              const SizedBox(height: 30),
              Text(
                'Manage Campus Data',
                style: TextStyle(
                  fontSize: isMobile ? 18 : 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              GridView.count(
                crossAxisCount: isMobile ? 1 : 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: isMobile ? 3 : 1.5,
                children: [
                  if (_isAllowed('attendance'))
                    HoverCard(
                      icon: Icons.calendar_today,
                      title: 'Attendance',
                      subtitle: 'View & manage',
                      color: Colors.green,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                AdminAttendancePage(subject: subject),
                          ),
                        );
                      },
                    ),

                  if (_isAllowed('assignments'))
                    HoverCard(
                      icon: Icons.assignment,
                      title: 'Assignments',
                      subtitle: '5 pending',
                      color: Colors.orange,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminAssignmentsPage(),
                          ),
                        );
                      },
                    ),

                  if (_isAllowed('results'))
                    HoverCard(
                      icon: Icons.assessment,
                      title: 'Results',
                      subtitle: 'manage  result',
                      color: Colors.blue,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminResultsPage(),
                          ),
                        );
                      },
                    ),

                  if (_isAllowed('fees'))
                    HoverCard(
                      icon: Icons.payment,
                      title: 'Fees',
                      subtitle: 'Manage fees',
                      color: Colors.red,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminFeesPage(),
                          ),
                        );
                      },
                    ),

                  if (_isAllowed('notices'))
                    HoverCard(
                      icon: Icons.notifications,
                      title: 'Notices',
                      subtitle: 'Manage Notices',
                      color: Colors.cyan,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AdminNoticesPage(),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeCard(isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 12 : 25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42), Color(0xFFFFB142)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.admin_panel_settings,
                  size: 50,
                  color: Colors.white,
                ),
                const SizedBox(height: 15),
                const Text(
                  'Welcome, Admin!',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Manage all campus activities from here',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            )
          : const Row(
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
}
