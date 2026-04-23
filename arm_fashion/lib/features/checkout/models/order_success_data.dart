import 'package:flutter/material.dart';

class OrderSuccessData {
  const OrderSuccessData({
    required this.reference,
    required this.estimatedDelivery,
    required this.deliveryMethod,
    required this.packageCount,
    required this.backgroundGradient,
    required this.packageIcon,
    required this.packageIconColor,
  });

  final String reference;
  final String estimatedDelivery;
  final String deliveryMethod;
  final String packageCount;
  final Gradient backgroundGradient;
  final IconData packageIcon;
  final Color packageIconColor;
}
