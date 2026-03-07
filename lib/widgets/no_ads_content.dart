import 'package:flutter/material.dart';

class NoAdsContent extends StatelessWidget {
  const NoAdsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 30),

          Icon(
            Icons.block,
            size: 70,
            color: theme.colorScheme.primary,
          ),

          const SizedBox(height: 24),

          Text(
            "Enjoy ReelDrop Without Ads",
            textAlign: TextAlign.center,
            style: theme.textTheme.titleLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            "Upgrade to remove ads and enjoy a smoother, distraction-free experience across the app.",
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),

          const SizedBox(height: 32),

          ElevatedButton(
            onPressed: () {
              // TODO: Add purchase logic
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 14,
              ),
            ),
            child: const Text("Upgrade Now"),
          ),

          const SizedBox(height: 16),

          Text(
            "One-time upgrade. No hidden charges.",
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}