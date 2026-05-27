# Keep stacktrace line info useful for Crashlytics deobfuscation.
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

# Flutter plugin registrant and engine-side channel classes.
-keep class io.flutter.plugins.GeneratedPluginRegistrant { *; }
-keep class io.flutter.plugin.** { *; }

# Keep common annotation metadata.
-keepattributes *Annotation*
