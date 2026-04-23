import 'package:flutter/material.dart';

class CategoryProduct {
  const CategoryProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
    this.badgeText,
  });

  final String id;
  final String name;
  final String price;
  final String imagePath;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final String? badgeText;
}
