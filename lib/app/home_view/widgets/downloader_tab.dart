import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloder/bloc/library_bloc/library_bloc.dart';
import 'package:video_downloder/bloc/library_bloc/library_event.dart';
import 'package:video_downloder/bloc/library_bloc/library_state.dart';
import 'package:video_downloder/core/componenet/app_text_field.dart';
import 'package:video_downloder/core/componenet/text_action.dart';
import 'package:video_downloder/core/utils/responsive_extensions.dart';
import 'package:video_downloder/core/utils/validation_extensions.dart';

class DownloaderTab extends StatefulWidget {
  const DownloaderTab({super.key});

  @override
  State<DownloaderTab> createState() => _DownloaderTabState();
}

class _DownloaderTabState extends State<DownloaderTab> {
  final TextEditingController urlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedPlatform = "Instagram";

  final List<Map<String, dynamic>> platforms = [
    {
      "name": "Instagram",
      "icon": Icons.camera_alt_outlined,
      "color": Colors.pinkAccent,
    },
    {"name": "Facebook", "icon": Icons.facebook, "color": Colors.blueAccent},
    {"name": "TikTok", "icon": Icons.music_note, "color": Colors.black},
    {"name": "Pinterest", "icon": Icons.pin_drop, "color": Colors.redAccent},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<LibraryBloc, LibraryState>(
      listener: (context, state) {
        if (state is LibrarySuccess) {
          _showSnackBar(context, state.message, Colors.green);
          urlController.clear();
        } else if (state is LibraryError) {
          _showSnackBar(context, state.error, Colors.redAccent);
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              4.heightBox,
              _buildSearchBox(theme, isDark),
              32.heightBox,
              _buildPlatformTitle(theme, isDark),
              16.heightBox,
              _buildPlatformList(isDark),
              48.heightBox,
              _buildDownloadButton(theme),
              40.heightBox,
              _buildGuideCard(theme, isDark),
              4.heightBox,
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      ),
    );
  }

  Widget _buildSearchBox(ThemeData theme, bool isDark) {
    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.white.withOpacity(0.8),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
              ),
            ),
            child: AppTextField(
              controller: urlController,
              hintText: "Paste link here...",
              isBorderless: true,
              validator: (val) => val.validateSocialUrl(selectedPlatform),
              prefixIcon: Icon(
                Icons.link_rounded,
                color: theme.colorScheme.primary,
              ),
              suffixIcon: Container(
                margin: const EdgeInsets.all(8),
                child: TextButton(
                  onPressed: () {

                    
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Paste",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlatformTitle(ThemeData theme, bool isDark) {
    return Text(
      "POPULAR PLATFORMS",
      style: theme.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w800,
        letterSpacing: 2,
        color: isDark ? Colors.white24 : Colors.black26,
      ),
    );
  }

  Widget _buildPlatformList(bool isDark) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: platforms.length,
        itemBuilder: (context, index) {
          final platform = platforms[index];
          final isSelected = selectedPlatform == platform["name"];

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedPlatform = platform["name"];
              });
            },
            child: FadeInRight(
              delay: Duration(milliseconds: index * 100),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 75,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? platform["color"]
                      : (isDark
                            ? Colors.white.withOpacity(0.03)
                            : Colors.white),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: platform["color"].withOpacity(0.3),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ]
                      : [],
                  border: Border.all(
                    color: isSelected
                        ? Colors.transparent
                        : (isDark
                              ? Colors.white10
                              : Colors.black.withOpacity(0.05)),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      platform["icon"],
                      color: isSelected ? Colors.white : platform["color"],
                      size: 28,
                    ),
                    4.heightBox,
                    Text(
                      platform["name"],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? Colors.white
                            : (isDark ? Colors.white54 : Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDownloadButton(ThemeData theme) {
    return FadeInUp(
      delay: const Duration(milliseconds: 300),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.4),
              blurRadius: 25,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextAction(
          text: "DOWNLOAD NOW",
          backGrounColor: theme.colorScheme.primary,
          height: 68,
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              context.read<LibraryBloc>().add(
                StartDownload(
                  url: urlController.text,
                  platform: selectedPlatform,
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildGuideCard(ThemeData theme, bool isDark) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.03) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? Colors.white10 : Colors.black.withOpacity(0.05),
          ),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.help_outline_rounded, color: Colors.amber),
                12.widthBox,
                Text(
                  "How to use?",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            16.heightBox,
            _buildStep("1", "Copy any social media video link"),
            12.heightBox,
            _buildStep("2", "Paste it above and tap Download"),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String num, String text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.amber.withOpacity(0.15),
          child: Text(
            num,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        12.widthBox,
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
