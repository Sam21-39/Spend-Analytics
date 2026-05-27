import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';
import 'package:spend_analytics/shared/widgets/icon_box.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';
import 'package:spend_analytics/shared/widgets/liquid_page_scaffold.dart';
import 'package:spend_analytics/shared/widgets/sa_shimmer.dart';
import 'package:spend_analytics/shared/widgets/toggle_widget.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LiquidPageScaffold(
      title: 'Settings',
      showBottomNav: false,
      onBack: () => Get.back<void>(),
      child: Obx(() {
        if (controller.isLoading.value) {
          return const _SettingsLoadingSkeleton();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LiquidGlassSurface(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: <Color>[scheme.primary, scheme.secondary],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        controller.displayName.value.isEmpty
                            ? 'U'
                            : controller.displayName.value[0].toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
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
                          controller.displayName.value,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: scheme.onSurface,
                          ),
                        ),
                        if (controller.email.value.isNotEmpty) ...<Widget>[
                          const SizedBox(height: 2),
                          Text(
                            controller.email.value,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                        const SizedBox(height: 3),
                        Text(
                          controller.profileSubtitle,
                          style: TextStyle(
                            fontSize: 13,
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.subscription),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: <Color>[Color(0xFFFFB860), Color(0xFFFF9F40)],
                        ),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Icon(
                            Icons.workspace_premium_rounded,
                            size: 13,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            controller.isGuestMode.value ? 'Go Pro' : 'Plans',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
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
            _SectionLabel(label: 'PREFERENCES'),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  _SettingRow(
                    icon: Icons.palette_rounded,
                    color: const Color(0xFF5B9FFF),
                    label: 'Theme',
                    onTap: () => _showThemeSheet(context),
                    trailing: Text(
                      controller.themeLabel,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    isDivider: true,
                    isDark: isDark,
                  ),
                  _SettingRow(
                    icon: Icons.currency_rupee_rounded,
                    color: const Color(0xFF3FDDA0),
                    label: 'Currency',
                    onTap: () => _showCurrencySheet(context),
                    trailing: Text(
                      controller.selectedCurrency.value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    isDivider: true,
                    isDark: isDark,
                  ),
                  _ToggleRow(
                    icon: Icons.notifications_rounded,
                    color: const Color(0xFFFF9F40),
                    label: 'Notifications',
                    subtitle: 'Budget alerts & reminders',
                    value: controller.notificationsEnabled.value,
                    onChanged: controller.setNotificationsEnabled,
                    isDivider: true,
                    isDark: isDark,
                  ),
                  _ToggleRow(
                    icon: Icons.fingerprint_rounded,
                    color: const Color(0xFF5B9FFF),
                    label: 'Biometric Lock',
                    subtitle: 'Require Face ID / fingerprint',
                    value: controller.biometricLockEnabled.value,
                    onChanged: controller.setBiometricLockEnabled,
                    isDivider: false,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionLabel(label: 'PERMISSIONS'),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  _SettingRow(
                    icon: Icons.notifications_active_rounded,
                    color: const Color(0xFFFF9F40),
                    label: 'Notifications Permission',
                    subtitle: controller.notificationsPermissionLabel,
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => _requestNotificationsPermission(context),
                  ),
                  _SettingRow(
                    icon: Icons.mic_rounded,
                    color: const Color(0xFF5B9FFF),
                    label: 'Microphone Permission',
                    subtitle: controller.microphonePermissionLabel,
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => _requestMicrophonePermission(context),
                  ),
                  _SettingRow(
                    icon: Icons.fingerprint_rounded,
                    color: const Color(0xFFB0A0FF),
                    label: 'Biometric Permission',
                    subtitle: controller.biometricPermissionLabel,
                    chevron: true,
                    isDivider: false,
                    isDark: isDark,
                    onTap: () => _requestBiometricPermission(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionLabel(label: 'DATA & PRIVACY'),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  _SettingRow(
                    icon: Icons.cloud_sync_rounded,
                    color: const Color(0xFFB0A0FF),
                    label: 'Sync & Backup',
                    subtitle: controller.backupSubtitle,
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => _handleSyncTap(context),
                  ),
                  _SettingRow(
                    icon: Icons.download_rounded,
                    color: const Color(0xFF3FDDA0),
                    label: 'Export Data',
                    subtitle:
                        controller.hasPremium
                            ? controller.exportSubtitle
                            : '${controller.exportSubtitle} · CSV on Free',
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => _showExportSheet(context),
                  ),
                  _SettingRow(
                    icon: Icons.delete_sweep_rounded,
                    color: const Color(0xFFFF6B6B),
                    label: 'Clear Local Data',
                    subtitle: 'Remove all offline data',
                    chevron: true,
                    isDivider: false,
                    isDark: isDark,
                    onTap: () => _confirmClearLocalData(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _SectionLabel(label: 'ABOUT'),
            const SizedBox(height: 10),
            LiquidGlassSurface(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  _SettingRow(
                    icon: Icons.info_outline_rounded,
                    color: const Color(0xFF3FDDA0),
                    label: 'About App',
                    subtitle:
                        'Spend Analytics ${controller.appVersionLabel.value}',
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => _showAboutAppDialog(context),
                  ),
                  _SettingRow(
                    icon: Icons.workspace_premium_rounded,
                    color: const Color(0xFFFFB860),
                    label: 'Subscription',
                    subtitle: controller.premiumSubtitle,
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => Get.toNamed(AppRoutes.subscription),
                  ),
                  _SettingRow(
                    icon: Icons.privacy_tip_outlined,
                    color: const Color(0xFF5B9FFF),
                    label: 'Privacy Policy',
                    subtitle: controller.privacyUpdatedLabel,
                    chevron: true,
                    isDivider: true,
                    isDark: isDark,
                    onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                  ),
                  _SettingRow(
                    icon: Icons.description_outlined,
                    color: const Color(0xFFB0A0FF),
                    label: 'Terms of Service',
                    subtitle: 'Subscription & usage terms',
                    chevron: true,
                    isDivider: false,
                    isDark: isDark,
                    onTap: () => Get.toNamed(AppRoutes.terms),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.logout),
              child: LiquidGlassSurface(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.logout_rounded, size: 18, color: scheme.error),
                    const SizedBox(width: 8),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: scheme.error,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                'Spend Analytics ${controller.appVersionLabel.value}',
                style: TextStyle(
                  fontSize: 11,
                  color: scheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  Future<void> _showCurrencySheet(BuildContext context) async {
    final scheme = Theme.of(context).colorScheme;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return LiquidGlassSurface(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                SettingsController.currencies.map((currency) {
                  final active = controller.selectedCurrency.value == currency;
                  return ListTile(
                    dense: true,
                    onTap: () async {
                      await controller.setCurrency(currency);
                      if (ctx.mounted) {
                        Navigator.of(ctx).pop();
                      }
                    },
                    title: Text(
                      currency,
                      style: TextStyle(
                        color: active ? scheme.primary : scheme.onSurface,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    trailing:
                        active
                            ? Icon(
                              Icons.check_rounded,
                              color: scheme.primary,
                              size: 18,
                            )
                            : null,
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _requestNotificationsPermission(BuildContext context) async {
    final granted = await controller.requestNotificationsPermission();
    if (granted) {
      Get.snackbar('Notifications enabled', 'You will receive spend alerts.');
    } else {
      Get.snackbar(
        'Permission blocked',
        'Enable notifications from your device settings.',
      );
    }
  }

  Future<void> _requestMicrophonePermission(BuildContext context) async {
    final granted = await controller.requestMicrophonePermission();
    if (granted) {
      Get.snackbar('Microphone enabled', 'Voice entry is ready to use.');
    } else {
      Get.snackbar(
        'Permission blocked',
        'Allow microphone access to use voice input.',
      );
    }
  }

  Future<void> _requestBiometricPermission(BuildContext context) async {
    final granted = await controller.requestBiometricPermission();
    if (granted) {
      await controller.setBiometricLockEnabled(true);
      Get.snackbar(
        'Biometric enabled',
        'Biometric lock can now protect the app.',
      );
    } else {
      Get.snackbar(
        'Biometric unavailable',
        'Set up biometrics in device settings and try again.',
      );
    }
  }

  Future<void> _showAboutAppDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('About Spend Analytics'),
          content: Text(
            'Spend Analytics helps you track expenses offline-first with optional cloud sync.\n\nVersion: ${controller.appVersionLabel.value}',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Get.toNamed(AppRoutes.privacyPolicy);
              },
              child: const Text('Privacy'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showThemeSheet(BuildContext context) async {
    final scheme = Theme.of(context).colorScheme;
    const options = <(String label, ThemeMode mode)>[
      ('System', ThemeMode.system),
      ('Light', ThemeMode.light),
      ('Dark', ThemeMode.dark),
    ];
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return LiquidGlassSurface(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:
                options.map((option) {
                  final active = controller.themeMode == option.$2;
                  return ListTile(
                    dense: true,
                    onTap: () async {
                      await controller.setThemeMode(option.$2);
                      if (ctx.mounted) {
                        Navigator.of(ctx).pop();
                      }
                    },
                    title: Text(
                      option.$1,
                      style: TextStyle(
                        color: active ? scheme.primary : scheme.onSurface,
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                    trailing:
                        active
                            ? Icon(
                              Icons.check_rounded,
                              color: scheme.primary,
                              size: 18,
                            )
                            : null,
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  Future<void> _handleSyncTap(BuildContext context) async {
    if (controller.hasPremium) {
      Get.snackbar('Cloud Sync', controller.syncSubtitle);
      return;
    }
    await _showPremiumDialog(
      context: context,
      title: 'Cloud Sync is Pro',
      message:
          'Upgrade to Pro to sync transactions, budgets, and rules across devices.',
    );
  }

  Future<void> _showExportSheet(BuildContext context) async {
    final scheme = Theme.of(context).colorScheme;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return LiquidGlassSurface(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.table_chart_rounded),
                title: const Text('Export CSV'),
                subtitle: Text(controller.exportSubtitle),
                onTap: () {
                  Navigator.of(ctx).pop();
                  Get.snackbar(
                    'CSV Export',
                    'Your export has been queued. You will see it in a future update.',
                  );
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.picture_as_pdf_rounded,
                  color:
                      controller.hasPremium
                          ? scheme.onSurface
                          : scheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
                title: Text(
                  'Export PDF Report',
                  style: TextStyle(
                    color:
                        controller.hasPremium
                            ? scheme.onSurface
                            : scheme.onSurfaceVariant,
                  ),
                ),
                subtitle: Text(
                  controller.hasPremium
                      ? 'Advanced monthly report'
                      : 'Pro feature',
                ),
                trailing:
                    controller.hasPremium
                        ? null
                        : Icon(
                          Icons.lock_rounded,
                          size: 16,
                          color: scheme.onSurfaceVariant,
                        ),
                onTap: () async {
                  Navigator.of(ctx).pop();
                  if (controller.hasPremium) {
                    Get.snackbar('PDF Export', 'Generating report...');
                    return;
                  }
                  await _showPremiumDialog(
                    context: context,
                    title: 'PDF Reports are Pro',
                    message:
                        'Upgrade to unlock advanced downloadable PDF reports.',
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _confirmClearLocalData(BuildContext context) async {
    final scheme = Theme.of(context).colorScheme;
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Clear local data?'),
          content: const Text(
            'This removes transactions and settings stored on this device only.',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: scheme.error),
              onPressed: () async {
                await controller.clearLocalData();
                if (ctx.mounted) {
                  Navigator.of(ctx).pop();
                }
                Get.snackbar(
                  'Local data cleared',
                  'Device data has been removed.',
                );
              },
              child: const Text('Clear'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showPremiumDialog({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Later'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Get.toNamed(AppRoutes.subscription);
              },
              child: const Text('View plans'),
            ),
          ],
        );
      },
    );
  }
}

class _SettingsLoadingSkeleton extends StatelessWidget {
  const _SettingsLoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SAShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          SAShimmerBox(height: 100, radius: 20),
          SizedBox(height: 20),
          SAShimmerBox(height: 16, width: 120, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 170, radius: 20),
          SizedBox(height: 16),
          SAShimmerBox(height: 16, width: 130, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 170, radius: 20),
          SizedBox(height: 16),
          SAShimmerBox(height: 16, width: 80, radius: 8),
          SizedBox(height: 10),
          SAShimmerBox(height: 160, radius: 20),
          SizedBox(height: 20),
          SAShimmerBox(height: 54, radius: 28),
        ],
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.8,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
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
  final Color color;
  final String label;
  final String? subtitle;
  final Widget? trailing;
  final bool chevron;
  final bool isDivider;
  final bool isDark;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration:
            isDivider
                ? BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                          isDark
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: scheme.onSurface,
                    ),
                  ),
                  if (subtitle != null) ...<Widget>[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: TextStyle(
                        fontSize: 12,
                        color: scheme.onSurfaceVariant,
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
                size: 16,
                color: scheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.color,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.isDivider,
    required this.isDark,
    this.subtitle,
  });

  final IconData icon;
  final Color color;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String? subtitle;
  final bool isDivider;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration:
          isDivider
              ? BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color:
                        isDark
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
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: scheme.onSurface,
                  ),
                ),
                if (subtitle != null) ...<Widget>[
                  const SizedBox(height: 2),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      fontSize: 12,
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
          ),
          SAToggle(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
