import 'package:flutter/material.dart';
import 'package:video_downloder/widgets/no_ads_content.dart';

class NoAdsView extends StatelessWidget {
  const NoAdsView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text("Go Ad-Free",style: theme.textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.primary,
              ),
            ),
        centerTitle: true,
      ),
      body: const NoAdsContent(),
    );
  }
}