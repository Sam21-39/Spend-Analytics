import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/features/auth/auth_controller.dart';
import 'package:spend_analytics/features/settings/settings_controller.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          Obx(
            () => ListTile(
              leading: const Icon(Icons.currency_rupee),
              title: const Text('Default Currency'),
              subtitle: Text(controller.selectedCurrency.value),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.privacy_tip_outlined),
            title: Text('Privacy First'),
            subtitle: Text('No ads. No selling personal financial data.'),
          ),
          const SizedBox(height: 8),
          Obx(
            () => FilledButton.icon(
              onPressed: authController.isLoading.value
                  ? null
                  : authController.signOut,
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
            ),
          ),
        ],
      ),
    );
  }
}
