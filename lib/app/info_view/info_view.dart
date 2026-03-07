import 'package:flutter/material.dart';
import 'package:video_downloder/widgets/reel_drop_info_content.dart';
 

class InfoView extends StatelessWidget {
  const InfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 90,
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              "Skip",
              style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Info",
          style: theme.textTheme.bodyLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.primary,
          ),
        ),
      ),
      body: const ReelDropInfoContent(), // 🔥 Separate widget
    );
  }
}