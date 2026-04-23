import 'package:flutter/material.dart';

class OrderSuccessInfoCard extends StatelessWidget {
  const OrderSuccessInfoCard({
    super.key,
    required this.title,
    required this.value,
    this.secondaryValue,
  });

  final String title;
  final String value;
  final String? secondaryValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: const Color(0xFFB1B1B1),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: const Color(0xFF222222),
                  fontWeight: FontWeight.w500,
                ),
          ),
          if (secondaryValue != null) ...[
            const SizedBox(height: 2),
            Text(
              secondaryValue!,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: const Color(0xFF222222),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
