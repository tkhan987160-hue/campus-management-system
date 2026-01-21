import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// Import all page files
import 'attendance_page.dart';
import 'assignments_page.dart';
import 'result_page.dart';
import 'library_page.dart';
import 'timetable_page.dart';
import 'fees_page.dart';
import 'notice_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  final String username;
  final String studentId;

  const HomePage({super.key, required this.username, required this.studentId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double? attendancePercentage;
  bool isLoadingAttendance = true;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchAttendance();
  }

  Future<void> fetchAttendance() async {
    try {
      final url = Uri.parse(
        'http://10.0.2.2:5000/api/attendance/stats/${widget.studentId}',
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          attendancePercentage = (data['attendancePercentage'] as num)
              .toDouble();
          isLoadingAttendance = false;
        });
      } else {
        throw Exception('Failed to load attendance');
      }
    } catch (e) {
      setState(() {
        attendancePercentage = 0;
        isLoadingAttendance = false;
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  final List<DashboardCard> _dashboardItems = [
    DashboardCard(
      title: 'Attendance',
      subtitle: '',
      icon: Icons.calendar_today,
      color: const Color(0xFF4CAF50),
      gradient: const LinearGradient(
        colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
      ),
    ),
    DashboardCard(
      title: 'Assignments',
      subtitle: '5 Pending',
      icon: Icons.assignment,
      color: const Color(0xFFFF9800),
      gradient: const LinearGradient(
        colors: [Color(0xFFFF9800), Color(0xFFFFB74D)],
      ),
    ),
    DashboardCard(
      title: 'Results',
      subtitle: 'View Marks',
      icon: Icons.assessment,
      color: const Color(0xFF2196F3),
      gradient: const LinearGradient(
        colors: [Color(0xFF2196F3), Color(0xFF42A5F5)],
      ),
    ),
    DashboardCard(
      title: 'Library',
      subtitle: '2 Books Issued',
      icon: Icons.menu_book,
      color: const Color(0xFF9C27B0),
      gradient: const LinearGradient(
        colors: [Color(0xFF9C27B0), Color(0xFFAB47BC)],
      ),
    ),
    DashboardCard(
      title: 'Timetable',
      subtitle: 'View Schedule',
      icon: Icons.schedule,
      color: const Color(0xFFE91E63),
      gradient: const LinearGradient(
        colors: [Color(0xFFE91E63), Color(0xFFEC407A)],
      ),
    ),
    DashboardCard(
      title: 'Fees',
      subtitle: 'Payment Due',
      icon: Icons.payment,
      color: const Color(0xFFF44336),
      gradient: const LinearGradient(
        colors: [Color(0xFFF44336), Color(0xFFEF5350)],
      ),
    ),
    DashboardCard(
      title: 'Notice Board',
      subtitle: '3 New Updates',
      icon: Icons.notifications,
      color: const Color(0xFF00BCD4),
      gradient: const LinearGradient(
        colors: [Color(0xFF00BCD4), Color(0xFF26C6DA)],
      ),
    ),
    DashboardCard(
      title: 'Profile',
      subtitle: 'Edit Details',
      icon: Icons.person,
      color: const Color(0xFF607D8B),
      gradient: const LinearGradient(
        colors: [Color(0xFF607D8B), Color(0xFF78909C)],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      body: SafeArea(
        child: ScrollbarTheme(
          data: ScrollbarThemeData(
            // 👇 NORMAL state (thoda dull)
            thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
              if (states.contains(WidgetState.hovered)) {
                return Colors.white; // 🔥 hover par white
              }
              return Colors.white54; // normal visible
            }),

            trackColor: WidgetStateProperty.all(Colors.white12),

            trackBorderColor: WidgetStateProperty.all(Colors.white24),
          ),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            trackVisibility: true,
            thickness: 8,
            radius: const Radius.circular(12),
            interactive: true,
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 20, 32, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(),
                  const SizedBox(height: 20),
                  _buildWelcomeSection(),
                  const SizedBox(height: 30),
                  _buildQuickStats(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Quick Access'),
                  const SizedBox(height: 15),
                  _buildDashboardGrid(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Recent Activity'),
                  const SizedBox(height: 15),
                  _buildRecentActivity(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFFF6B35).withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'CAMPUS LINK',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF6B35),
              letterSpacing: 1.5,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ProfilePage(username: widget.username),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF6B35),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWelcomeSection() {
    final hour = DateTime.now().hour;
    String greeting = 'Good Morning';
    if (hour >= 12 && hour < 17) {
      greeting = 'Good Afternoon';
    } else if (hour >= 17) {
      greeting = 'Good Evening';
    }

    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF8C42), Color(0xFFFFB142)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B35).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  greeting,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.username,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'BCA Student • 2nd Year',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Icon(Icons.school, size: 50, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        _buildStatCard(
          'Attendance',
          isLoadingAttendance
              ? '--'
              : '${attendancePercentage?.toStringAsFixed(0)}%',
          Icons.check_circle,
          Colors.green,
        ),
        const SizedBox(width: 15),
        _buildStatCard('CGPA', '8.5', Icons.star, Colors.amber),
        const SizedBox(width: 15),
        _buildStatCard('Rank', '#12', Icons.emoji_events, Colors.orange),
      ],
    );
  }

  Widget _buildStatCard(
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildDashboardGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 50,
        mainAxisSpacing: 50,
        childAspectRatio: 1.4,
      ),
      itemCount: _dashboardItems.length,
      itemBuilder: (context, index) {
        final item = _dashboardItems[index];
        return _buildDashboardCard(item);
      },
    );
  }

  Widget _buildDashboardCard(DashboardCard card) {
    return _AnimatedHoverCard(
      onTap: () {
        Widget? page;

        if (card.title == 'Attendance') {
          page = AttendancePage(studentId: widget.studentId);
        } else if (card.title == 'Assignments') {
          page = const AssignmentsPage();
        } else if (card.title == 'Results') {
          page = const ResultsPage();
        } else if (card.title == 'Library') {
          page = const LibraryPage();
        } else if (card.title == 'Timetable') {
          page = const TimetablePage();
        } else if (card.title == 'Fees') {
          page = const FeesPage();
        } else if (card.title == 'Notice Board') {
          page = const NoticePage();
        } else if (card.title == 'Profile') {
          page = ProfilePage(username: widget.username);
        }

        if (page != null) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
        }
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: card.gradient,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: card.color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(card.icon, color: Colors.white, size: 28),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  card.subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          _buildActivityItem(
            'New Assignment Posted',
            'Data Structures - Due: Nov 10',
            Icons.assignment,
            Colors.orange,
          ),
          const Divider(color: Colors.grey, height: 30),
          _buildActivityItem(
            'Attendance Updated',
            'Database Management - 95%',
            Icons.check_circle,
            Colors.green,
          ),
          const Divider(color: Colors.grey, height: 30),
          _buildActivityItem(
            'Result Published',
            'Mid-Term Examination',
            Icons.assessment,
            Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    IconData icon,
    Color color,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: Colors.grey.shade600, size: 16),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        border: Border(
          top: BorderSide(
            color: const Color(0xFFFF6B35).withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Colors.transparent,
        selectedItemColor: const Color(0xFFFF6B35),
        unselectedItemColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Courses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class _AnimatedHoverCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _AnimatedHoverCard({required this.child, required this.onTap});

  @override
  State<_AnimatedHoverCard> createState() => _AnimatedHoverCardState();
}

class _AnimatedHoverCardState extends State<_AnimatedHoverCard> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: _hover
              ? (Matrix4.identity()..translate(0.0, -8.0))
              : Matrix4.identity(),
          child: widget.child,
        ),
      ),
    );
  }
}

class DashboardCard {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final LinearGradient gradient;

  DashboardCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.gradient,
  });
}
