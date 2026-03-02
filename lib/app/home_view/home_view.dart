import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:video_downloder/app/home_view/widgets/downloader_tab.dart';
import 'package:video_downloder/app/home_view/widgets/library_tab.dart';
import 'package:video_downloder/core/utils/responsive_extensions.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            // Immersive Global Background
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [
                            const Color.fromARGB(255, 0, 0, 0),
                            const Color.fromARGB(255, 96, 102, 109),
                          ]
                        : [
                            const Color.fromARGB(255, 255, 255, 255),
                            const Color.fromARGB(255, 150, 168, 195),
                          ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),

            // Abstract Background Glows
            Positioned(
              top: -150,
              right: -100,
              child: _buildGlow(const Color.fromARGB(255, 218, 226, 239), 400),
            ),
            Positioned(
              bottom: -100,
              left: -150,
              child: _buildGlow(const Color.fromARGB(255, 229, 225, 230), 500),
            ),

            SafeArea(
              child: Column(
                children: [
                  // Premium Top Header & TabBar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 20, 24, 10),
                    child: FadeInDown(
                      duration: const Duration(milliseconds: 600),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Premium Downloader",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: isDark
                                      ? Colors.white54
                                      : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                "REELDROP",
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -1.0,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? const Color.fromARGB(
                                      255,
                                      188,
                                      180,
                                      180,
                                    ).withOpacity(0.05)
                                  : const Color.fromARGB(255, 13, 12, 12).withOpacity(0.07),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                              "assets/icons/ic_library.png",
                              width: 24,
                              height: 24,

                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(
                                    Icons.bolt_rounded,
                                    color: Colors.amber,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Custom Premium TabBar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 10,
                    ),
                    child: FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      child: Container(
                        height: 55,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withOpacity(0.05)
                              : Colors.black.withOpacity(0.03),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: TabBar(
                          dividerColor: Colors.transparent,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: theme.colorScheme.primary.withOpacity(
                                  0.3,
                                ),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: isDark
                              ? Colors.white38
                              : Colors.black38,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          tabs: const [
                            Tab(text: "Download"),
                            Tab(text: "Library"),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // TabBarView Content
                  const Expanded(
                    child: TabBarView(
                      children: [DownloaderTab(), LibraryTab()],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlow(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color.withOpacity(0.12), color.withOpacity(0)],
        ),
      ),
    );
  }
}
