import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
// ignore: deprecated_member_use
import 'dart:html' as html;

class IdCardPage extends StatefulWidget {
  final String username;
  final Uint8List? profileImage;

  IdCardPage({super.key, required this.username, required this.profileImage});

  @override
  State<IdCardPage> createState() => _IdCardPageState();
}

class _IdCardPageState extends State<IdCardPage> {
  bool showBack = false;

  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> _downloadIdCard() async {
    final pdf = pw.Document();

    // FRONT IMAGE
    setState(() {
      showBack = false;
    });
    await Future.delayed(const Duration(milliseconds: 500));

    await Future.delayed(const Duration(milliseconds: 500));

    final frontImage = await screenshotController.capture();

    // BACK IMAGE
    setState(() {
      showBack = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));

    final backImage = await screenshotController.capture();

    if (frontImage == null || backImage == null) return;

    final frontProvider = pw.MemoryImage(frontImage);
    final backProvider = pw.MemoryImage(backImage);

    // FRONT PAGE
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(child: pw.Image(frontProvider));
        },
      ),
    );

    // BACK PAGE
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Center(child: pw.Image(backProvider));
        },
      ),
    );

    final bytes = await pdf.save();

    final blob = html.Blob([bytes], 'application/pdf');

    final url = html.Url.createObjectUrlFromBlob(blob);

    html.AnchorElement(href: url)
      ..setAttribute("download", "Campus_ID_Card.pdf")
      ..click();

    html.Url.revokeObjectUrl(url);

    // FRONT pe wapas
    setState(() {
      showBack = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        title: const Text("Student ID Card"),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    showBack = !showBack;
                  });
                },
                child: Text(showBack ? "Show Front" : "Show Back"),
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Colors.orange,
                //   padding: const EdgeInsets.symmetric(
                //     horizontal: 25,
                //     vertical: 12,
                //   ),
              ),
              const SizedBox(height: 20),

              SizedBox(
                height: 520,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 600),

                  transitionBuilder: (child, animation) {
                    final rotateAnim = Tween(
                      begin: 3.14,
                      end: 0.0,
                    ).animate(animation);

                    return AnimatedBuilder(
                      animation: rotateAnim,
                      child: child,
                      builder: (context, child) {
                        return Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(rotateAnim.value),
                          child: child,
                        );
                      },
                    );
                  },

                  child: Screenshot(
                    key: ValueKey(showBack),
                    controller: screenshotController,

                    child: showBack ? _buildBackCard() : _buildFrontCard(),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: _downloadIdCard,
                icon: const Icon(Icons.download),
                label: const Text("Download ID Card"),

                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFrontCard() {
    return Container(
      width: 320,
      height: 520,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),

            child: const Column(
              children: [
                Text(
                  "CAMPUS LINK",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "STUDENT IDENTITY CARD",
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),

          CircleAvatar(
            radius: 55,
            backgroundColor: Colors.orange,

            backgroundImage: widget.profileImage != null
                ? MemoryImage(widget.profileImage!)
                : null,

            child: widget.profileImage == null
                ? const Icon(Icons.person, size: 60, color: Colors.white)
                : null,
          ),

          const SizedBox(height: 20),

          Text(
            widget.username,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 10),

          const Text(
            "BCA Student",
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),

          const SizedBox(height: 20),

          _buildInfo("Roll Number", widget.username),
          _buildInfo("Course", "BCA"),
          _buildInfo("Session", "2023 - 2026"),
          _buildInfo("College", "Campus Link University"),

          const Spacer(),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),

            child: const Text(
              "Authorized Student Card",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackCard() {
    return Container(
      width: 320,
      height: 520,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),

            child: const Text(
              "CAMPUS LINK",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 30),

          _buildInfo("ID Number", widget.username),
          _buildInfo("DOB", "05 Sep 2004"),
          _buildInfo("Emergency", "+91 9876543210"),
          _buildInfo("Address", "Noida, Uttar Pradesh"),

          const SizedBox(height: 30),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "1. Carry ID Card daily.\n\n"
              "2. Report immediately if lost.\n\n"
              "3. Property of Campus Link University.",
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),

          const Spacer(),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),

            child: const Text(
              "Campus Link University",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),

          Text(value),
        ],
      ),
    );
  }
}
