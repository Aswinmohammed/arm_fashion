import 'package:flutter/material.dart';

class SearchResultItem {
  const SearchResultItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imagePath,
    required this.background,
    required this.icon,
    required this.iconColor,
    this.badge,
  });

  final String id;
  final String name;
  final String category;
  final String price;
  final String imagePath;
  final Gradient background;
  final IconData icon;
  final Color iconColor;
  final String? badge;
}
