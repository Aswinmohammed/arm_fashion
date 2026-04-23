import 'package:flutter/material.dart';

import '../../products/models/category_product.dart';
import '../models/product_detail.dart';

class ProductDetailDummyData {
  const ProductDetailDummyData._();

  static const ProductDetail product = ProductDetail(
    id: 'structured-wool-blend-coat',
    name: 'STRUCTURED WOOL BLEND COAT',
    price: 'Rs. 420.00',
    subtitle: 'NEW ARRIVAL',
    description:
        'A refined take on the classic overcoat. Crafted from a premium Italian wool blend with a heavy drape and clean, architectural lines. Features internal pockets and a concealed placket.',
    audienceCategory: 'Men',
    productType: 'Coat',
    imagePath: 'images/products/men/structured-wool-overcoat.png',
    heroGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF7A7A74),
        Color(0xFFE0DDD7),
      ],
    ),
    heroIcon: Icons.accessibility_new,
    heroIconColor: Color(0xFF1F3043),
    availableColors: [
      Color(0xFF111111),
      Color(0xFFD1CBC1),
      Color(0xFFC6C8CB),
    ],
    availableSizes: ['S', 'M', 'L', 'XL'],
    selectedColorIndex: 0,
    selectedSize: 'M',
  );

  static const List<CategoryProduct> relatedProducts = [
    CategoryProduct(
      id: 'tailored-trouser',
      name: 'TAILORED TROUSER',
      price: 'Rs. 195.00',
      imagePath: 'images/products/men/executive-fit-trouser.png',
      backgroundColor: Color(0xFF3A4433),
      icon: Icons.straighten_outlined,
      iconColor: Color(0xFFB4B79F),
    ),
    CategoryProduct(
      id: 'chelsey-derby',
      name: 'CHELSEY DERBY',
      price: 'Rs. 295.00',
      imagePath: 'images/products/shoes/mens-loafer-classic.png',
      backgroundColor: Color(0xFF6B4938),
      icon: Icons.hiking_outlined,
      iconColor: Color(0xFFE5D0B5),
    ),
  ];
}
