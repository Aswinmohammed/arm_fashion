import 'package:flutter/material.dart';

import '../models/home_product.dart';

class HomeDummyData {
  const HomeDummyData._();

  static const List<String> categories = ['Men', 'Women', 'Shoes', 'Accessories'];

  static const List<HomeProduct> newArrivals = [
    HomeProduct(
      id: 'structured-blazer',
      name: 'Structured Blazer',
      price: 'Rs. 425.00',
      label: 'Tailored',
      imagePath: 'images/products/men/structured-wool-overcoat.png',
      backgroundColor: Color(0xFFE2DDD5),
      accentColor: Color(0xFF5A4B40),
      icon: Icons.checkroom_outlined,
    ),
    HomeProduct(
      id: 'square-toe-boot',
      name: 'Square Toe Boot',
      price: 'Rs. 180.00',
      label: 'Leather',
      imagePath: 'images/products/shoes/square-toe-leather-boot.png',
      backgroundColor: Color(0xFFECE9E2),
      accentColor: Color(0xFF1E1E1E),
      icon: Icons.hiking_outlined,
      isFavorite: true,
    ),
    HomeProduct(
      id: 'cashmere-knit',
      name: 'Cashmere Knit',
      price: 'Rs. 310.00',
      label: 'Softwear',
      imagePath: 'images/products/women/cashmere-mock-neck.png',
      backgroundColor: Color(0xFFF3EEE4),
      accentColor: Color(0xFFC9A86A),
      icon: Icons.dry_cleaning_outlined,
    ),
    HomeProduct(
      id: 'mini-tote-bag',
      name: 'Mini Tote Bag',
      price: 'Rs. 950.00',
      label: 'Signature',
      imagePath: 'images/products/accessories/mini-tote-bag.png',
      backgroundColor: Color(0xFFE7E5E2),
      accentColor: Color(0xFF47413F),
      icon: Icons.shopping_bag_outlined,
      isFavorite: true,
    ),
  ];
}
