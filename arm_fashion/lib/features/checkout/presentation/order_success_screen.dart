import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../widgets/order_success_info_card.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final order = store.latestOrder;
        final packageCount = order.items.fold<int>(0, (sum, item) => sum + item.quantity);

        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF4B4B4B),
                  Color(0xFF141414),
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(12, 56, 12, 28),
                child: Column(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.white, width: 6),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 220,
                      child: Text(
                        'Order Placed\nSuccessfully',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              height: 0.95,
                            ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: 240,
                      child: Text(
                        'Thank you for choosing ARM FASHION. Your wardrobe upgrade is on the way.',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFFE4E4E4),
                              height: 1.45,
                            ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    OrderSuccessInfoCard(
                      title: 'Order Reference',
                      value: order.id,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OrderSuccessInfoCard(
                            title: 'Estimated Delivery',
                            value: order.estimatedDeliveryLabel,
                          ),
                        ),
                        const SizedBox(width: 1),
                        Expanded(
                          child: OrderSuccessInfoCard(
                            title: 'Method',
                            value: order.deliveryMethod.split(' ').first,
                            secondaryValue: order.deliveryMethod.split(' ').skip(1).join(' '),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      height: 100,
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFB1B1B1),
                            Color(0xFF5D5D5D),
                          ],
                        ),
                      ),
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 72,
                              color: Color(0xFFF2E8DB),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: Colors.white,
                                    ),
                                children: [
                                  TextSpan(
                                    text: 'PACKAGE CONTENTS\n',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: const Color(0xFFD3D3D3),
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  TextSpan(
                                    text: '$packageCount items | View Receipt',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RouteNames.mainShell,
                            (route) => false,
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                letterSpacing: 2.6,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        child: const Text('CONTINUE SHOPPING'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteNames.orderHistory);
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2A2A2A),
                          side: const BorderSide(color: Color(0xFFD2D0CC)),
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                                letterSpacing: 2.2,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        child: const Text('TRACK MY ORDER'),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Text(
                      'MEMBERSHIP STATUS: ${order.membershipStatus}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFFCFCFCF),
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'POINTS EARNED: ${order.pointsEarned}',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFFD7D7D7),
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
