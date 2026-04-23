import 'package:flutter/material.dart';

import '../models/order_history_entry.dart';

class OrderHistoryCard extends StatelessWidget {
  const OrderHistoryCard({
    super.key,
    required this.entry,
    required this.onActionTap,
  });

  final OrderHistoryEntry entry;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isProcessing = entry.status == 'PROCESSING';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.orderId,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: const Color(0xFFB2B2B2),
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry.date,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF363636),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                color: isProcessing
                    ? const Color(0xFFF1EEE8)
                    : const Color(0xFFF8F6F2),
                child: Text(
                  entry.status,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF303030),
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: entry.previewItems.map((item) {
              if (item.caption != null && item.background.a == 0) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item.caption!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF8B8B8B),
                    ),
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Container(
                  width: 54,
                  height: 68,
                  color: item.background,
                  child: Center(
                    child: item.imagePath != null
                        ? Image.asset(
                            item.imagePath!,
                            fit: BoxFit.contain,
                            width: 36,
                            height: 36,
                          )
                        : (item.icon != null
                            ? Icon(
                                item.icon,
                                size: 36,
                                color: item.iconColor,
                              )
                            : const SizedBox()),
                  ),
                ),
              );
            }).toList(),
          ),
          if (entry.previewItems.isNotEmpty &&
              entry.previewItems.first.caption != null) ...[
            const SizedBox(height: 10),
            Text(
              entry.previewItems.first.caption!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: const Color(0xFF444444),
                height: 1.35,
              ),
            ),
          ],
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                entry.total,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: const Color(0xFF232323),
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: onActionTap,
                child: Text(
                  entry.actionLabel,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: const Color(0xFF1F1F1F),
                    decoration: TextDecoration.underline,
                    letterSpacing: 0.8,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
