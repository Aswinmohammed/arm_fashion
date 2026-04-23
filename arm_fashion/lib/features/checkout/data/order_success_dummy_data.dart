import 'package:flutter/material.dart';

import '../models/order_success_data.dart';

class OrderSuccessDummyData {
  const OrderSuccessDummyData._();

  static const OrderSuccessData data = OrderSuccessData(
    reference: '#ARM-992031-LX',
    estimatedDelivery: 'Oct 24, 2023',
    deliveryMethod: 'Islandwide Courier',
    packageCount: '3 Items',
    backgroundGradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFF3F2EF),
        Color(0xFFA6A39F),
      ],
    ),
    packageIcon: Icons.person_outline,
    packageIconColor: Color(0xFF3F3F3F),
  );
}
