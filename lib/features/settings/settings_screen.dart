import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/core/routes/app_routes.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController =
        Get.isRegistered<AuthController>()
            ? Get.find<AuthController>()
            : Get.put(AuthController(), permanent: true);
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => Get.back<void>(),
                        icon: const Icon(Icons.arrow_back_rounded),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Settings',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LiquidGlassSurface(
                    child: Obx(
                      () => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.currency_rupee_rounded),
                        title: const Text('Default Currency'),
                        subtitle: Text(controller.selectedCurrency.value),
                        trailing: Icon(
                          Icons.chevron_right_rounded,
                          color: scheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiquidGlassSurface(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Privacy First',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No ads. No third-party data brokering. Isolated sync and export-friendly controls.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiquidGlassSurface(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.workspace_premium_rounded),
                      title: const Text('Subscription Plans'),
                      subtitle: const Text('Free, Pro, and Family tiers'),
                      trailing: const Icon(Icons.chevron_right_rounded),
                      onTap: () => Get.toNamed(AppRoutes.subscription),
                    ),
                  ),
                  const SizedBox(height: 12),
                  LiquidGlassSurface(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.privacy_tip_outlined),
                          title: const Text('Privacy Policy'),
                          subtitle: const Text('Last updated: May 2026'),
                          trailing: const Icon(Icons.open_in_new_rounded),
                          onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
                        ),
                        const Divider(height: 1),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.description_outlined),
                          title: const Text('Terms of Service'),
                          subtitle: const Text('Subscription and usage terms'),
                          trailing: const Icon(Icons.open_in_new_rounded),
                          onTap: () => Get.toNamed(AppRoutes.terms),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Obx(
                    () => FilledButton.icon(
                      onPressed:
                          authController.isLoading.value
                              ? null
                              : authController.signOut,
                      icon: const Icon(Icons.logout_rounded),
                      label: const Text('Sign Out'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
