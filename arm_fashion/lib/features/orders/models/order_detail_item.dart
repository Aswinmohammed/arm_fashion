import 'package:flutter/material.dart';

class OrderDetailItem {
  const OrderDetailItem({
    required this.name,
    required this.meta,
    required this.quantity,
    required this.price,
    required this.background,
    required this.icon,
    required this.iconColor,
    this.imagePath,
  });

  final String name;
  final String meta;
  final int quantity;
  final String price;
  final Color background;
  final IconData icon;
  final Color iconColor;
  final String? imagePath; // Local asset path
}
