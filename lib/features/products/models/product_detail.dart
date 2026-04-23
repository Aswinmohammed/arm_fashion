import 'package:flutter/material.dart';

class ProductDetail {
  const ProductDetail({
    required this.id,
    required this.name,
    required this.price,
    required this.subtitle,
    required this.description,
    required this.audienceCategory,
    required this.productType,
    required this.imagePath,
    required this.heroGradient,
    required this.heroIcon,
    required this.heroIconColor,
    required this.availableColors,
    required this.availableSizes,
    required this.selectedColorIndex,
    required this.selectedSize,
  });

  final String id;
  final String name;
  final String price;
  final String subtitle;
  final String description;
  final String audienceCategory;
  final String productType;
  final String imagePath;
  final Gradient heroGradient;
  final IconData heroIcon;
  final Color heroIconColor;
  final List<Color> availableColors;
  final List<String> availableSizes;
  final int selectedColorIndex;
  final String selectedSize;
}
