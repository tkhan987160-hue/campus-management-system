import 'package:campus_link/widgets/app_scroll_wrapper.dart';
import 'package:flutter/material.dart';

class TimetablePage extends StatefulWidget {
  const TimetablePage({super.key});

  @override
  State<TimetablePage> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<TimetablePage> {
  int _selectedDay = DateTime.now().weekday - 1;

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

  final Map<int, List<TimeSlot>> timetable = {
    0: [
      // Monday
      TimeSlot(
        '9:00 AM',
        '10:00 AM',
        'Data Structures',
        'Room 101',
        'Dr. Sharma',
        Colors.blue,
      ),
      TimeSlot(
        '10:15 AM',
        '11:15 AM',
        'DBMS',
        'Room 205',
        'Prof. Gupta',
        Colors.green,
      ),
      TimeSlot(
        '11:30 AM',
        '12:30 PM',
        'Web Development',
        'Lab 3',
        'Ms. Verma',
        Colors.orange,
      ),
      TimeSlot(
        '1:30 PM',
        '2:30 PM',
        'Operating Systems',
        'Room 102',
        'Dr. Singh',
        Colors.purple,
      ),
    ],
    1: [
      // Tuesday
      TimeSlot(
        '9:00 AM',
        '10:00 AM',
        'Computer Networks',
        'Room 201',
        'Prof. Kumar',
        Colors.red,
      ),
      TimeSlot(
        '10:15 AM',
        '11:15 AM',
        'Data Structures Lab',
        'Lab 1',
        'Dr. Sharma',
        Colors.blue,
      ),
      TimeSlot(
        '11:30 AM',
        '12:30 PM',
        'DBMS',
        'Room 205',
        'Prof. Gupta',
        Colors.green,
      ),
      TimeSlot(
        '1:30 PM',
        '2:30 PM',
        'Web Development',
        'Lab 3',
        'Ms. Verma',
        Colors.orange,
      ),
    ],
    2: [
      // Wednesday
      TimeSlot(
        '9:00 AM',
        '10:00 AM',
        'Operating Systems',
        'Room 102',
        'Dr. Singh',
        Colors.purple,
      ),
      TimeSlot(
        '10:15 AM',
        '11:15 AM',
        'Computer Networks',
        'Room 201',
        'Prof. Kumar',
        Colors.red,
      ),
      TimeSlot(
        '11:30 AM',
        '12:30 PM',
        'Data Structures',
        'Room 101',
        'Dr. Sharma',
        Colors.blue,
      ),
    ],
    3: [
      // Thursday
      TimeSlot(
        '9:00 AM',
        '10:00 AM',
        'DBMS Lab',
        'Lab 2',
        'Prof. Gupta',
        Colors.green,
      ),
      TimeSlot(
        '10:15 AM',
        '11:15 AM',
        'Web Development',
        'Lab 3',
        'Ms. Verma',
        Colors.orange,
      ),
      TimeSlot(
        '1:30 PM',
        '2:30 PM',
        'Operating Systems',
        'Room 102',
        'Dr. Singh',
        Colors.purple,
      ),
    ],
    4: [
      // Friday
      TimeSlot(
        '9:00 AM',
        '10:00 AM',
        'Data Structures',
        'Room 101',
        'Dr. Sharma',
        Colors.blue,
      ),
      TimeSlot(
        '10:15 AM',
        '11:15 AM',
        'Computer Networks Lab',
        'Lab 4',
        'Prof. Kumar',
        Colors.red,
      ),
      TimeSlot(
        '11:30 AM',
        '12:30 PM',
        'Project Work',
        'Lab 3',
        'Ms. Verma',
        Colors.orange,
      ),
    ],
    5: [
      // Saturday
      TimeSlot(
        '9:00 AM',
        '10:00 AM',
        'Library Session',
        'Library',
        'Self Study',
        Colors.teal,
      ),
      TimeSlot(
        '10:15 AM',
        '12:00 PM',
        'Sports Activity',
        'Ground',
        'PT Teacher',
        Colors.amber,
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
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
          'Timetable',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          _buildDaySelector(),
          Expanded(
            child: SafeArea(
              child: AppScrollWrapper(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCurrentDayInfo(),
                    const SizedBox(height: 20),
                    ...(timetable[_selectedDay] ?? []).map(
                      (slot) => _buildTimeSlotCard(slot),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDaySelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      color: const Color(0xFF1a1a1a),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: List.generate(
            days.length,
            (index) => GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDay = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: _selectedDay == index
                      ? const LinearGradient(
                          colors: [Color(0xFFE91E63), Color(0xFFEC407A)],
                        )
                      : null,
                  color: _selectedDay != index ? Colors.grey.shade800 : null,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  days[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: _selectedDay == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCurrentDayInfo() {
    int totalClasses = timetable[_selectedDay]?.length ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE91E63), Color(0xFFEC407A)],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                days[_selectedDay],
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '$totalClasses Classes Today',
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.schedule, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotCard(TimeSlot slot) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: slot.color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 80,
            decoration: BoxDecoration(
              color: slot.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  slot.subject,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      '${slot.startTime} - ${slot.endTime}',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 14,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      slot.room,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Icon(Icons.person, size: 14, color: Colors.grey.shade500),
                    const SizedBox(width: 5),
                    Text(
                      slot.teacher,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TimeSlot {
  final String startTime;
  final String endTime;
  final String subject;
  final String room;
  final String teacher;
  final Color color;

  TimeSlot(
    this.startTime,
    this.endTime,
    this.subject,
    this.room,
    this.teacher,
    this.color,
  );
}
