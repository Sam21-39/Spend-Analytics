import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_background.dart';
import 'package:spend_analytics/shared/widgets/liquid_glass_surface.dart';

class VoiceAutoReviewScreen extends StatelessWidget {
  const VoiceAutoReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          const LiquidGlassBackground(),
          SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              children: <Widget>[
                Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () => Get.back<void>(),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Review Transaction',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                LiquidGlassSurface(
                  child: Column(
                    children: <Widget>[
                      const Icon(
                        Icons.mic_rounded,
                        size: 42,
                        color: Color(0xFFADC6FF),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Voice Captured Successfully',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: scheme.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                const LiquidGlassSurface(
                  child: Text(
                    '"Spent 450 rupees on dinner at Leon Grill"',
                    style: TextStyle(fontStyle: FontStyle.italic, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 12),
                const _DetailTile(
                  icon: Icons.currency_rupee_rounded,
                  title: 'Amount',
                  value: '₹450.00',
                ),
                const SizedBox(height: 8),
                const _DetailTile(
                  icon: Icons.restaurant_rounded,
                  title: 'Category',
                  value: 'Food & Dining',
                  subValue: 'Merchant: Leon Grill',
                ),
                const SizedBox(height: 8),
                const _DetailTile(
                  icon: Icons.calendar_today_rounded,
                  title: 'Date',
                  value: 'Today',
                ),
                const SizedBox(height: 8),
                const _DetailTile(
                  icon: Icons.account_balance_rounded,
                  title: 'Payment',
                  value: 'HDFC Bank UPI',
                  subValue: 'Auto-detected',
                ),
                const SizedBox(height: 14),
                FilledButton.icon(
                  onPressed:
                      () => Get.snackbar('Saved', 'Voice transaction saved.'),
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Confirm & Save'),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back<void>(),
                        child: const Text('Edit Manually'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Get.back<void>(),
                        child: const Text('Discard'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailTile extends StatelessWidget {
  const _DetailTile({
    required this.icon,
    required this.title,
    required this.value,
    this.subValue,
  });

  final IconData icon;
  final String title;
  final String value;
  final String? subValue;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassSurface(
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white.withValues(alpha: 0.08),
            child: Icon(icon),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(value, style: Theme.of(context).textTheme.titleMedium),
                if (subValue != null)
                  Text(
                    subValue!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
          const Icon(Icons.edit_rounded, size: 18),
        ],
      ),
    );
  }
}
