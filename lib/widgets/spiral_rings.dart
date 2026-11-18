import 'package:flutter/material.dart';

class SpiralRings extends StatelessWidget {
  final int ringsCount;
  const SpiralRings({super.key, required this.ringsCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(ringsCount, (_) {
        return Container(
          width: 6,
          height: 22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            gradient: const LinearGradient(
              colors: [
                Color(0xFF555555),
                Color(0xFFE8E8E8),
                Color(0xFFFFFFFF),
                Color(0xFF888888),
                Color(0xFF333333),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        );
      }),
    );
  }
}
