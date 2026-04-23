import 'package:flutter/material.dart';

import '../../../core/widgets/app_product_image.dart';
import '../models/cart_item.dart';

class CartItemCard extends StatelessWidget {
  const CartItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.onRemove,
    required this.onDecrease,
    required this.onIncrease,
  });

  final CartItem item;
  final VoidCallback onTap;
  final VoidCallback onRemove;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 92,
            height: 126,
            color: item.background,
            child: AppProductImage(
              imagePath: item.imagePath,
              fit: BoxFit.cover,
              fallbackIcon: item.icon,
              fallbackIconColor: item.iconColor,
              iconSize: 64,
              padding: const EdgeInsets.all(8),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: const Color(0xFF2D2D2D),
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onRemove,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 6, top: 2),
                        child: Icon(
                          Icons.close,
                          size: 18,
                          color: Color(0xFF8F8F8F),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'SIZE: ${item.size}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF919191),
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'COLOR: ${item.color}',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF919191),
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _QtyButton(
                      icon: Icons.remove,
                      onTap: onDecrease,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '${item.quantity}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF2C2C2C),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 12),
                    _QtyButton(
                      icon: Icons.add,
                      onTap: onIncrease,
                    ),
                    const Spacer(),
                    Text(
                      item.price,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF222222),
                        fontWeight: FontWeight.w600,
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

class _QtyButton extends StatelessWidget {
  const _QtyButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: 18,
        color: const Color(0xFF9B9B9B),
      ),
    );
  }
}
