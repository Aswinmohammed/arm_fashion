import 'package:flutter/material.dart';

import '../models/order_detail_item.dart';

class OrderDetailLineItem extends StatelessWidget {
  const OrderDetailLineItem({
    super.key,
    required this.item,
  });

  final OrderDetailItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 88,
          height: 120,
          color: item.background,
          child: Center(
            child: item.imagePath != null
                ? Image.asset(
                    item.imagePath!,
                    fit: BoxFit.contain,
                    width: 52,
                    height: 52,
                  )
                : Icon(
                    item.icon,
                    size: 52,
                    color: item.iconColor,
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF2D2D2D),
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.meta,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFA5A5A5),
                  letterSpacing: 0.8,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'QTY: ${item.quantity}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: const Color(0xFFA5A5A5),
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    item.price,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: const Color(0xFF252525),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
