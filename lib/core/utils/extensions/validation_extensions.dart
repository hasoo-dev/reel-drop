extension SocialUrlValidation on String? {
  String? validateSocialUrl(String selectedPlatform) {
    if (this == null || this!.isEmpty) {
      return "Please paste a link first";
    }

    final lowerValue = this!.toLowerCase();
    switch (selectedPlatform) {
      case "Instagram":
        if (!lowerValue.contains("instagram.com")) {
          return "Invalid Instagram link";
        }
        break;
      case "Facebook":
        if (!lowerValue.contains("facebook.com") &&
            !lowerValue.contains("fb.watch")) {
          return "Invalid Facebook link";
        }
        break;
      case "TikTok":
        if (!lowerValue.contains("tiktok.com")) {
          return "Invalid TikTok link";
        }
        break;
      case "Pinterest":
        if (!lowerValue.contains("pinterest.com") &&
            !lowerValue.contains("pin.it")) {
          return "Invalid Pinterest link";
        }
        break;
    }
    return null;
  }
}
