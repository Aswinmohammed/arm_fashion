import 'package:flutter/material.dart';

class ProductInfoRow extends StatelessWidget {
  const ProductInfoRow({
    super.key,
    required this.title,
    this.onTap,
  });

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF5F5F5F),
                      letterSpacing: 0.9,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const Icon(
              Icons.add,
              size: 18,
              color: Color(0xFF6E6E6E),
            ),
          ],
        ),
      ),
    );
  }
}
