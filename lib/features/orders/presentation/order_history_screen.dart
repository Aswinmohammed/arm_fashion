import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/currency_formatter.dart';
import '../models/order_history_entry.dart';
import '../widgets/order_history_bottom_bar.dart';
import '../widgets/order_history_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final entries = store.orders
            .map((order) => _toOrderHistoryEntry(store, order))
            .toList(growable: false);

        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.menu),
            ),
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.4,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.cart);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(18, 48, 18, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ACCOUNT',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: const Color(0xFF686868),
                                    letterSpacing: 1.8,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'ORDER HISTORY',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: const Color(0xFF2A2A2A),
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.8,
                              ),
                        ),
                        const SizedBox(height: 28),
                        if (entries.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40),
                            child: Center(
                              child: Text(
                                'No orders yet. Your purchases will appear here.',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      color: const Color(0xFF6D6D6D),
                                    ),
                              ),
                            ),
                          )
                        else
                          for (int i = 0; i < entries.length; i++) ...[
                            OrderHistoryCard(
                              entry: entries[i],
                              onActionTap: () {
                                final order = store.orders[i];
                                if (order.status == 'PROCESSING') {
                                  store.selectOrder(order.id);
                                  Navigator.pushNamed(
                                      context, RouteNames.orderDetails);
                                } else {
                                  store.reorder(order.id);
                                  Navigator.pushNamed(context, RouteNames.cart);
                                }
                              },
                            ),
                            if (i != entries.length - 1)
                              const SizedBox(height: 18),
                          ],
                      ],
                    ),
                  ),
                ),
                const OrderHistoryBottomBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  OrderHistoryEntry _toOrderHistoryEntry(AppStore store, OrderRecord order) {
    final previewItems = <OrderHistoryPreviewItem>[];

    for (final line in order.items.take(2)) {
      final product = store.productById(line.productId);
      previewItems.add(
        OrderHistoryPreviewItem(
          background: product.cardBackgroundColor,
          imagePath: product.imagePath,
          // Optionally keep icon/iconColor as fallback if imagePath is missing
          icon: product.cardIcon,
          iconColor: product.cardIconColor,
        ),
      );
    }

    final remaining = order.items.length - 2;
    if (remaining > 0) {
      previewItems.add(
        const OrderHistoryPreviewItem(
          background: Colors.transparent,
          icon: Icons.circle,
          iconColor: Colors.transparent,
          caption: '+ more',
        ),
      );
    }

    return OrderHistoryEntry(
      orderId: order.id,
      date: order.dateLabel,
      status: order.status,
      total: CurrencyFormatter.lkr(order.total),
      actionLabel: order.status == 'PROCESSING' ? 'DETAILS' : 'REORDER',
      previewItems: previewItems,
    );
  }
}
