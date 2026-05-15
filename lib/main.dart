import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:video_downloder/reel_drop.dart';

void main() {
  // runApp(
  //   const ReelDrop(),
  // );
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder:(context)=>ReelDrop()
    )
  );
}
