import 'package:flutter/material.dart';

class TextAction extends StatelessWidget {
  const TextAction({
    super.key,
    required this.text,
    required this.onPressed,
    required this.backGrounColor,
    this.textColor = Colors.white,
    this.height = 67,
    this.width = 300,
  });
  final String text;
  final Color backGrounColor;
  final Color textColor;
  final double height;
  final double width;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backGrounColor,
            borderRadius: BorderRadius.circular(13),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontSize: 21,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
