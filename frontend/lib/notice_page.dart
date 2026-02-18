import 'package:campus_link/widgets/app_scroll_wrapper.dart';
import 'package:flutter/material.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Notice> notices = [
      Notice(
        'Mid-Term Exam Schedule Released',
        'The schedule for mid-term examinations has been posted on the portal.',
        'Nov 2, 2025',
        'Academics',
        Colors.blue,
        true,
      ),
      Notice(
        'College Fest - Tech Carnival 2025',
        'Annual tech fest will be held on Nov 20-22. Registration open now!',
        'Nov 1, 2025',
        'Events',
        Colors.orange,
        true,
      ),
      Notice(
        'Library Timing Changes',
        'Library will be open till 8 PM from next week onwards.',
        'Oct 30, 2025',
        'Announcement',
        Colors.purple,
        false,
      ),
      Notice(
        'Scholarship Applications Open',
        'Merit-based scholarship applications are now open. Deadline: Nov 15.',
        'Oct 28, 2025',
        'Important',
        Colors.red,
        false,
      ),
      Notice(
        'Sports Day - Nov 18',
        'Inter-department sports competition. Register with your class representative.',
        'Oct 25, 2025',
        'Sports',
        Colors.green,
        false,
      ),
    ];

    int unreadCount = notices.where((n) => n.isNew).length;

    return Scaffold(
      backgroundColor: const Color(0xFF0a0a0a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notice Board',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: AppScrollWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(unreadCount, notices.length),
              const SizedBox(height: 30),
              const Text(
                'Recent Notices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              ...notices.map((notice) => _buildNoticeCard(notice, context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(int unread, int total) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF00BCD4), Color(0xFF26C6DA)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Icon(Icons.notifications_active, color: Colors.white, size: 35),
              const SizedBox(height: 10),
              Text(
                '$unread',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'New',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          Container(width: 1, height: 60, color: Colors.white30),
          Column(
            children: [
              const Icon(Icons.notifications, color: Colors.white, size: 35),
              const SizedBox(height: 10),
              Text(
                '$total',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                'Total',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeCard(Notice notice, BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showNoticeDetails(context, notice);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: notice.color.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: notice.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.notifications,
                color: notice.color,
                size: 24,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          notice.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      if (notice.isNew)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'NEW',
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    notice.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: notice.color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          notice.category,
                          style: TextStyle(
                            fontSize: 11,
                            color: notice.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Icon(Icons.calendar_today, size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 5),
                      Text(
                        notice.date,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNoticeDetails(BuildContext context, Notice notice) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1a1a1a),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.notifications, color: notice.color),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                notice.title,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: notice.color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                notice.category,
                style: TextStyle(
                  color: notice.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              notice.description,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 15,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Icon(Icons.calendar_today, size: 14, color: Colors.grey.shade500),
                const SizedBox(width: 5),
                Text(
                  notice.date,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class Notice {
  final String title;
  final String description;
  final String date;
  final String category;
  final Color color;
  final bool isNew;

  Notice(
    this.title,
    this.description,
    this.date,
    this.category,
    this.color,
    this.isNew,
  );
}
