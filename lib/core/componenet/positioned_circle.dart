import 'package:flutter/material.dart';

class PositionedCircle extends StatelessWidget {
  const PositionedCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          right: -18,

          child: Container(
            height: 108,
            width: 108,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withAlpha(120),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(
                    255,
                    243,
                    244,
                    247,
                  ).withOpacity(0.23), // Lighter Navy
                  Color(0xFF0F172A), // Deep Navy
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: -13,

          child: Container(
            height: 108,
            width: 108,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withAlpha(120),
                  blurRadius: 12,
                  spreadRadius: 1,
                  offset: Offset(0, 2),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(
                    255,
                    243,
                    244,
                    247,
                  ).withOpacity(0.23), // Lighter Navy
                  Color(0xFF0F172A), // Deep Navy
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
