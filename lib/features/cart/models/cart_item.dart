import 'package:flutter/material.dart';

class CartItem {
  const CartItem({
    required this.id,
    required this.name,
    required this.size,
    required this.color,
    required this.quantity,
    required this.price,
    required this.imagePath,
    required this.background,
    required this.icon,
    required this.iconColor,
  });

  final String id;
  final String name;
  final String size;
  final String color;
  final int quantity;
  final String price;
  final String imagePath;
  final Color background;
  final IconData icon;
  final Color iconColor;
}
