import 'package:flutter/material.dart';

import '../../../core/state/app_scope.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () => Navigator.maybePop(context),
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            ),
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.4,
                  ),
            ),
          ),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PROFILE',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF6A6A6A),
                          letterSpacing: 1.8,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SETTINGS',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF1E1E1E),
                          letterSpacing: -0.8,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Control notifications, shopping preferences, and account convenience features.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5F5F5F),
                        ),
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle(title: 'NOTIFICATIONS'),
                  const SizedBox(height: 12),
                  _SettingsToggleTile(
                    title: 'Order updates',
                    subtitle: 'Delivery progress, dispatch alerts, and status updates',
                    value: store.orderUpdatesEnabled,
                    onChanged: store.setOrderUpdatesEnabled,
                  ),
                  _SettingsToggleTile(
                    title: 'Promotions and launches',
                    subtitle: 'New arrivals, festive edits, and store offers',
                    value: store.promotionsEnabled,
                    onChanged: store.setPromotionsEnabled,
                  ),
                  _SettingsToggleTile(
                    title: 'Wishlist restock alerts',
                    subtitle: 'Get notified when saved products are back in stock',
                    value: store.wishlistRestockAlertsEnabled,
                    onChanged: store.setWishlistRestockAlertsEnabled,
                  ),
                  const SizedBox(height: 24),
                  const _SectionTitle(title: 'ACCOUNT'),
                  const SizedBox(height: 12),
                  _SettingsToggleTile(
                    title: 'Biometric login',
                    subtitle: 'Use fingerprint or face recognition on supported devices',
                    value: store.biometricLoginEnabled,
                    onChanged: store.setBiometricLoginEnabled,
                  ),
                  const SizedBox(height: 12),
                  const _InfoTile(
                    title: 'Language',
                    value: 'English',
                  ),
                  const _InfoTile(
                    title: 'Currency',
                    value: 'Sri Lankan Rupee (Rs.)',
                  ),
                  const _InfoTile(
                    title: 'Region',
                    value: 'Sri Lanka',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: const Color(0xFF444444),
            fontWeight: FontWeight.w700,
            letterSpacing: 1.9,
          ),
    );
  }
}

class _SettingsToggleTile extends StatelessWidget {
  const _SettingsToggleTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(16, 14, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1DCD4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF242424),
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: const Color(0xFF646464),
                      ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.black,
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1DCD4)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF242424),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF686868),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
