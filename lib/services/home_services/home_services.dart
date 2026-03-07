import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// Encapsulates non-UI logic for the Home screen.
class HomeServices {
  /// Reads a plain-text URL from the clipboard.
  /// Returns `null` if the clipboard is empty or not text.
  Future<String?> getClipboardUrl() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    var url = data?.text?.trim();
    if (url == null || url.isEmpty) return null;
    
    // Clean tracking parameters for better scraping
    if (url.contains('instagram.com') || url.contains('instagr.am')) {
      final uri = Uri.parse(url);
      if (uri.queryParameters.containsKey('igsh') || uri.queryParameters.containsKey('utm_source')) {
        final newParams = Map<String, String>.from(uri.queryParameters);
        newParams.remove('igsh');
        newParams.remove('utm_source');
        url = uri.replace(queryParameters: newParams).toString();
        // Remove trailing '?' if replace left it
        if (url.endsWith('?')) url = url.substring(0, url.length - 1);
        print("HomeServices: Cleaned Instagram URL -> $url");
      }
    } else if (url.contains('tiktok.com')) {
      final uri = Uri.parse(url);
      if (uri.queryParameters.isNotEmpty) {
        url = uri.replace(queryParameters: {}).toString();
        if (url.endsWith('?')) url = url.substring(0, url.length - 1);
        print("HomeServices: Cleaned TikTok URL -> $url");
      }
    }
    return url;
  }

  /// Tries to detect the platform name from a URL.
  String? detectPlatformFromUrl(String url) {
    final lower = url.toLowerCase();
    if (lower.contains('instagram.com') || lower.contains('instagr.am')) return 'Instagram';
    if (lower.contains('tiktok.com')) return 'TikTok';
    if (lower.contains('facebook.com') || lower.contains('fb.watch') || lower.contains('fb.com')) return 'Facebook';
    if (lower.contains('snapchat.com')) return 'Snapchat';
    if (lower.contains('pin.it') || lower.contains('pinterest.com')) return 'Pinterest';
    if (lower.contains('whatsapp.com')) return 'WhatsApp';
    if (lower.contains('x.com') || lower.contains('twitter.com')) return 'X';
    if (lower.contains('youtube.com') || lower.contains('youtu.be')) return 'YouTube';
    return null;
  }

  /// Opens the WhatsApp Community link using url_launcher.
  Future<void> openWhatsAppCommunity() async {
    const url = "https://whatsapp.com/channel/0029VbCOdEF002T5mv4lsj1y"; // Updated to a chat link
    final uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        // Try to force external app (WhatsApp) for a more "premium" feel
        await launchUrl(
          uri, 
          mode: LaunchMode.externalNonBrowserApplication,
        ).catchError((_) async {
          // If app-only fails, fallback to normal external application (browser/app chooser)
          return await launchUrl(uri, mode: LaunchMode.externalApplication);
        });
      } else {
        print("HomeServices: Could not launch $url");
      }
    } catch (e) {
      print("HomeServices: Error launching WhatsApp: $e");
    }
  }
}
