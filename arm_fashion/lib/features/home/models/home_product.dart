import 'package:flutter/material.dart';

class HomeProduct {
  const HomeProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.label,
    required this.imagePath,
    required this.backgroundColor,
    required this.accentColor,
    required this.icon,
    this.isFavorite = false,
  });

  final String id;
  final String name;
  final String price;
  final String label;
  final String imagePath;
  final Color backgroundColor;
  final Color accentColor;
  final IconData icon;
  final bool isFavorite;
}
