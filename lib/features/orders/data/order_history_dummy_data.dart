import 'package:flutter/material.dart';

import '../models/order_history_entry.dart';

class OrderHistoryDummyData {
  const OrderHistoryDummyData._();

  static const List<OrderHistoryEntry> entries = [
    OrderHistoryEntry(
      orderId: 'ORDER #293847',
      date: 'March 12, 2024',
      status: 'PROCESSING',
      total: 'Rs. 1,450.00',
      actionLabel: 'DETAILS',
      previewItems: [
        OrderHistoryPreviewItem(
          background: Color(0xFFE9E6E0),
          imagePath: 'assets/images/products/men/structured-wool-overcoat.png',
          caption: 'Sculpted Wool Overcoat\nSize: L | Qty: 1',
        ),
      ],
    ),
    OrderHistoryEntry(
      orderId: 'ORDER #293712',
      date: 'February 28, 2024',
      status: 'DELIVERED',
      total: 'Rs. 890.00',
      actionLabel: 'REORDER',
      previewItems: [
        OrderHistoryPreviewItem(
          background: Color(0xFFF1F1F1),
          imagePath: 'assets/images/products/men/relaxed-fit-cotton-shirt.png',
        ),
        OrderHistoryPreviewItem(
          background: Color(0xFF202020),
          imagePath: 'assets/images/products/men/straight-fit-jeans.png',
        ),
        OrderHistoryPreviewItem(
          background: Color(0x00000000),
          icon: Icons.more_horiz,
          iconColor: Color(0xFF8C8C8C),
          caption: '+1 more',
        ),
      ],
    ),
    OrderHistoryEntry(
      orderId: 'ORDER #293501',
      date: 'January 15, 2024',
      status: 'DELIVERED',
      total: 'Rs. 640.00',
      actionLabel: 'DETAILS',
      previewItems: [
        OrderHistoryPreviewItem(
          background: Color(0xFFEAE5DE),
          imagePath: 'assets/images/products/women/asymmetric-silk-blouse.png',
        ),
      ],
    ),
  ];
}
