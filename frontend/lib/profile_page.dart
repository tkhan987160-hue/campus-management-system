import 'package:flutter/material.dart';
import 'dart:typed_data';
// ignore: deprecated_member_use
import 'dart:html' as html;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'id_card_page.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({super.key, required this.username});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Uint8List? _profileImage;

  Future<void> _pickImage() async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((event) async {
      final file = uploadInput.files!.first;
      final reader = html.FileReader();

      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((event) async {
        final bytes = reader.result as Uint8List;

        final prefs = await SharedPreferences.getInstance();

        String base64Image = base64Encode(bytes);

        await prefs.setString('profile_image_${widget.username}', base64Image);

        setState(() {
          _profileImage = bytes;
        });
      });
    });
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();

    String? imageString = prefs.getString('profile_image_${widget.username}');

    if (imageString != null) {
      setState(() {
        _profileImage = base64Decode(imageString);
      });
    }
  }

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
          'Profile',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ScrollbarTheme(
          data: ScrollbarThemeData(
            thumbColor: WidgetStateProperty.all(Colors.white54),
            trackColor: WidgetStateProperty.all(Colors.white12),
            trackBorderColor: WidgetStateProperty.all(Colors.white24),
          ),
          child: Scrollbar(
            controller: _scrollController,
            thumbVisibility: true,
            interactive: true,
            thickness: 8,
            radius: const Radius.circular(12),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    const SizedBox(height: 30),
                    _buildInfoSection(),
                    const SizedBox(height: 20),
                    _buildAcademicSection(),
                    const SizedBox(height: 20),
                    _buildActionButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF607D8B), Color(0xFF78909C)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: const Color(0xFFFF6B35),
                  backgroundImage: _profileImage != null
                      ? MemoryImage(_profileImage!)
                      : null,
                  child: _profileImage == null
                      ? Text(
                          widget.username.isNotEmpty
                              ? widget.username[0].toUpperCase()
                              : 'U',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : null,
                ),
              ),

              Positioned(
                right: -12,
                bottom: -12,
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF6B35),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 15),
          Text(
            widget.username,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'BCA Student • 2nd Year',
            style: TextStyle(fontSize: 14, color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.only(right: 4, left: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(Icons.badge, 'Student ID', 'BCA2023045'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.email, 'Email', '${widget.username}@college.edu'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.phone, 'Phone', '+91 98765 43210'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.calendar_today, 'DOB', '5 sep 2004'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.location_on, 'Address', 'Noida, Uttar Pradesh'),
        ],
      ),
    );
  }

  Widget _buildAcademicSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Academic Details',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          _buildInfoRow(
            Icons.school,
            'Course',
            'BCA (Bachelor of Computer Applications)',
          ),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.calendar_month, 'Semester', '4th Semester'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.grade, 'CGPA', '8.5 / 10'),
          const SizedBox(height: 15),
          _buildInfoRow(Icons.person, 'Mentor', 'Prof. Dr. Sharma'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFF6B35), size: 20),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        _buildActionButton('Change Password', Icons.lock, Colors.blue, () {}),
        const SizedBox(height: 15),
        _buildActionButton(
          'Download ID Card',
          Icons.download,
          Colors.green,
          () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IdCardPage(
                  username: widget.username,
                  profileImage: _profileImage,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 15),
        _buildActionButton('Logout', Icons.logout, Colors.red, () {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }),
      ],
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: color, size: 16),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
