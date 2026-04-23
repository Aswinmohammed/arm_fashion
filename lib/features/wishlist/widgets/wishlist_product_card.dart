import 'package:flutter/material.dart';

import '../../../core/widgets/app_product_image.dart';
import '../models/wishlist_item.dart';

class WishlistProductCard extends StatelessWidget {
  const WishlistProductCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final WishlistItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1.05,
            child: Container(
              decoration: BoxDecoration(
                gradient: item.background,
                borderRadius: BorderRadius.circular(1),
              ),
              child: AppProductImage(
                imagePath: item.imagePath,
                fit: BoxFit.cover,
                fallbackIcon: item.icon,
                fallbackIconColor: item.iconColor,
                iconSize: 150,
                padding: const EdgeInsets.all(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name.toUpperCase(),
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: const Color(0xFF1C1C1C),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.category.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFF9A9A9A),
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.favorite,
                  size: 18,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            item.price,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF1F1F1F),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
