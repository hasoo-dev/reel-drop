import 'package:flutter/material.dart';

class AppColors {
  // Core brand / primary colors (premium dark feel)
  static const Color primary = Color(0xFF2563EB); // rich royal blue
  static const Color primarySoft = Color(0xFF1D4ED8); // softer primary for backgrounds
  static const Color accent = Color(0xFF38BDF8); // cyan accent for highlights
  static const Color accentSoft = Color(0xFF0EA5E9);

  // Supporting brand colors
  static const Color purpleGlow = Color(0xFF6366F1);
  static const Color pinkGlow = Color(0xFFEC4899);
  static const Color teal = Color(0xFF14B8A6);
  static const Color orange = Color.fromARGB(255, 252, 119, 2);
  static const Color yellow = Color(0xFFF59E0B);
  static const Color green = Color(0xFF14B8A6);
  static const Color red = Color(0xFFF59E0B);
  static const Color blue = Color(0xFF14B8A6);
  static const Color purple = Color(0xFF14B8A6);
  static const Color pink = Color.fromARGB(255, 94, 20, 184);
  
  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Colors.black;
  static const Color lightSecondaryText = Colors.black54;

  // Dark Theme Colors (premium dark surfaces)
  static const Color darkBackground = Color(0xFF020617); // near-black navy
  static const Color darkSurface = Color(0xFF0B1120); // deep card surface
  static const Color darkSurfaceElevated = Color(0xFF111827); // elevated cards / sheets
  static const Color darkText = Colors.white;
  static const Color darkSecondaryText = Colors.white70;

  // Neutrals / strokes / overlays
  static const Color borderSubtle = Color(0xFF1F2933);
  static const Color borderStrong = Color(0xFF4B5563);
  static const Color overlaySoft = Color(0x66000000); // 40% black
  static const Color overlayStrong = Color(0x99000000); // 60% black

  // Status colors
  static const Color error = Colors.redAccent;
  static const Color success = Colors.greenAccent;
  static const Color warning = Color(0xFFF59E0B);
}