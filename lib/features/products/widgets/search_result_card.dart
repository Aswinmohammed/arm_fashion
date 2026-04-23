import 'package:flutter/material.dart';

import '../../../core/widgets/app_product_image.dart';
import '../models/search_result_item.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  final SearchResultItem item;
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
            aspectRatio: 0.72,
            child: Container(
              decoration: BoxDecoration(
                gradient: item.background,
                borderRadius: BorderRadius.circular(1),
              ),
              child: Stack(
                children: [
                  if (item.badge != null)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        color: Colors.white,
                        child: Text(
                          item.badge!,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF3A3A3A),
                            fontSize: 7,
                            letterSpacing: 0.7,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  Center(
                    child: AppProductImage(
                      imagePath: item.imagePath,
                      fit: BoxFit.cover,
                      fallbackIcon: item.icon,
                      fallbackIconColor: item.iconColor,
                      iconSize: 118,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item.category,
            style: theme.textTheme.labelSmall?.copyWith(
              color: const Color(0xFF979797),
              letterSpacing: 1.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              color: const Color(0xFF262626),
              height: 1.15,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            item.price,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF262626),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
