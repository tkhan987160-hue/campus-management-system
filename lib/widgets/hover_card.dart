import 'package:flutter/material.dart';

class HoverCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color color;

  const HoverCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.color,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          transformAlignment: Alignment.center,
          transform: isHover
              ? (Matrix4.identity()
                  ..translate(0.0, -8.0)
                  ..scale(1.02))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(22),

            // 🔥 BORDER GLOW EFFECT
            boxShadow: [
              // Outer glow
              BoxShadow(
                color: widget.color.withOpacity(isHover ? 0.30 : 0.12),
                blurRadius: isHover ? 16 : 8,
                spreadRadius: isHover ? 1 : 0,
              ),

              // Depth shadow
              BoxShadow(
                color: Colors.black.withOpacity(0.30),
                blurRadius: isHover ? 18 : 10,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(widget.icon, color: Colors.white, size: 30),
              const SizedBox(height: 10),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
