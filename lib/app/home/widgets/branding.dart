// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class Branding extends StatelessWidget {
  const Branding({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 14, top: 7, bottom: 7),
      decoration: BoxDecoration(
        color:  theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.onSurface.withOpacity(0.08), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Gradient logo pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF4D4D), Color(0xFFFF9B00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child:  Text(
              "REEL DROP",
              style:  theme.textTheme.bodySmall!.copyWith(
                fontSize: 9,
                fontWeight: FontWeight.w700,
                color:Colors.white,
                letterSpacing: 0.6,
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Vertical divider
          Container(
            width: 0.5,
            height: 18,
            color:theme.colorScheme.scrim.withAlpha(67),
          ),

          const SizedBox(width: 10),

          // Published by + name
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "PUBLISHED BY",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                  color: theme.colorScheme.scrim.withOpacity(0.4),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 1),
               Text(
                "Ali Akbar",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.scrim,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
