import 'package:flutter/material.dart';

import '../models/wishlist_item.dart';

class WishlistDummyData {
  const WishlistDummyData._();

  static const List<WishlistItem> items = [
    WishlistItem(
      id: 'structured-wool-overcoat',
      name: 'Structured Wool Overcoat',
      category: 'Outerwear',
      price: 'Rs. 850.00',
      imagePath: 'images/products/men/structured-wool-overcoat.png',
      background: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFB7B2AE),
          Color(0xFF74706D),
        ],
      ),
      icon: Icons.checkroom_outlined,
      iconColor: Color(0xFF3D3A39),
    ),
    WishlistItem(
      id: 'asymmetric-silk-blouse',
      name: 'Asymmetric Silk Blouse',
      category: 'Blouse',
      price: 'Rs. 420.00',
      imagePath: 'images/products/women/asymmetric-silk-blouse.png',
      background: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFF1EFED),
          Color(0xFFDAD8D5),
        ],
      ),
      icon: Icons.dry_cleaning_outlined,
      iconColor: Color(0xFF64615F),
    ),
    WishlistItem(
      id: 'square-toe-leather-boot',
      name: 'Square-Toe Leather Boot',
      category: 'Footwear',
      price: 'Rs. 690.00',
      imagePath: 'images/products/shoes/square-toe-leather-boot.png',
      background: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF151515),
          Color(0xFF535353),
        ],
      ),
      icon: Icons.hiking_outlined,
      iconColor: Color(0xFFD6D6D6),
    ),
  ];
}
