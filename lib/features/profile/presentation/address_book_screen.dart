import 'package:flutter/material.dart';

import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';

class AddressBookScreen extends StatelessWidget {
  const AddressBookScreen({super.key});

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
                    'ADDRESS BOOK',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF1E1E1E),
                          letterSpacing: -0.8,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Manage your delivery addresses for Colombo, Kandy, and everywhere your orders need to go.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5F5F5F),
                        ),
                  ),
                  const SizedBox(height: 24),
                  ...store.addresses.map(
                    (address) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _AddressCard(
                        entry: address,
                        onSetDefault: address.isDefault
                            ? null
                            : () => store.setDefaultAddress(address.id),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Add new address flow can be connected next.'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2D2D2D),
                        side: const BorderSide(color: Color(0xFFD2CEC7)),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      icon: const Icon(Icons.add_location_alt_outlined),
                      label: const Text('ADD NEW ADDRESS'),
                    ),
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

class _AddressCard extends StatelessWidget {
  const _AddressCard({
    required this.entry,
    required this.onSetDefault,
  });

  final AddressBookEntry entry;
  final VoidCallback? onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE1DCD4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                entry.label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF222222),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.1,
                    ),
              ),
              const Spacer(),
              if (entry.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  color: const Color(0xFF1E1E1E),
                  child: Text(
                    'DEFAULT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            entry.recipientName,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF2B2B2B),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 6),
          Text(
            '${entry.addressLine}\n${entry.city} ${entry.postalCode}\n${entry.phoneNumber}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF616161),
                  height: 1.55,
                ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onSetDefault,
              style: FilledButton.styleFrom(
                backgroundColor: entry.isDefault ? const Color(0xFFD9D3CB) : Colors.black,
                foregroundColor: entry.isDefault ? const Color(0xFF4B4B4B) : Colors.white,
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(entry.isDefault ? 'DEFAULT ADDRESS' : 'SET AS DEFAULT'),
            ),
          ),
        ],
      ),
    );
  }
}
