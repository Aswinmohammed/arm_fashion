import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/currency_formatter.dart';
import '../models/order_detail_data.dart';
import '../models/order_detail_item.dart';
import '../widgets/order_detail_line_item.dart';
import '../widgets/order_info_section.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final order = store.selectedOrder;
        final summary = _toOrderDetailData(order);
        final items = order.items
            .map((line) => _toOrderDetailItem(store, line))
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
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(12, 14, 12, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORDER STATUS',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF666666),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'o ${summary.status}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: const Color(0xFF353535),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Expanded(
                        child: _MetaBlock(
                          label: 'ORDER ID',
                          value: summary.orderId,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: _MetaBlock(
                          label: 'DATE',
                          value: summary.date,
                          alignEnd: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _TrackingTimeline(
                    status: order.status,
                    estimatedDelivery: order.estimatedDeliveryLabel,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'YOUR SELECTION',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: const Color(0xFF666666),
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 14),
                  for (int i = 0; i < items.length; i++) ...[
                    OrderDetailLineItem(item: items[i]),
                    if (i != items.length - 1) const SizedBox(height: 18),
                  ],
                  const SizedBox(height: 28),
                  OrderInfoSection(
                    title: 'Shipping Address',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          summary.shippingName,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xFF3C3C3C),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        ...summary.shippingAddressLines.map(
                          (line) => Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Text(
                              line,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: const Color(0xFF575757),
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  OrderInfoSection(
                    title: 'Payment Method',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.credit_card,
                          color: Color(0xFF888888),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          summary.paymentMethod,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xFF4F4F4F),
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _TotalRow(label: 'SUBTOTAL', value: summary.subtotal),
                  const SizedBox(height: 14),
                  if (order.discount > 0) ...[
                    _TotalRow(
                      label: 'DISCOUNT',
                      value: '- ${summary.discount}',
                      valueColor: const Color(0xFF2C6A45),
                    ),
                    const SizedBox(height: 14),
                  ],
                  _TotalRow(label: 'SHIPPING', value: summary.shipping),
                  const SizedBox(height: 14),
                  _TotalRow(label: 'TAX', value: summary.tax),
                  const SizedBox(height: 16),
                  const Divider(color: Color(0xFFE0DCD5), height: 1),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        'TOTAL',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: const Color(0xFF2B2B2B),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.4,
                            ),
                      ),
                      const Spacer(),
                      Text(
                        summary.total,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                              color: const Color(0xFF2B2B2B),
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Shipment tracking will be available soon.')),
                        );
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  letterSpacing: 2.2,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      child: const Text('TRACK SHIPMENT'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Invoice download is coming soon.')),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF2E2E2E),
                        side: const BorderSide(color: Color(0xFFD8D5CF)),
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        textStyle:
                            Theme.of(context).textTheme.labelLarge?.copyWith(
                                  letterSpacing: 1.8,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                      child: const Text('DOWNLOAD INVOICE'),
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

  OrderDetailData _toOrderDetailData(OrderRecord order) {
    return OrderDetailData(
      orderId: order.id,
      date: order.dateLabel,
      status: order.status,
      shippingName: order.shippingName,
      shippingAddressLines: [
        order.shippingAddress,
        '${order.city}, ${order.postalCode}',
        order.shippingPhone,
      ],
      paymentMethod: order.paymentMethod,
      subtotal: CurrencyFormatter.lkr(order.subtotal),
      discount: CurrencyFormatter.lkr(order.discount),
      shipping: order.shippingCost == 0
          ? 'FREE'
          : CurrencyFormatter.lkr(order.shippingCost),
      tax: CurrencyFormatter.lkr(order.tax),
      total: CurrencyFormatter.lkr(order.total),
    );
  }

  OrderDetailItem _toOrderDetailItem(AppStore store, OrderLine line) {
    final product = store.productById(line.productId);
    return OrderDetailItem(
      name: line.name,
      meta: '${line.productType} | SIZE ${line.selectedSize}',
      quantity: line.quantity,
      price: CurrencyFormatter.lkr(line.unitPrice * line.quantity),
      background: product.cardBackgroundColor,
      icon: product.cardIcon,
      iconColor: product.cardIconColor,
      imagePath: product.imagePath,
    );
  }
}

class _MetaBlock extends StatelessWidget {
  const _MetaBlock({
    required this.label,
    required this.value,
    this.alignEnd = false,
  });

  final String label;
  final String value;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignEnd ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF666666),
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          textAlign: alignEnd ? TextAlign.right : TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: const Color(0xFF3A3A3A),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: const Color(0xFF555555),
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: valueColor ?? const Color(0xFF555555),
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

class _TrackingTimeline extends StatelessWidget {
  const _TrackingTimeline({
    required this.status,
    required this.estimatedDelivery,
  });

  final String status;
  final String estimatedDelivery;

  @override
  Widget build(BuildContext context) {
    final steps = [
      ('Order Placed', true),
      ('Payment Confirmed', true),
      ('Packed', true),
      ('In Transit', status == 'PROCESSING' || status == 'DELIVERED'),
      ('Delivered', status == 'DELIVERED'),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE0DCD5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TRACKING TIMELINE',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFF666666),
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: 14),
          ...steps.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final step = entry.value.$1;
              final isComplete = entry.value.$2;
              final isLast = index == steps.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isComplete ? Colors.black : Colors.white,
                          border: Border.all(
                            color: isComplete
                                ? Colors.black
                                : const Color(0xFFB7B2AA),
                          ),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 1,
                          height: 28,
                          color: isComplete
                              ? Colors.black
                              : const Color(0xFFD7D2CA),
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        step,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: isComplete
                                  ? const Color(0xFF242424)
                                  : const Color(0xFF7A7A7A),
                              fontWeight: isComplete
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 6),
          Text(
            'Estimated delivery: $estimatedDelivery',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF666666),
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ),
    );
  }
}
