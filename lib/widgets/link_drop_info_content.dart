import 'package:flutter/material.dart';

class LinkDropInfoContent extends StatelessWidget {
  const LinkDropInfoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About LinkDrop",
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "LinkDrop is a minimalist local media helper designed to organize and stream your public web URLs. "
            "Experience an uncluttered interface focused strictly on content playback and link management.",
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

          Text("• Smooth and minimal interface"),
          Text("• Instant clipboard link processing"),
          Text("• Full Light & Dark theme support"),
          Text("• Secure local stream playback"),

          const SizedBox(height: 24),

          Text(
            "Privacy & Terms",
            style: theme.textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "LinkDrop is a local productivity utility. It does not host, store, or re-share any external files. "
            "All processes run locally on your device to ensure maximum privacy and data security.",
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}