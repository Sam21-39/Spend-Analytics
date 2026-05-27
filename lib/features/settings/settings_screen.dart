import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/toggle_widget.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark  = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title:         'Settings',
      showBottomNav: false,
      onBack:        () => Get.back<void>(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          // ── Profile card ─────────────────────────────────────
          LiquidGlassSurface(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: <Widget>[
                // Avatar
                Container(
                  width:  56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: <Color>[scheme.primary, scheme.secondary],
                      begin: Alignment.topLeft,
                      end:   Alignment.bottomRight,
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'S',
                      style: TextStyle(
                        fontSize:   22,
                        fontWeight: FontWeight.w800,
                        color:      Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Guest User',
                        style: TextStyle(
                          fontSize:   16,
                          fontWeight: FontWeight.w800,
                          color:      scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        'Free plan · Offline mode',
                        style: TextStyle(
                          fontSize: 13,
                          color:    scheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.subscription),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          const Color(0xFFFFB860),
                          const Color(0xFFFF9F40),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.workspace_premium_rounded, size: 13, color: Colors.white),
                        SizedBox(width: 4),
                        Text(
                          'Go Pro',
                          style: TextStyle(
                            fontSize:   12,
                            fontWeight: FontWeight.w800,
                            color:      Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ── Preferences ──────────────────────────────────────
          _SectionLabel(label: 'PREFERENCES'),
          const SizedBox(height: 10),

          LiquidGlassSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                _SettingRow(
                  icon:     Icons.currency_rupee_rounded,
                  color:    const Color(0xFF3FDDA0),
                  label:    'Currency',
                  trailing: Obx(() => Text(
                    controller.selectedCurrency.value,
                    style: TextStyle(
                      fontSize:   14,
                      fontWeight: FontWeight.w600,
                      color:      scheme.onSurfaceVariant,
                    ),
                  )),
                  isDivider: true,
                  isDark: isDark,
                ),
                _ToggleRow(
                  icon:      Icons.notifications_rounded,
                  color:     const Color(0xFFFF9F40),
                  label:     'Notifications',
                  subtitle:  'Budget alerts & reminders',
                  isDivider: true,
                  isDark:    isDark,
                ),
                _ToggleRow(
                  icon:      Icons.fingerprint_rounded,
                  color:     const Color(0xFF5B9FFF),
                  label:     'Biometric Lock',
                  subtitle:  'Require Face ID / fingerprint',
                  isDivider: false,
                  isDark:    isDark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── Data & Privacy ───────────────────────────────────
          _SectionLabel(label: 'DATA & PRIVACY'),
          const SizedBox(height: 10),

          LiquidGlassSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                _SettingRow(
                  icon:      Icons.cloud_sync_rounded,
                  color:     const Color(0xFFB0A0FF),
                  label:     'Sync & Backup',
                  subtitle:  'Supabase cloud sync',
                  chevron:   true,
                  isDivider: true,
                  isDark:    isDark,
                ),
                _SettingRow(
                  icon:      Icons.download_rounded,
                  color:     const Color(0xFF3FDDA0),
                  label:     'Export Data',
                  subtitle:  'Download as CSV',
                  chevron:   true,
                  isDivider: true,
                  isDark:    isDark,
                ),
                _SettingRow(
                  icon:      Icons.delete_sweep_rounded,
                  color:     const Color(0xFFFF6B6B),
                  label:     'Clear Local Data',
                  subtitle:  'Remove all offline data',
                  chevron:   true,
                  isDivider: false,
                  isDark:    isDark,
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // ── About ────────────────────────────────────────────
          _SectionLabel(label: 'ABOUT'),
          const SizedBox(height: 10),

          LiquidGlassSurface(
            padding: EdgeInsets.zero,
            child: Column(
              children: <Widget>[
                _SettingRow(
                  icon:      Icons.workspace_premium_rounded,
                  color:     const Color(0xFFFFB860),
                  label:     'Subscription',
                  subtitle:  'Free, Pro, Family plans',
                  chevron:   true,
                  isDivider: true,
                  isDark:    isDark,
                  onTap:     () => Get.toNamed(AppRoutes.subscription),
                ),
                _SettingRow(
                  icon:      Icons.privacy_tip_outlined,
                  color:     const Color(0xFF5B9FFF),
                  label:     'Privacy Policy',
                  subtitle:  'Last updated May 2026',
                  chevron:   true,
                  isDivider: true,
                  isDark:    isDark,
                  onTap:     () => Get.toNamed(AppRoutes.privacyPolicy),
                ),
                _SettingRow(
                  icon:      Icons.description_outlined,
                  color:     const Color(0xFFB0A0FF),
                  label:     'Terms of Service',
                  subtitle:  'Subscription & usage terms',
                  chevron:   true,
                  isDivider: false,
                  isDark:    isDark,
                  onTap:     () => Get.toNamed(AppRoutes.terms),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ── Sign out ─────────────────────────────────────────
          GestureDetector(
            onTap: () => Get.toNamed(AppRoutes.logout),
            child: LiquidGlassSurface(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.logout_rounded, size: 18, color: scheme.error),
                  const SizedBox(width: 8),
                  Text(
                    'Sign Out',
                    style: TextStyle(
                      fontSize:   15,
                      fontWeight: FontWeight.w700,
                      color:      scheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),

          Center(
            child: Text(
              'Spend Analytics v1.0.0',
              style: TextStyle(
                fontSize: 11,
                color:    scheme.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize:      11,
        fontWeight:    FontWeight.w700,
        letterSpacing: 0.8,
        color:         Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}

class _SettingRow extends StatelessWidget {
  const _SettingRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.isDivider,
    required this.isDark,
    this.subtitle,
    this.trailing,
    this.chevron = false,
    this.onTap,
  });

  final IconData icon;
  final Color    color;
  final String   label;
  final String?  subtitle;
  final Widget?  trailing;
  final bool     chevron;
  final bool     isDivider;
  final bool     isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: isDivider
            ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06),
                    width: 0.5,
                  ),
                ),
              )
            : null,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: <Widget>[
            IconBox(icon: icon, color: color, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    label,
                    style: TextStyle(
                      fontSize:   14,
                      fontWeight: FontWeight.w600,
                      color:      scheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color:    scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) trailing!,
            if (chevron)
              Icon(
                Icons.chevron_right_rounded,
                size:  16,
                color: scheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatefulWidget {
  const _ToggleRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.isDivider,
    required this.isDark,
    this.subtitle,
  });

  final IconData icon;
  final Color    color;
  final String   label;
  final String?  subtitle;
  final bool     isDivider;
  final bool     isDark;

  @override
  State<_ToggleRow> createState() => _ToggleRowState();
}

class _ToggleRowState extends State<_ToggleRow> {
  bool _on = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: widget.isDivider
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: widget.isDark
                      ? Colors.white.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.06),
                  width: 0.5,
                ),
              ),
            )
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: <Widget>[
          IconBox(icon: widget.icon, color: widget.color, size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize:   14,
                    fontWeight: FontWeight.w600,
                    color:      scheme.onSurface,
                  ),
                ),
                if (widget.subtitle != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    widget.subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color:    scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SAToggle(
            value:     _on,
            onChanged: (v) => setState(() => _on = v),
          ),
        ],
      ),
    );
  }
}
