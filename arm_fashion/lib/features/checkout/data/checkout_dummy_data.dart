import 'package:flutter/material.dart';

import '../models/checkout_order_item.dart';

class CheckoutDummyData {
  const CheckoutDummyData._();

  static const String fullName = 'MOHAMMED ASWIN';
  static const String phoneNumber = '+94 77 123 4567';
  static const String shippingAddress = 'NO. 25, GALLE ROAD';
  static const String city = 'COLOMBO';
  static const String postalCode = '00300';

  static const List<CheckoutOrderItem> items = [
    CheckoutOrderItem(
      name: 'SCULPTURAL WOOL OVERCOAT',
      meta: 'SIZE: M | BLACK',
      price: '£840.00',
      background: Color(0xFFE9E7E2),
      icon: Icons.checkroom_outlined,
      iconColor: Color(0xFF4F4C49),
    ),
    CheckoutOrderItem(
      name: 'LEATHER CHELSEA TRUNK',
      meta: 'SIZE: 42 | EBONY',
      price: '£295.00',
      background: Color(0xFF161616),
      icon: Icons.hiking_outlined,
      iconColor: Color(0xFFE0D1BC),
    ),
  ];
}
