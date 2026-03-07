import 'package:flutter/material.dart';

class ReelDropInfoContent extends StatelessWidget {
  const ReelDropInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About ReelDrop",
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "ReelDrop is your all-in-one video hub. "
            "Access and enjoy content from multiple platforms in one simple and clean interface.",
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),

          Text(
            "Features",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),

          Text("• Smooth and minimal design"),
          Text("• Fast video access"),
          Text("• Light & Dark theme support"),
          Text("• Easy and user-friendly interface"),

          const SizedBox(height: 24),

          Text(
            "Important Note",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "ReelDrop is intended for personal use only. "
            "Users are responsible for respecting platform policies "
            "and content ownership rights.",
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}