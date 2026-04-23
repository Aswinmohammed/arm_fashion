import 'package:flutter/material.dart';

import '../../../core/widgets/app_product_image.dart';
import '../models/category_product.dart';

class RelatedProductTile extends StatelessWidget {
  const RelatedProductTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  final CategoryProduct product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 0.84,
              child: Container(
                decoration: BoxDecoration(
                  color: product.backgroundColor,
                ),
                child: AppProductImage(
                  imagePath: product.imagePath,
                  fit: BoxFit.cover,
                  fallbackIcon: product.icon,
                  fallbackIconColor: product.iconColor,
                  iconSize: 78,
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelSmall?.copyWith(
                color: const Color(0xFF2F2F2F),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.price,
              style: theme.textTheme.bodySmall?.copyWith(
                color: const Color(0xFF6E6E6E),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
