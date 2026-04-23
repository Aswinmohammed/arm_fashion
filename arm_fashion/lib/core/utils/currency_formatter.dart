class CurrencyFormatter {
  const CurrencyFormatter._();

  static String lkr(double value) => _format(value, symbol: 'Rs. ');

  static String usd(double value) => lkr(value);

  static String gbp(double value) => _format(value, symbol: '£');

  static String _format(double value, {required String symbol}) {
    final fixed = value.toStringAsFixed(2);
    final parts = fixed.split('.');
    final whole = parts[0];
    final decimal = parts[1];
    final buffer = StringBuffer();

    for (int i = 0; i < whole.length; i++) {
      final reverseIndex = whole.length - i;
      buffer.write(whole[i]);
      if (reverseIndex > 1 && reverseIndex % 3 == 1) {
        buffer.write(',');
      }
    }

    return '$symbol${buffer.toString()}.$decimal';
  }
}
