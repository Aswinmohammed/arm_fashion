import 'package:flutter/material.dart';

import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';

class PaymentMethodsScreen extends StatelessWidget {
  const PaymentMethodsScreen({super.key});

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
                    'PAYMENT METHODS',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: const Color(0xFF1E1E1E),
                          letterSpacing: -0.8,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Keep your preferred cards ready for faster checkout and secure repeat purchases.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF5F5F5F),
                        ),
                  ),
                  const SizedBox(height: 24),
                  ...store.paymentMethods.map(
                    (method) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _PaymentCard(
                        method: method,
                        onSetDefault: method.isDefault
                            ? null
                            : () => store.setDefaultPaymentMethod(method.id),
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
                            content: Text('Add card flow can be connected next.'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2D2D2D),
                        side: const BorderSide(color: Color(0xFFD2CEC7)),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      icon: const Icon(Icons.add_card_outlined),
                      label: const Text('ADD NEW CARD'),
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

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    required this.method,
    required this.onSetDefault,
  });

  final PaymentMethodRecord method;
  final VoidCallback? onSetDefault;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF2C2C2C),
            Color(0xFF49433E),
          ],
        ),
        border: Border.all(color: const Color(0xFF403A35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                method.brand,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
              ),
              const Spacer(),
              if (method.isDefault)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  color: Colors.white,
                  child: Text(
                    'DEFAULT',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF222222),
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            method.maskedNumber,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  letterSpacing: 2.6,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _CardMeta(label: 'CARD HOLDER', value: method.holderName),
              ),
              Expanded(
                child: _CardMeta(label: 'EXPIRES', value: method.expiry),
              ),
            ],
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onSetDefault,
              style: FilledButton.styleFrom(
                backgroundColor: method.isDefault ? const Color(0xFFDDD6CC) : Colors.white,
                foregroundColor: const Color(0xFF1F1F1F),
                shape: const RoundedRectangleBorder(),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Text(method.isDefault ? 'PRIMARY PAYMENT METHOD' : 'SET AS PRIMARY'),
            ),
          ),
        ],
      ),
    );
  }
}

class _CardMeta extends StatelessWidget {
  const _CardMeta({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFFD6D0C8),
                letterSpacing: 1.2,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
