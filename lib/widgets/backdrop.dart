import 'package:flutter/material.dart';

class Backdrop extends StatelessWidget {
  const Backdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [Color(0xFF161A24), Color(0xFF0C0E14), Color(0xFF07080C)],
          center: Alignment(0, -0.2),
          radius: 1.3,
        ),
      ),
    );
  }
}
