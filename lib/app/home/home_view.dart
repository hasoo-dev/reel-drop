// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/link_bloc/link_drop_bloc.dart';
import '../../bloc/link_bloc/link_drop_event.dart';
import '../../bloc/link_bloc/link_drop_state.dart';
import '../../core/routes/routes_name.dart';
import '../../core/theme/theme_controller.dart';
import '../../core/utils/extensions/flush_bar_extension.dart';
import '../../models/extract_model/extract_response.dart';
import '../../services/home_services/home_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final homeServices = HomeServices();
  String? currentPlatform;
  String? _lastUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<LinkDropBloc, LinkDropState>(
      listener: (context, state) {
        if (state is LinkDropError) {
          // if (state.error == "YOUTUBE_BOT_DETECTION") {
          //   _showBotDetectionDialog(context);
          // } else {   
          //   context.flushBarErrorMessage(
          //     message: state.error ?? "An error occurred",
          //   );
          // }
        } else if (state is LinkDropExtract) {
          context.flushBarSuccessMessage(message: " Fetching Successfully 🌱");
        } else if (state is LinkDropLoaded) {
          final data = state.extractResponse?.data;
          if (data != null) {
            final List<Formats> formats = [];
            if (data.formats != null && data.formats!.isNotEmpty) {
              formats.addAll(data.formats!);
            }
            if (data.url != null &&
                data.url!.isNotEmpty &&
                !formats.any((f) => f.url == data.url)) {
              formats.add(
                Formats(
                  url: data.url,
                  quality: "Best Quality",
                  ext: "mp4",
                  hasAudio: true,
                ),
              );
            }

            if (formats.isNotEmpty) {
              Formats? bestFormat;
              final audioFormats = formats
                  .where((f) => f.hasAudio != false)
                  .toList();

              int getQualityValue(Formats f) {
                if (f.height != null && f.height! > 0) return f.height!;
                if (f.quality != null) {
                  final match = RegExp(r'(\d+)p').firstMatch(f.quality!);
                  if (match != null) {
                    return int.tryParse(match.group(1)!) ?? 0;
                  }
                }
                return 0;
              }

              if (audioFormats.isNotEmpty) {
                audioFormats.sort(
                  (a, b) => getQualityValue(b).compareTo(getQualityValue(a)),
                );
                bestFormat = audioFormats.first;
              } else {
                formats.sort(
                  (a, b) => getQualityValue(b).compareTo(getQualityValue(a)),
                );
                bestFormat = formats.first;
              }

              if (bestFormat.url != null) {
                context.read<LinkDropBloc>().add(
                  ExtrackingVideo(
                    url: _lastUrl ?? "",
                    videoUrl: bestFormat.url!,
                    title: data.title ?? "video",
                    ext: bestFormat.ext ?? "mp4",
                    uploader: data.uploader,
                  ),
                );
              }
            } else {
              context.flushBarErrorMessage(
                message: "No Fetching  formats found ",
              );
            }
          }
        }
      },
      builder: (context, state) {
        bool isExtracting = false;
        bool isFetching = false;

        if (state is LinkDropExtracting) {
          isExtracting = true;
        } else if (state is LinkDropLoading) {
          isFetching = true;
        }

        return Scaffold(
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pushNamed(context, RoutesName.info),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: EdgeInsets.only(left: 12),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 6,
                ),
                child: Image.asset(
                  "assets/icons/ic_info.png",
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            backgroundColor: theme.scaffoldBackgroundColor,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 43,

            actions: [
              ValueListenableBuilder<ThemeMode>(
                valueListenable: ThemeController.themeMode,
                builder: (context, themeMode, _) {
                  final isDarkMode =
                      themeMode == ThemeMode.dark ||
                      (themeMode == ThemeMode.system &&
                          MediaQuery.platformBrightnessOf(context) ==
                              Brightness.dark);

                  return GestureDetector(
                    onTap: () => ThemeController.toggle(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 6,
                      ),
                      child: Icon(
                        isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: theme.colorScheme.onSurface,
                        size: 30,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          backgroundColor: theme.scaffoldBackgroundColor,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndDocked,
          floatingActionButton: FloatingActionButton.large(
            backgroundColor: Colors.transparent,

            autofocus: false,
            elevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
            focusElevation: 0,
            onPressed: () => homeServices.openWhatsAppCommunity(),

            heroTag: "whatsapp",
            child: Image.asset("assets/icons/ic_whats.png", height: 85),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 49,
                            width: 49,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Image.asset(
                              "assets/icons/ic_link_drop.png",
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),

                          const SizedBox(height: 16),
                          Text(
                            "Welcome to",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontFamily: "beba",
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                          Text(
                            "LinkDrop",
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            "Your video hub in one tap",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontFamily: "beba",
                              color: theme.colorScheme.onSurface,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        final size = constraints.maxWidth * 0.85;
                        return Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: (isExtracting || isFetching)
                                  ? null
                                  : () async {
                                      final url = await homeServices
                                          .getClipboardUrl();
                                      if (url != null) {
                                        setState(() {
                                          _lastUrl = url;
                                          currentPlatform = homeServices
                                              .detectPlatformFromUrl(url);
                                        });
                                        context.read<LinkDropBloc>().add(
                                          FetchVideoData(url: url),
                                        );
                                      } else {
                                        context.flushBarErrorMessage(
                                          message: "No URL found in clipboard",
                                        );
                                      }
                                    },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer Progress Ring
                                  if (isExtracting || isFetching)
                                    SizedBox(
                                      width: size + 20,
                                      height: size + 20,
                                      child: CircularProgressIndicator(
                                        value: isExtracting
                                            ? state.progress
                                            : null,
                                        strokeWidth: 4,
                                        strokeCap: StrokeCap.round,
                                        color: theme.colorScheme.primary,
                                        backgroundColor: theme
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.1),
                                      ),
                                    ),

                                  Container(
                                    width: size,
                                    height: size,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: theme.colorScheme.primary
                                            .withOpacity(0.1),
                                        width: 8,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: theme.colorScheme.onSurface
                                              .withOpacity(0.2),
                                          blurRadius: 10,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                      gradient: RadialGradient(
                                        center: Alignment.center,
                                        radius: 0.5,
                                        colors: <Color>[
                                          theme.colorScheme.primary,
                                          theme.colorScheme.primary.withOpacity(
                                            0.8,
                                          ),
                                          theme.colorScheme.primary.withOpacity(
                                            0.3,
                                          ),
                                        ],
                                        stops: const [0.2, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (isFetching || isExtracting)
                                        Text(
                                          isFetching
                                              ? "..."
                                              : "${(state.progress * 100).toStringAsFixed(0)}%",
                                          style: theme.textTheme.headlineLarge
                                              ?.copyWith(
                                                color: theme.colorScheme.shadow,
                                                fontWeight: FontWeight.w900,
                                              ),
                                        )
                                      else
                                        Image.asset(
                                          "assets/icons/ic_tap.png",
                                          height: 63,
                                        ),
                                      // Icon(
                                      //   Icons.touch_app_rounded,
                                      //   size: 48,
                                      //   color: Colors.white.withOpacity(0.8),
                                      // ),
                                      const SizedBox(height: 32),

                                      Text(
                                        isFetching
                                            ? "Fetching..."
                                            : isExtracting
                                            ? "Dripping..."
                                            : "Push It..",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                              color: theme.colorScheme.shadow,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}


//   void _showBotDetectionDialog(BuildContext context) {
//     final theme = Theme.of(context);
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: theme.scaffoldBackgroundColor,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Row(
//             children: [
//               const Icon(Icons.security, color: Colors.redAccent, size: 28),
//               const SizedBox(width: 8),
//               Expanded(
//                 child: Text(
//                   "I'm not a robot",
//                   style: theme.textTheme.titleMedium?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               const SizedBox(height: 8),
//               Text(
//                 "YouTube requires a bot verification to download this video. This happens when there are too many download requests from our servers.",
//                 style: theme.textTheme.bodyMedium,
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 "Try again later or use an alternate video link.",
//                 style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w600,
//                   color: theme.colorScheme.primary,
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(
//                 "Understood",
//                 style: TextStyle(color: theme.colorScheme.primary),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
