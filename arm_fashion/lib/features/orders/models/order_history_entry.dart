import 'package:flutter/material.dart';

class OrderHistoryEntry {
  const OrderHistoryEntry({
    required this.orderId,
    required this.date,
    required this.status,
    required this.total,
    required this.actionLabel,
    required this.previewItems,
  });

  final String orderId;
  final String date;
  final String status;
  final String total;
  final String actionLabel;
  final List<OrderHistoryPreviewItem> previewItems;
}

class OrderHistoryPreviewItem {
  const OrderHistoryPreviewItem({
    required this.background,
    this.icon,
    this.iconColor,
    this.caption,
    this.imagePath,
  });

  final Color background;
  final IconData? icon;
  final Color? iconColor;
  final String? caption;
  final String? imagePath; // Local asset path
}
