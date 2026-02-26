import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:video_downloder/core/componenet/text_action.dart';
import 'package:video_downloder/core/utils/responsive_extensions.dart';

class ProView extends StatefulWidget {
  const ProView({super.key});

  @override
  State<ProView> createState() => _ProViewState();
}

class _ProViewState extends State<ProView> {
  final List<Map<String, dynamic>> features = [
    {
      "icon": Icons.speed,
      "title": "Unlimited Downloads",
      "desc": "Download content without any limits",
    },
    {
      "icon": Icons.ads_click,
      "title": "Ad-Free Experience",
      "desc": "No interruptions while using the app",
    },
    {
      "icon": Icons.hd,
      "title": "Highest Quality",
      "desc": "Always get the best available resolution",
    },
    {
      "icon": Icons.support_agent,
      "title": "Priority Support",
      "desc": "Get help from our team within hours",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final isTablet = context.mqWidth(1.0) > 600;
    final contentWidth = isTablet ? 600.0 : double.infinity;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Background Gradient at the top - responsive height
          Container(
            height: context.mqHeight(isTablet ? 0.3 : 0.35),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.withOpacity(0.8),
                  Colors.deepOrangeAccent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(
                  context.mqWidth(isTablet ? 0.05 : 0.12),
                ),
                bottomRight: Radius.circular(
                  context.mqWidth(isTablet ? 0.05 : 0.12),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: contentWidth),
                child: Column(
                  children: [
                    // Custom AppBar - responsive padding
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.mqWidth(0.04),
                        vertical: context.mqHeight(0.01),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Reel Drop Pro",
                            style: theme.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: isTablet ? 24 : context.mqWidth(0.05),
                            ),
                          ),
                          SizedBox(width: context.mqWidth(0.1)), // Spacer
                        ],
                      ),
                    ),

                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.mqWidth(isTablet ? 0.02 : 0.05),
                          vertical: context.mqHeight(0.02),
                        ),
                        child: Column(
                          children: [
                            FadeInDown(
                              child: Icon(
                                Icons.auto_awesome,
                                size: isTablet ? 60 : context.mqHeight(0.08),
                                color: Colors.white,
                              ),
                            ),
                            (context.screenHeight * 0.01).heightBox,
                            FadeInDown(
                              delay: const Duration(milliseconds: 200),
                              child: Text(
                                "Upgrade to Premium",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: isTablet
                                      ? 32
                                      : context.mqWidth(0.07),
                                ),
                              ),
                            ),
                            (context.screenHeight * (isTablet ? 0.02 : 0.04))
                                .heightBox,

                            // Feature List
                            Container(
                              padding: EdgeInsets.all(
                                isTablet ? 30 : context.mqWidth(0.06),
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(
                                  isTablet ? 20 : context.mqWidth(0.08),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: features.asMap().entries.map((entry) {
                                  final index = entry.key;
                                  final item = entry.value;
                                  return FadeInUp(
                                    delay: Duration(
                                      milliseconds: 300 + (index * 100),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        bottom: context.mqHeight(0.025),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(
                                              isTablet
                                                  ? 12
                                                  : context.mqWidth(0.025),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.orange.withOpacity(
                                                0.1,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                    isTablet
                                                        ? 10
                                                        : context.mqWidth(0.03),
                                                  ),
                                            ),
                                            child: Icon(
                                              item["icon"],
                                              color: Colors.orange,
                                              size: isTablet
                                                  ? 24
                                                  : context.mqWidth(0.06),
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.mqWidth(0.04),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item["title"],
                                                  style: theme
                                                      .textTheme
                                                      .titleMedium
                                                      ?.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: isTablet
                                                            ? 18
                                                            : context.mqWidth(
                                                                0.04,
                                                              ),
                                                      ),
                                                ),
                                                Text(
                                                  item["desc"],
                                                  style: theme
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color: Colors.grey[600],
                                                        fontSize: isTablet
                                                            ? 14
                                                            : context.mqWidth(
                                                                0.032,
                                                              ),
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            (context.screenHeight * 0.02).heightBox,

                            // Price Card
                            FadeInUp(
                              delay: const Duration(milliseconds: 800),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(
                                  isTablet ? 30 : context.mqWidth(0.06),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.blueGrey.shade800,
                                      Colors.black87,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    isTablet ? 20 : context.mqWidth(0.08),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      "Lifetime Access",
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color: Colors.white70,
                                            fontSize: isTablet
                                                ? 16
                                                : context.mqWidth(0.035),
                                          ),
                                    ),
                                    (context.screenHeight * 0.01).heightBox,
                                    Text(
                                      "\$9.99",
                                      style: theme.textTheme.headlineLarge
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: isTablet
                                                ? 40
                                                : context.mqWidth(0.1),
                                          ),
                                    ),
                                    (context.screenHeight * 0.02).heightBox,
                                    TextAction(
                                      text: "Upgrade Now",
                                      backGrounColor: Colors.deepOrangeAccent,
                                      textColor: Colors.white,
                                      height: isTablet
                                          ? 60
                                          : context.mqHeight(0.07),
                                      onPressed: () {
                                        // Subscription logic
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            (context.screenHeight * 0.03).heightBox,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
