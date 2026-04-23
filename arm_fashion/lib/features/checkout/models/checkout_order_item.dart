import 'package:flutter/material.dart';

class CheckoutOrderItem {
  const CheckoutOrderItem({
    required this.name,
    required this.meta,
    required this.price,
    required this.background,
    required this.icon,
    required this.iconColor,
    this.imagePath,
  });

  final String name;
  final String meta;
  final String price;
  final Color background;
  final IconData icon;
  final Color iconColor;
  final String? imagePath; // Local asset path
}
