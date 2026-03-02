# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Firebase (if using)
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Your app
-keep class com.yourcompany.yourapp.** { *; }

# Prevent obfuscation
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception