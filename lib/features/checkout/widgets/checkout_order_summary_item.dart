import 'package:flutter/material.dart';

import '../models/checkout_order_item.dart';

class CheckoutOrderSummaryItem extends StatelessWidget {
  const CheckoutOrderSummaryItem({
    super.key,
    required this.item,
  });

  final CheckoutOrderItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 62,
          height: 76,
          color: item.background,
          child: Center(
            child: item.imagePath != null
                ? Image.asset(
                    item.imagePath!,
                    fit: BoxFit.contain,
                    width: 40,
                    height: 40,
                  )
                : Icon(
                    item.icon,
                    size: 40,
                    color: item.iconColor,
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF363636),
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.meta,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFFAEAEAE),
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.price,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF232323),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
