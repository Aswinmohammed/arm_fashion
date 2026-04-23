import 'package:flutter/material.dart';

import '../../../core/widgets/app_product_image.dart';
import '../models/home_product.dart';

class HomeProductCard extends StatelessWidget {
  const HomeProductCard({
    super.key,
    required this.product,
    required this.onTap,
  });

  final HomeProduct product;
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
            aspectRatio: 0.82,
            child: Container(
              decoration: BoxDecoration(
                color: product.backgroundColor,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.34),
                            product.backgroundColor,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: AppProductImage(
                      imagePath: product.imagePath,
                      fit: BoxFit.cover,
                      fallbackIcon: product.icon,
                      fallbackIconColor: product.accentColor,
                      iconSize: 62,
                      padding: const EdgeInsets.all(12),
                    ),
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Icon(
                      product.isFavorite
                          ? Icons.favorite_border
                          : Icons.favorite_outline,
                      size: 16,
                      color: const Color(0xFF9A9A9A),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.name.toUpperCase(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.labelSmall?.copyWith(
              color: const Color(0xFF555555),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            product.price,
            style: theme.textTheme.bodySmall?.copyWith(
              color: const Color(0xFF555555),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
