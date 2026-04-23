class CatalogLabels {
  const CatalogLabels._();

  static const List<String> audienceValues = [
    'Men',
    'Women',
    'Shoes',
    'Accessories',
  ];

  static String audience(String value) {
    return switch (value) {
      'Men' => "Men's Wear",
      'Women' => "Women's Wear",
      'Shoes' => 'Footwear',
      'Accessories' => 'Accessories',
      _ => value,
    };
  }
}
