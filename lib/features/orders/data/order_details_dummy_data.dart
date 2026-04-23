import 'package:flutter/material.dart';

import '../models/order_detail_data.dart';
import '../models/order_detail_item.dart';

class OrderDetailsDummyData {
  const OrderDetailsDummyData._();

  static const OrderDetailData summary = OrderDetailData(
    orderId: '#ARM-99281-XC',
    date: 'Oct 24, 2023',
    status: 'IN TRANSIT',
    shippingName: 'Mohammed Aswin',
    shippingAddressLines: [
      'No. 30 Ampara Road',
      'Udanga-01',
      'Sammanthurai, Sri Lanka',
    ],
    paymentMethod: 'Commercial Bank Visa ending in 4492',
    subtotal: 'Rs. 1,930.00',
    discount: 'Rs. 0.00',
    shipping: 'Rs. 0.00',
    tax: 'Rs. 164.05',
    total: 'Rs. 2,094.05',
  );

  static const List<OrderDetailItem> items = [
    OrderDetailItem(
      name: 'STRUCTURED WOOL OVERCOAT',
      meta: 'SIZE: M | COLOR: OBSIDIAN',
      quantity: 1,
      price: 'Rs. 1,250.00',
      background: Color(0xFFE7E4DE),
      icon: Icons.checkroom_outlined,
      iconColor: Color(0xFF454545),
    ),
    OrderDetailItem(
      name: 'PLEATED SILK TROUSERS',
      meta: 'SIZE: 32 | COLOR: BONE',
      quantity: 1,
      price: 'Rs. 680.00',
      background: Color(0xFFF3F1EC),
      icon: Icons.accessibility_new_outlined,
      iconColor: Color(0xFFC9C3BA),
    ),
  ];
}
