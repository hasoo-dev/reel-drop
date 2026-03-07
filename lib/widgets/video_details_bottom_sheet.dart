import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_downloder/bloc/reel_bloc/reel_drop_bloc.dart';
import 'package:video_downloder/bloc/reel_bloc/reel_drop_event.dart';
import 'package:video_downloder/models/download_model/download_response.dart';

class VideoDetailsBottomSheet extends StatelessWidget {
  final DownloadResponse response;
  final String platform;
  final String originalUrl;

  const VideoDetailsBottomSheet({
    super.key,
    required this.response,
    required this.platform,
    required this.originalUrl,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final data = response.data;
    if (data == null) return const SizedBox.shrink();

    // 1. Get and process formats
    final List<Formats> formats = [];
    if (data.formats != null && data.formats!.isNotEmpty) {
      formats.addAll(data.formats!);
    }
    
    // Fallback: If data.url is provided and not already in formats, add it as "Best Quality"
    if (data.url != null && data.url!.isNotEmpty && !formats.any((f) => f.url == data.url)) {
      formats.add(Formats(url: data.url, quality: "Best Quality", ext: "mp4", hasAudio: true));
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withOpacity(0.1),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          
          // Header with Platform & Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  platform,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                "Video Details",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Thumbnail & Title Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  data.thumbnail ?? "",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 90,
                    height: 90,
                    color: theme.colorScheme.primary.withOpacity(0.05),
                    child: Icon(Icons.video_library, color: theme.colorScheme.primary),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.title ?? "Unknown Video",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "By ${data.uploader ?? 'Unknown'}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Formats List
          if (formats.isNotEmpty) ...[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Select Resolution",
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: formats.length,
                separatorBuilder: (context, index) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final f = formats[index];
                  final quality = f.quality ?? "Standard Quality";
                  final ext = (f.ext ?? "mp4").toUpperCase();
                  final size = f.filesize != null 
                    ? " • ${(f.filesize! / (1024 * 1024)).toStringAsFixed(1)} MB" 
                    : "";
                  
                  final hasAudio = f.hasAudio ?? true;
                  
                  return InkWell(
                    onTap: () {
                      if (f.url != null) {
                        context.read<ReelDropBloc>().add(
                          DownloadVideo(
                            url: originalUrl,
                            videoUrl: f.url!,
                            title: data.title ?? "video",
                            ext: f.ext ?? "mp4",
                          ),
                        );
                        Navigator.pop(context);
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.1),
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            hasAudio ? Icons.video_collection_outlined : Icons.volume_off_outlined, 
                            color: hasAudio ? theme.colorScheme.primary : theme.colorScheme.error, 
                            size: 20
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "$quality ($ext)$size",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: hasAudio ? null : theme.colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                          ),
                          if (!hasAudio)
                             Padding(
                               padding: const EdgeInsets.only(right: 8.0),
                               child: Text("Muted", style: TextStyle(color: theme.colorScheme.error, fontSize: 10, fontWeight: FontWeight.bold)),
                             ),
                          Icon(Icons.download_for_offline, 
                            color: theme.colorScheme.primary, size: 24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ] else
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: theme.colorScheme.error),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      "No downloadable formats found for this video.",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
