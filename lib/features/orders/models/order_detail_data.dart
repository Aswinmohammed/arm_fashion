class OrderDetailData {
  const OrderDetailData({
    required this.orderId,
    required this.date,
    required this.status,
    required this.shippingName,
    required this.shippingAddressLines,
    required this.paymentMethod,
    required this.subtotal,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  final String orderId;
  final String date;
  final String status;
  final String shippingName;
  final List<String> shippingAddressLines;
  final String paymentMethod;
  final String subtotal;
  final String discount;
  final String shipping;
  final String tax;
  final String total;
}
