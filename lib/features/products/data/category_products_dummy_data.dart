import 'package:flutter/material.dart';

import '../models/category_product.dart';

class CategoryProductsDummyData {
  const CategoryProductsDummyData._();

  static const List<CategoryProduct> products = [
    CategoryProduct(
      id: 'structured-wool-overcoat',
      name: 'Structured Wool Coat',
      price: 'Rs. 450.00',
      imagePath: 'images/products/men/structured-wool-overcoat.png',
      backgroundColor: Color(0xFF2C2D1F),
      icon: Icons.checkroom_outlined,
      iconColor: Color(0xFF9D9360),
      badgeText: 'NEW',
    ),
    CategoryProduct(
      id: 'oversized-cotton-shirt',
      name: 'Oversized Cotton Shirt',
      price: 'Rs. 185.00',
      imagePath: 'images/products/men/oversized-cotton-shirt.png',
      backgroundColor: Color(0xFFF2EADF),
      icon: Icons.checkroom,
      iconColor: Color(0xFFD0B48B),
    ),
    CategoryProduct(
      id: 'tailored-trousers',
      name: 'Tailored Trousers',
      price: 'Rs. 220.00',
      imagePath: 'images/products/women/pleated-silk-trousers.png',
      backgroundColor: Color(0xFF8B8D90),
      icon: Icons.straighten_outlined,
      iconColor: Color(0xFF323336),
    ),
    CategoryProduct(
      id: 'merino-knit-sweater',
      name: 'Merino Knit Sweater',
      price: 'Rs. 295.00',
      imagePath: 'images/products/women/cashmere-mock-neck.png',
      backgroundColor: Color(0xFFE5E6E4),
      icon: Icons.dry_cleaning_outlined,
      iconColor: Color(0xFFACB0B2),
      badgeText: 'EXCLUSIVE',
    ),
    CategoryProduct(
      id: 'square-toe-leather-boot',
      name: 'Leather Chelsea Boot',
      price: 'Rs. 380.00',
      imagePath: 'images/products/shoes/square-toe-leather-boot.png',
      backgroundColor: Color(0xFF8E5B3D),
      icon: Icons.hiking_outlined,
      iconColor: Color(0xFF4F2712),
    ),
    CategoryProduct(
      id: 'nylon-shell-parka',
      name: 'Nylon Shell Parka',
      price: 'Rs. 510.00',
      imagePath: 'images/products/men/nylon-shell-parka.png',
      backgroundColor: Color(0xFF2B2E31),
      icon: Icons.checkroom_outlined,
      iconColor: Color(0xFF62676C),
    ),
  ];
}
