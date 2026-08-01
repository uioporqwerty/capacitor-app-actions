# Consumer ProGuard/R8 rules — applied to apps that depend on this plugin.
#
# Capacitor discovers and instantiates plugins by class via the @CapacitorPlugin
# annotation, so the plugin class (and its @PluginMethod methods) must survive
# R8 shrinking/obfuscation in release builds. Without this, app actions can
# silently stop working in production/minified builds.
-keep class com.getcapacitor.community.appactions.** { *; }
