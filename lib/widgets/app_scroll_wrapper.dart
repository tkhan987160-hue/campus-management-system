import 'package:flutter/material.dart';

class AppScrollWrapper extends StatefulWidget {
  final Widget child;

  const AppScrollWrapper({super.key, required this.child});

  @override
  State<AppScrollWrapper> createState() => _AppScrollWrapperState();
}

class _AppScrollWrapperState extends State<AppScrollWrapper> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollbarTheme(
      data: ScrollbarThemeData(
        thumbColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.white; // 👈 hover pe white
          }
          return Colors.white.withOpacity(0.35); // normal visible
        }),
        thickness: WidgetStateProperty.all(10),
        radius: const Radius.circular(10),
      ),
      child: Scrollbar(
        controller: _controller,
        thumbVisibility: true,
        interactive: true,
        child: SingleChildScrollView(
          controller: _controller,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: widget.child,
        ),
      ),
    );
  }
}
