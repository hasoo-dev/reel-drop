import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:video_downloder/core/utils/responsive_extensions.dart';

class LibraryTab extends StatelessWidget {
  const LibraryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          4.heightBox,
          FadeInDown(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recently Saved",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "Manage and watch your saved clips",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.white38 : Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          24.heightBox,

          // Mock Downloaded Items
          _buildLibraryItem(
            context,
            "Instagram Reel",
            "24 MB",
            Colors.pinkAccent,
          ),
          16.heightBox,
          _buildLibraryItem(
            context,
            "TikTok Viral Video",
            "12 MB",
            Colors.black,
          ),
          16.heightBox,
          _buildLibraryItem(
            context,
            "Facebook Post Clip",
            "8.5 MB",
            Colors.blueAccent,
          ),
          16.heightBox,
        ],
      ),
    );
  }

  Widget _buildLibraryItem(
    BuildContext context,
    String title,
    String size,
    Color accent,
  ) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FadeInUp(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    Icons.play_circle_fill_rounded,
                    color: accent,
                    size: 32,
                  ),
                ),
                16.widthBox,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      4.heightBox,
                      Text(
                        "Downloaded • $size",
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? Colors.white38 : Colors.black38,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_rounded, color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
