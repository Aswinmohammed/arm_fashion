import 'package:flutter/material.dart';

class AppProduct {
  const AppProduct({
    required this.id,
    required this.name,
    required this.audienceCategory,
    required this.productType,
    required this.price,
    required this.description,
    required this.imagePath,
    required this.cardBackgroundColor,
    required this.cardIcon,
    required this.cardIconColor,
    required this.heroGradient,
    required this.heroIcon,
    required this.heroIconColor,
    required this.availableColors,
    required this.availableSizes,
    this.subtitle = 'NEW ARRIVAL',
    this.badge,
  });

  final String id;
  final String name;
  final String audienceCategory;
  final String productType;
  final double price;
  final String description;
  final String imagePath;
  final Color cardBackgroundColor;
  final IconData cardIcon;
  final Color cardIconColor;
  final Gradient heroGradient;
  final IconData heroIcon;
  final Color heroIconColor;
  final List<Color> availableColors;
  final List<String> availableSizes;
  final String subtitle;
  final String? badge;
}

class CartLine {
  const CartLine({
    required this.productId,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColorIndex,
  });

  final String productId;
  final int quantity;
  final String selectedSize;
  final int selectedColorIndex;

  String get id => '$productId|$selectedSize|$selectedColorIndex';

  CartLine copyWith({
    int? quantity,
    String? selectedSize,
    int? selectedColorIndex,
  }) {
    return CartLine(
      productId: productId,
      quantity: quantity ?? this.quantity,
      selectedSize: selectedSize ?? this.selectedSize,
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
    );
  }
}

class _SearchMatch {
  const _SearchMatch({
    required this.product,
    required this.score,
  });

  final AppProduct product;
  final int score;
}

class OrderLine {
  const OrderLine({
    required this.productId,
    required this.name,
    required this.productType,
    required this.unitPrice,
    required this.quantity,
    required this.selectedSize,
    required this.selectedColorIndex,
  });

  final String productId;
  final String name;
  final String productType;
  final double unitPrice;
  final int quantity;
  final String selectedSize;
  final int selectedColorIndex;
}

class OrderRecord {
  const OrderRecord({
    required this.id,
    required this.dateLabel,
    required this.status,
    required this.items,
    required this.shippingName,
    required this.shippingPhone,
    required this.shippingAddress,
    required this.city,
    required this.postalCode,
    required this.paymentMethod,
    required this.estimatedDeliveryLabel,
    required this.deliveryMethod,
    required this.membershipStatus,
    required this.pointsEarned,
    required this.shippingCost,
    required this.tax,
    required this.discount,
  });

  final String id;
  final String dateLabel;
  final String status;
  final List<OrderLine> items;
  final String shippingName;
  final String shippingPhone;
  final String shippingAddress;
  final String city;
  final String postalCode;
  final String paymentMethod;
  final String estimatedDeliveryLabel;
  final String deliveryMethod;
  final String membershipStatus;
  final int pointsEarned;
  final double shippingCost;
  final double tax;
  final double discount;

  double get subtotal => items.fold(
        0,
        (sum, item) => sum + (item.unitPrice * item.quantity),
      );

  double get total => subtotal + shippingCost + tax - discount;
}

class AddressBookEntry {
  const AddressBookEntry({
    required this.id,
    required this.label,
    required this.recipientName,
    required this.phoneNumber,
    required this.addressLine,
    required this.city,
    required this.postalCode,
    required this.isDefault,
  });

  final String id;
  final String label;
  final String recipientName;
  final String phoneNumber;
  final String addressLine;
  final String city;
  final String postalCode;
  final bool isDefault;

  AddressBookEntry copyWith({
    String? label,
    String? recipientName,
    String? phoneNumber,
    String? addressLine,
    String? city,
    String? postalCode,
    bool? isDefault,
  }) {
    return AddressBookEntry(
      id: id,
      label: label ?? this.label,
      recipientName: recipientName ?? this.recipientName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      addressLine: addressLine ?? this.addressLine,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class PaymentMethodRecord {
  const PaymentMethodRecord({
    required this.id,
    required this.brand,
    required this.maskedNumber,
    required this.holderName,
    required this.expiry,
    required this.isDefault,
  });

  final String id;
  final String brand;
  final String maskedNumber;
  final String holderName;
  final String expiry;
  final bool isDefault;

  PaymentMethodRecord copyWith({
    String? brand,
    String? maskedNumber,
    String? holderName,
    String? expiry,
    bool? isDefault,
  }) {
    return PaymentMethodRecord(
      id: id,
      brand: brand ?? this.brand,
      maskedNumber: maskedNumber ?? this.maskedNumber,
      holderName: holderName ?? this.holderName,
      expiry: expiry ?? this.expiry,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class AppStore extends ChangeNotifier {
  AppStore()
      : _products = _buildProducts(),
        _addresses = _buildSeedAddresses(),
        _paymentMethods = _buildSeedPaymentMethods(),
        _wishlistIds = {
          'structured-wool-overcoat',
          'asymmetric-silk-blouse',
          'square-toe-leather-boot',
        },
        _cart = [
          const CartLine(
            productId: 'tailored-wool-blazer',
            quantity: 1,
            selectedSize: '42',
            selectedColorIndex: 0,
          ),
          const CartLine(
            productId: 'atelier-jersey-tee',
            quantity: 2,
            selectedSize: 'M',
            selectedColorIndex: 0,
          ),
        ],
        _orders = [] {
    _orders.addAll(_buildSeedOrders());
  }

  final List<AppProduct> _products;
  final List<AddressBookEntry> _addresses;
  final List<PaymentMethodRecord> _paymentMethods;
  final Set<String> _wishlistIds;
  final List<CartLine> _cart;
  final List<OrderRecord> _orders;

  String _selectedProductId = 'structured-wool-overcoat';
  String? _selectedOrderId;
  String _catalogAudience = 'Men';
  String _userName = 'MOHAMMED ASWIN';
  String _userEmail = 'aswinmohammed@gmail.com';
  String? _activePromoCode;
  bool _orderUpdatesEnabled = true;
  bool _promotionsEnabled = true;
  bool _biometricLoginEnabled = false;
  bool _wishlistRestockAlertsEnabled = true;

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get catalogAudience => _catalogAudience;
  List<AppProduct> get products => List.unmodifiable(_products);
  List<OrderRecord> get orders => List.unmodifiable(_orders);
  List<CartLine> get cart => List.unmodifiable(_cart);
  List<AddressBookEntry> get addresses => List.unmodifiable(_addresses);
  List<PaymentMethodRecord> get paymentMethods =>
      List.unmodifiable(_paymentMethods);
  bool get isLoggedIn => _userEmail.isNotEmpty;
  AddressBookEntry get defaultAddress => _addresses.firstWhere(
        (address) => address.isDefault,
        orElse: () => _addresses.first,
      );
  PaymentMethodRecord get defaultPaymentMethod => _paymentMethods.firstWhere(
        (method) => method.isDefault,
        orElse: () => _paymentMethods.first,
      );
  String get defaultPaymentSummary =>
      '${defaultPaymentMethod.brand} ending in ${defaultPaymentMethod.maskedNumber.substring(defaultPaymentMethod.maskedNumber.length - 4)}';
  String? get activePromoCode => _activePromoCode;
  bool get orderUpdatesEnabled => _orderUpdatesEnabled;
  bool get promotionsEnabled => _promotionsEnabled;
  bool get biometricLoginEnabled => _biometricLoginEnabled;
  bool get wishlistRestockAlertsEnabled => _wishlistRestockAlertsEnabled;

  AppProduct get selectedProduct => productById(_selectedProductId);

  OrderRecord get selectedOrder {
    if (_selectedOrderId != null) {
      return _orders.firstWhere(
        (order) => order.id == _selectedOrderId,
        orElse: () => _orders.first,
      );
    }
    return _orders.first;
  }

  OrderRecord get latestOrder => _orders.first;

  double get cartSubtotal => _cart.fold(
        0,
        (sum, line) =>
            sum + (productById(line.productId).price * line.quantity),
      );

  double get cartShipping => _cart.isEmpty ? 0 : 0;

  double get cartTax => _cart.isEmpty
      ? 0
      : double.parse((cartSubtotal * 0.085).toStringAsFixed(2));

  double get cartDiscount {
    if (_cart.isEmpty) {
      return 0;
    }

    final rate = switch (_activePromoCode) {
      'WELCOME10' => 0.10,
      'ARMVIP15' => 0.15,
      'FESTIVE12' => 0.12,
      _ => 0.0,
    };

    return double.parse((cartSubtotal * rate).toStringAsFixed(2));
  }

  double get cartTotal => cartSubtotal + cartShipping + cartTax - cartDiscount;

  int get cartItemCount => _cart.fold(0, (sum, line) => sum + line.quantity);

  List<AppProduct> get wishlistProducts => _products
      .where((product) => _wishlistIds.contains(product.id))
      .toList(growable: false);

  AppProduct productById(String id) =>
      _products.firstWhere((item) => item.id == id);

  List<AppProduct> productsForAudience(String audience) {
    if (audience.toLowerCase() == 'all') {
      return products;
    }

    return _products
        .where((product) =>
            product.audienceCategory.toLowerCase() == audience.toLowerCase())
        .toList(growable: false);
  }

  List<AppProduct> searchProducts(
    String query, {
    String audience = 'All',
  }) {
    final source = audience.toLowerCase() == 'all'
        ? _products
        : productsForAudience(audience);
    final normalized = query.trim().toLowerCase();
    if (normalized.isEmpty) {
      final curated = [...source]
        ..sort((a, b) {
          final badgeCompare = _browseRank(b).compareTo(_browseRank(a));
          if (badgeCompare != 0) {
            return badgeCompare;
          }

          final priceCompare = b.price.compareTo(a.price);
          if (priceCompare != 0) {
            return priceCompare;
          }

          return a.name.compareTo(b.name);
        });
      return curated;
    }

    final ranked = source
        .map(
          (product) => _SearchMatch(
            product: product,
            score: _scoreSearchMatch(product, normalized),
          ),
        )
        .where((match) => match.score > 0)
        .toList(growable: false)
      ..sort((a, b) {
        final scoreCompare = b.score.compareTo(a.score);
        if (scoreCompare != 0) {
          return scoreCompare;
        }

        final badgeCompare = _browseRank(b.product).compareTo(
          _browseRank(a.product),
        );
        if (badgeCompare != 0) {
          return badgeCompare;
        }

        return a.product.name.compareTo(b.product.name);
      });

    return ranked.map((match) => match.product).toList(growable: false);
  }

  List<AppProduct> relatedProductsFor(String productId) {
    final product = productById(productId);
    return _products
        .where((item) =>
            item.id != productId &&
            (item.audienceCategory == product.audienceCategory ||
                item.productType == product.productType))
        .take(2)
        .toList(growable: false);
  }

  bool isInWishlist(String productId) => _wishlistIds.contains(productId);

  void toggleWishlist(String productId) {
    if (_wishlistIds.contains(productId)) {
      _wishlistIds.remove(productId);
    } else {
      _wishlistIds.add(productId);
    }
    notifyListeners();
  }

  void selectProduct(String productId) {
    _selectedProductId = productId;
    notifyListeners();
  }

  void setCatalogAudience(String audience) {
    _catalogAudience = audience;
    notifyListeners();
  }

  void selectOrder(String orderId) {
    _selectedOrderId = orderId;
    notifyListeners();
  }

  void addProductToCart(
    String productId, {
    String? selectedSize,
    int selectedColorIndex = 0,
    int quantity = 1,
  }) {
    final product = productById(productId);
    final resolvedSize = selectedSize ?? product.availableSizes.first;
    final existingIndex = _cart.indexWhere(
      (line) =>
          line.productId == productId &&
          line.selectedSize == resolvedSize &&
          line.selectedColorIndex == selectedColorIndex,
    );

    if (existingIndex >= 0) {
      final existing = _cart[existingIndex];
      _cart[existingIndex] = existing.copyWith(
        quantity: existing.quantity + quantity,
      );
    } else {
      _cart.add(
        CartLine(
          productId: productId,
          quantity: quantity,
          selectedSize: resolvedSize,
          selectedColorIndex: selectedColorIndex,
        ),
      );
    }
    notifyListeners();
  }

  void updateCartQuantity(String lineId, int delta) {
    final index = _cart.indexWhere((line) => line.id == lineId);
    if (index == -1) {
      return;
    }

    final updatedQuantity = _cart[index].quantity + delta;
    if (updatedQuantity <= 0) {
      _cart.removeAt(index);
    } else {
      _cart[index] = _cart[index].copyWith(quantity: updatedQuantity);
    }
    notifyListeners();
  }

  void removeCartLine(String lineId) {
    _cart.removeWhere((line) => line.id == lineId);
    if (_cart.isEmpty) {
      _activePromoCode = null;
    }
    notifyListeners();
  }

  void moveWishlistToCart() {
    final wishlistIds = _wishlistIds.toList(growable: false);
    for (final productId in wishlistIds) {
      addProductToCart(productId);
    }
    _wishlistIds.clear();
    notifyListeners();
  }

  void reorder(String orderId) {
    final order = _orders.firstWhere((item) => item.id == orderId);
    for (final line in order.items) {
      addProductToCart(
        line.productId,
        selectedSize: line.selectedSize,
        selectedColorIndex: line.selectedColorIndex,
        quantity: line.quantity,
      );
    }
  }

  void setDefaultAddress(String addressId) {
    for (int i = 0; i < _addresses.length; i++) {
      final entry = _addresses[i];
      _addresses[i] = entry.copyWith(isDefault: entry.id == addressId);
    }
    notifyListeners();
  }

  void setDefaultPaymentMethod(String paymentMethodId) {
    for (int i = 0; i < _paymentMethods.length; i++) {
      final method = _paymentMethods[i];
      _paymentMethods[i] =
          method.copyWith(isDefault: method.id == paymentMethodId);
    }
    notifyListeners();
  }

  void setOrderUpdatesEnabled(bool value) {
    _orderUpdatesEnabled = value;
    notifyListeners();
  }

  void setPromotionsEnabled(bool value) {
    _promotionsEnabled = value;
    notifyListeners();
  }

  void setBiometricLoginEnabled(bool value) {
    _biometricLoginEnabled = value;
    notifyListeners();
  }

  void setWishlistRestockAlertsEnabled(bool value) {
    _wishlistRestockAlertsEnabled = value;
    notifyListeners();
  }

  String applyPromoCode(String code) {
    final normalized = code.trim().toUpperCase();
    if (_cart.isEmpty) {
      return 'Add products to your bag before applying a promo code.';
    }

    if (normalized == 'WELCOME10' ||
        normalized == 'ARMVIP15' ||
        normalized == 'FESTIVE12') {
      _activePromoCode = normalized;
      notifyListeners();
      return '$normalized applied successfully.';
    }

    return 'Promo code not recognized.';
  }

  void clearPromoCode() {
    _activePromoCode = null;
    notifyListeners();
  }

  bool placeOrder({
    required String fullName,
    required String phone,
    required String address,
    required String city,
    required String postalCode,
  }) {
    if (_cart.isEmpty) {
      return false;
    }

    final order = OrderRecord(
      id: _buildOrderId(),
      dateLabel: _currentDateLabel(),
      status: 'PROCESSING',
      items: _cart
          .map(
            (line) => OrderLine(
              productId: line.productId,
              name: productById(line.productId).name,
              productType: productById(line.productId).productType,
              unitPrice: productById(line.productId).price,
              quantity: line.quantity,
              selectedSize: line.selectedSize,
              selectedColorIndex: line.selectedColorIndex,
            ),
          )
          .toList(growable: false),
      shippingName: fullName,
      shippingPhone: phone,
      shippingAddress: address,
      city: city,
      postalCode: postalCode,
      paymentMethod: defaultPaymentSummary,
      estimatedDeliveryLabel: _futureDateLabel(4),
      deliveryMethod: 'Islandwide Courier',
      membershipStatus: 'GOLD MEMBER',
      pointsEarned: 450,
      shippingCost: cartShipping,
      tax: cartTax,
      discount: cartDiscount,
    );

    _orders.insert(0, order);
    _selectedOrderId = order.id;
    _cart.clear();
    _activePromoCode = null;
    notifyListeners();
    return true;
  }

  void logIn({
    required String email,
  }) {
    _userEmail = email.trim().toUpperCase();
    if (_userName.trim().isEmpty) {
      _userName = _deriveNameFromEmail(email);
    }
    notifyListeners();
  }

  void register({
    required String fullName,
    required String email,
  }) {
    _userName = fullName.trim().toUpperCase();
    _userEmail = email.trim().toUpperCase();
    notifyListeners();
  }

  void logout() {
    _userName = 'ARM CUSTOMER';
    _userEmail = '';
    notifyListeners();
  }

  String _deriveNameFromEmail(String email) {
    final base = email.split('@').first.replaceAll('.', ' ').trim();
    if (base.isEmpty) {
      return 'ARM CUSTOMER';
    }
    return base.toUpperCase();
  }

  String _buildOrderId() {
    final seed = DateTime.now().millisecondsSinceEpoch.toString();
    return '#ARM-${seed.substring(seed.length - 6)}-LX';
  }

  String _currentDateLabel() {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final now = DateTime.now();
    return '${months[now.month - 1]} ${now.day}, ${now.year}';
  }

  String _futureDateLabel(int days) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final date = DateTime.now().add(Duration(days: days));
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static int _browseRank(AppProduct product) {
    var score = 0;

    if ((product.badge ?? '').toUpperCase() == 'NEW' ||
        product.subtitle.toUpperCase().contains('NEW')) {
      score += 40;
    }

    if (_isMonochromePalette(product)) {
      score += 12;
    }

    if (_containsAnySearchTerm(product, ['signature', 'statement', 'festive'])) {
      score += 8;
    }

    if (product.price >= 8000) {
      score += 6;
    }

    return score;
  }

  static int _scoreSearchMatch(AppProduct product, String query) {
    final normalizedQuery = _normalizeSearchText(query);
    if (normalizedQuery.isEmpty) {
      return _browseRank(product);
    }

    final name = _normalizeSearchText(product.name);
    final productType = _normalizeSearchText(product.productType);
    final audience = _normalizeSearchText(product.audienceCategory);
    final description = _normalizeSearchText(product.description);
    final identifier = _normalizeSearchText(product.id.replaceAll('-', ' '));
    final subtitle = _normalizeSearchText('${product.subtitle} ${product.badge ?? ''}');
    final tags = _derivedSearchTags(product);
    final tokens = _expandedSearchTokens(normalizedQuery);

    var score = 0;

    if (name == normalizedQuery) {
      score += 180;
    } else if (name.contains(normalizedQuery)) {
      score += 120;
    }

    if (productType.contains(normalizedQuery)) {
      score += 72;
    }

    if (description.contains(normalizedQuery)) {
      score += 40;
    }

    if (subtitle.contains(normalizedQuery)) {
      score += 26;
    }

    for (final token in tokens) {
      if (token.isEmpty) {
        continue;
      }

      if (name.startsWith(token)) {
        score += 54;
      } else if (name.contains(token)) {
        score += 34;
      }

      if (productType.contains(token)) {
        score += 24;
      }

      if (audience.contains(token)) {
        score += 18;
      }

      if (description.contains(token)) {
        score += 14;
      }

      if (identifier.contains(token)) {
        score += 12;
      }

      if (subtitle.contains(token)) {
        score += 18;
      }

      if (tags.contains(token)) {
        score += 30;
      } else if (tags.any((tag) => tag.contains(token))) {
        score += 10;
      }
    }

    if (normalizedQuery.contains('monochrome') && _isMonochromePalette(product)) {
      score += 80;
    }

    if (normalizedQuery.contains('linen') &&
        _containsAnySearchTerm(product, ['linen', 'lawn', 'cotton'])) {
      score += 55;
    }

    if (normalizedQuery.contains('editorial') &&
        _containsAnySearchTerm(product, ['signature', 'statement', 'festive', 'bridal'])) {
      score += 52;
    }

    if (normalizedQuery.contains('new') &&
        ((product.badge ?? '').toUpperCase() == 'NEW' ||
            product.subtitle.toUpperCase().contains('NEW'))) {
      score += 44;
    }

    return score;
  }

  static Set<String> _expandedSearchTokens(String query) {
    final tokens = {..._searchTokens(query)};

    for (final entry in _searchAliasGroups.entries) {
      final collectionName = entry.key;
      final aliases = entry.value;

      final matchesCollection = query.contains(collectionName) ||
          aliases.any((alias) => query.contains(alias));

      if (matchesCollection) {
        tokens.addAll(_searchTokens(collectionName));
        for (final alias in aliases) {
          tokens.addAll(_searchTokens(alias));
        }
      }
    }

    return tokens;
  }

  static Set<String> _derivedSearchTags(AppProduct product) {
    final tags = <String>{
      ..._searchTokens(product.name),
      ..._searchTokens(product.productType),
      ..._searchTokens(product.audienceCategory),
      ..._searchTokens(product.description),
      ..._searchTokens(product.id.replaceAll('-', ' ')),
    };

    switch (product.audienceCategory) {
      case 'Men':
        tags.addAll(['menswear', 'men']);
        break;
      case 'Women':
        tags.addAll(['womenswear', 'women']);
        break;
      case 'Shoes':
        tags.addAll(['shoes', 'footwear']);
        break;
      case 'Accessories':
        tags.addAll(['accessories', 'bags', 'finishing']);
        break;
    }

    switch (product.productType) {
      case 'OUTERWEAR':
        tags.addAll(['jacket', 'coat', 'layering']);
        break;
      case 'KNITWEAR':
        tags.addAll(['knit', 'softwear', 'cardigan']);
        break;
      case 'SHIRTS':
        tags.addAll(['shirt', 'smart casual']);
        break;
      case 'TOPS':
        tags.addAll(['top', 'everyday']);
        break;
      case 'TROUSERS':
      case 'BOTTOMS':
        tags.addAll(['trouser', 'pants', 'bottoms']);
        break;
      case 'DRESSES':
        tags.addAll(['dress', 'occasionwear']);
        break;
      case 'FOOTWEAR':
        tags.addAll(['shoe', 'sandals', 'heels', 'sneakers']);
        break;
      case 'ACCESSORIES':
        tags.addAll(['bags', 'belts', 'jewellery', 'watch', 'scarf']);
        break;
    }

    if ((product.badge ?? '').toUpperCase() == 'NEW' ||
        product.subtitle.toUpperCase().contains('NEW')) {
      tags.addAll(['new', 'new in', 'latest']);
    }

    if (_isMonochromePalette(product)) {
      tags.addAll(['monochrome', 'neutral', 'minimal']);
    }

    if (_containsAnySearchTerm(product, ['linen', 'lawn', 'cotton'])) {
      tags.addAll(['linen', 'linen blends', 'breathable', 'lightweight']);
    }

    if (_containsAnySearchTerm(product, ['signature', 'statement', 'festive'])) {
      tags.addAll(['editorial', 'editorial picks', 'elevated']);
    }

    if (_containsAnySearchTerm(product, ['bridal', 'evening', 'occasion'])) {
      tags.addAll(['occasion', 'party', 'dressy']);
    }

    if (_containsAnySearchTerm(product, ['travel', 'resort', 'weekender'])) {
      tags.addAll(['travel', 'holiday', 'resort']);
    }

    return tags;
  }

  static bool _containsAnySearchTerm(AppProduct product, List<String> terms) {
    final source = _normalizeSearchText(
      '${product.name} ${product.description} ${product.id}',
    );
    return terms.any(source.contains);
  }

  static bool _isMonochromePalette(AppProduct product) {
    if (product.availableColors.isEmpty) {
      return false;
    }

    final isNeutralPalette = product.availableColors.every((color) {
      final hsl = HSLColor.fromColor(color);
      return hsl.saturation <= 0.18;
    });

    return isNeutralPalette ||
        product.name.contains('MINIMAL') ||
        product.description.contains('clean') ||
        product.description.contains('tailored');
  }

  static Set<String> _searchTokens(String input) {
    return _normalizeSearchText(input)
        .split(' ')
        .where((token) => token.isNotEmpty && token.length > 1)
        .toSet();
  }

  static String _normalizeSearchText(String input) {
    return input.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), ' ').trim();
  }

  static const Map<String, List<String>> _searchAliasGroups = {
    'monochrome': ['minimal', 'neutral', 'black', 'white', 'charcoal', 'stone'],
    'linen blends': ['linen', 'lawn', 'cotton', 'airy', 'breathable'],
    'new in': ['new', 'latest', 'fresh'],
    'editorial picks': ['editorial', 'signature', 'statement', 'occasion', 'festive'],
    'office wear': ['formal', 'tailored', 'executive'],
  };

  static List<OrderRecord> _buildSeedOrders() {
    return [
      const OrderRecord(
        id: '#ARM-293847-XC',
        dateLabel: 'March 12, 2024',
        status: 'PROCESSING',
        items: [
          OrderLine(
            productId: 'structured-wool-overcoat',
            name: 'KANDY HERITAGE LINEN BLAZER',
            productType: 'OUTERWEAR',
            unitPrice: 14950,
            quantity: 1,
            selectedSize: 'L',
            selectedColorIndex: 0,
          ),
        ],
        shippingName: 'Mohammed Aswin',
        shippingPhone: '+94 77 8514 532',
        shippingAddress: 'No. 30 Ampara Road',
        city: 'Sammanthurai',
        postalCode: '32200',
        paymentMethod: 'Commercial Bank Visa ending in 4492',
        estimatedDeliveryLabel: 'March 16, 2024',
        deliveryMethod: 'Islandwide Courier',
        membershipStatus: 'GOLD MEMBER',
        pointsEarned: 150,
        shippingCost: 0,
        tax: 1196,
        discount: 0,
      ),
      const OrderRecord(
        id: '#ARM-293712-XC',
        dateLabel: 'February 28, 2024',
        status: 'DELIVERED',
        items: [
          OrderLine(
            productId: 'square-toe-leather-boot',
            name: 'CEYLON LEATHER OFFICE SHOE',
            productType: 'FOOTWEAR',
            unitPrice: 10950,
            quantity: 1,
            selectedSize: '42',
            selectedColorIndex: 0,
          ),
          OrderLine(
            productId: 'mini-tote-bag',
            name: 'MINI BATIK HAND CARRY BAG',
            productType: 'ACCESSORIES',
            unitPrice: 5450,
            quantity: 1,
            selectedSize: 'ONE SIZE',
            selectedColorIndex: 0,
          ),
        ],
        shippingName: 'Mohammed Aswin',
        shippingPhone: '+94 77 456 7890',
        shippingAddress: 'No. 18 Station Road',
        city: 'Dehiwala',
        postalCode: '10350',
        paymentMethod: 'Commercial Bank Visa ending in 4492',
        estimatedDeliveryLabel: 'March 02, 2024',
        deliveryMethod: 'Islandwide Courier',
        membershipStatus: 'GOLD MEMBER',
        pointsEarned: 165,
        shippingCost: 0,
        tax: 1312,
        discount: 0,
      ),
      const OrderRecord(
        id: '#ARM-293501-XC',
        dateLabel: 'January 15, 2024',
        status: 'DELIVERED',
        items: [
          OrderLine(
            productId: 'pleated-silk-trousers',
            name: 'SOFT FLOW PALAZZO TROUSER',
            productType: 'TROUSERS',
            unitPrice: 5950,
            quantity: 1,
            selectedSize: '32',
            selectedColorIndex: 0,
          ),
        ],
        shippingName: 'Mohammed Aswin',
        shippingPhone: '+94 71 234 5678',
        shippingAddress: 'No. 42 Kandy Road',
        city: 'Kandy',
        postalCode: '20000',
        paymentMethod: 'Commercial Bank Visa ending in 4492',
        estimatedDeliveryLabel: 'January 19, 2024',
        deliveryMethod: 'Islandwide Courier',
        membershipStatus: 'GOLD MEMBER',
        pointsEarned: 60,
        shippingCost: 0,
        tax: 476,
        discount: 0,
      ),
    ];
  }

  static List<AddressBookEntry> _buildSeedAddresses() {
    return const [
      AddressBookEntry(
        id: 'home',
        label: 'HOME',
        recipientName: 'MOHAMMED ASWIN',
        phoneNumber: '+94 77 123 4567',
        addressLine: 'No. 25 Galle Road',
        city: 'Colombo 03',
        postalCode: '00300',
        isDefault: true,
      ),
      AddressBookEntry(
        id: 'office',
        label: 'OFFICE',
        recipientName: 'MOHAMMED ASWIN',
        phoneNumber: '+94 77 765 4321',
        addressLine: 'No. 88 Flower Road',
        city: 'Colombo 07',
        postalCode: '00700',
        isDefault: false,
      ),
      AddressBookEntry(
        id: 'family',
        label: 'KANDY',
        recipientName: 'FATHIMA RISNA',
        phoneNumber: '+94 81 222 3344',
        addressLine: 'No. 14 Hill Street',
        city: 'Kandy',
        postalCode: '20000',
        isDefault: false,
      ),
    ];
  }

  static List<PaymentMethodRecord> _buildSeedPaymentMethods() {
    return const [
      PaymentMethodRecord(
        id: 'visa-commercial',
        brand: 'VISA',
        maskedNumber: '**** 4492',
        holderName: 'MOHAMMED ASWIN',
        expiry: '08/28',
        isDefault: true,
      ),
      PaymentMethodRecord(
        id: 'master-sampath',
        brand: 'MASTERCARD',
        maskedNumber: '**** 1186',
        holderName: 'MOHAMMED ASWIN',
        expiry: '11/27',
        isDefault: false,
      ),
      PaymentMethodRecord(
        id: 'amex-hsbc',
        brand: 'AMEX',
        maskedNumber: '**** 9004',
        holderName: 'MOHAMMED ASWIN',
        expiry: '03/29',
        isDefault: false,
      ),
    ];
  }

  static List<AppProduct> _buildProducts() {
    return const [
      AppProduct(
        id: 'structured-wool-overcoat',
        name: 'KANDY HERITAGE LINEN BLAZER',
        audienceCategory: 'Men',
        productType: 'OUTERWEAR',
        price: 14950,
        description:
            'A premium linen blazer tailored for warm-weather dressing, combining sharp structure with breathable comfort for workdays and special occasions.',
        imagePath: 'images/products/men/structured-wool-overcoat.png',
        cardBackgroundColor: Color(0xFFE7E4DE),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF444444),
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
        badge: 'NEW',
      ),
      AppProduct(
        id: 'tailored-wool-blazer',
        name: 'COLOMBO CITY FORMAL BLAZER',
        audienceCategory: 'Men',
        productType: 'OUTERWEAR',
        price: 11950,
        description:
            'A clean formal blazer with a polished finish, made for office wear, dinner outings, and smart festive styling.',
        imagePath: 'images/products/men/tailored-wool-blazer.png',
        cardBackgroundColor: Color(0xFFEDE9E2),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF1A1A1A),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF7E7C79),
            Color(0xFFE8E3DB),
          ],
        ),
        heroIcon: Icons.accessibility_new,
        heroIconColor: Color(0xFF222222),
        availableColors: [
          Color(0xFF111111),
          Color(0xFF6D7277),
        ],
        availableSizes: ['40', '42', '44', '46'],
      ),
      AppProduct(
        id: 'atelier-jersey-tee',
        name: 'EVERYDAY COTTON COMFORT TEE',
        audienceCategory: 'Women',
        productType: 'TOPS',
        price: 3250,
        description:
            'A soft cotton tee designed for Sri Lankan everyday wear, with an easy relaxed fit that works from casual errands to weekend outings.',
        imagePath: 'images/products/women/atelier-jersey-tee.png',
        cardBackgroundColor: Color(0xFFF7F4EF),
        cardIcon: Icons.dry_cleaning_outlined,
        cardIconColor: Color(0xFFD8D8D8),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7F3EB),
            Color(0xFFE6E0D5),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFFE5DDD1),
        availableColors: [
          Color(0xFFF4F4F2),
          Color(0xFF1A1A1A),
        ],
        availableSizes: ['XS', 'S', 'M', 'L'],
      ),
      AppProduct(
        id: 'asymmetric-silk-blouse',
        name: 'CEYLON BATIK OFFICE BLOUSE',
        audienceCategory: 'Women',
        productType: 'BLOUSE',
        price: 5750,
        description:
            'A graceful blouse finished with batik-inspired detailing and a fluid drape for elegant office and evening styling.',
        imagePath: 'images/products/women/asymmetric-silk-blouse.png',
        cardBackgroundColor: Color(0xFFF1EFED),
        cardIcon: Icons.dry_cleaning_outlined,
        cardIconColor: Color(0xFF64615F),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7F6F3),
            Color(0xFFDAD7D1),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFFCBC5BC),
        availableColors: [
          Color(0xFFF8F5F0),
          Color(0xFFBEA994),
        ],
        availableSizes: ['XS', 'S', 'M', 'L'],
      ),
      AppProduct(
        id: 'ceylon-batik-maxi-dress',
        name: 'KANDYAN BATIK MAXI DRESS',
        audienceCategory: 'Women',
        productType: 'DRESSES',
        price: 9950,
        description:
            'A flowing batik-inspired maxi dress designed for festive gatherings, evening outings, and polished daywear with a local boutique touch.',
        imagePath: 'images/products/women/ceylon-batik-maxi-dress.png',
        cardBackgroundColor: Color(0xFFF1E6DA),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF8B5E3C),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5EDE3),
            Color(0xFFD2B49A),
          ],
        ),
        heroIcon: Icons.accessibility_new,
        heroIconColor: Color(0xFF8A6244),
        availableColors: [
          Color(0xFFC48D63),
          Color(0xFF5F3520),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
        badge: 'NEW',
      ),
      AppProduct(
        id: 'kurti-style-tunic',
        name: 'COLOMBO KURTI TUNIC',
        audienceCategory: 'Women',
        productType: 'TOPS',
        price: 4650,
        description:
            'A lightweight kurti-style tunic tailored for everyday elegance, easy movement, and comfortable styling in warm weather.',
        imagePath: 'images/products/women/kurti-style-tunic.png',
        cardBackgroundColor: Color(0xFFEDE7DF),
        cardIcon: Icons.dry_cleaning_outlined,
        cardIconColor: Color(0xFF6D5444),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF4EEE8),
            Color(0xFFCDB8A6),
          ],
        ),
        heroIcon: Icons.checkroom,
        heroIconColor: Color(0xFF755A47),
        availableColors: [
          Color(0xFFE5D4C7),
          Color(0xFF6B4A38),
        ],
        availableSizes: ['S', 'M', 'L'],
      ),
      AppProduct(
        id: 'square-toe-leather-boot',
        name: 'CEYLON LEATHER OFFICE SHOE',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 10950,
        description:
            'A polished leather shoe built for all-day comfort, ideal for office dressing, formal events, and smart casual looks.',
        imagePath: 'images/products/shoes/square-toe-leather-boot.png',
        cardBackgroundColor: Color(0xFF161616),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFFE0D1BC),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF242424),
            Color(0xFF77736C),
          ],
        ),
        heroIcon: Icons.hiking_outlined,
        heroIconColor: Color(0xFFE0D1BC),
        availableColors: [
          Color(0xFF1F1A17),
          Color(0xFF6D4C3B),
        ],
        availableSizes: ['40', '41', '42', '43'],
      ),
      AppProduct(
        id: 'white-street-sneaker',
        name: 'URBAN WHITE STREET SNEAKER',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 8950,
        description:
            'A clean white sneaker made for daily wear, campus outfits, and modern casual looks with lightweight comfort.',
        imagePath: 'images/products/shoes/white-street-sneaker.png',
        cardBackgroundColor: Color(0xFFF1F1EF),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFF8F8F8B),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF8F8F6),
            Color(0xFFD4D4CE),
          ],
        ),
        heroIcon: Icons.hiking_outlined,
        heroIconColor: Color(0xFF8B8B87),
        availableColors: [
          Color(0xFFF4F4F2),
          Color(0xFFB0B0AE),
        ],
        availableSizes: ['38', '39', '40', '41', '42'],
      ),
      AppProduct(
        id: 'ladies-block-heel',
        name: 'ELEGANCE BLOCK HEEL',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 8450,
        description:
            'A versatile block heel suited for office dressing, functions, and elevated everyday outfits with stable all-day wear.',
        imagePath: 'images/products/shoes/ladies-block-heel.png',
        cardBackgroundColor: Color(0xFFE7D8CF),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFF6A4738),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF1E3DA),
            Color(0xFFC39B85),
          ],
        ),
        heroIcon: Icons.accessibility_new_outlined,
        heroIconColor: Color(0xFF6C4939),
        availableColors: [
          Color(0xFF8B5E49),
          Color(0xFFE5D5C6),
        ],
        availableSizes: ['36', '37', '38', '39', '40'],
      ),
      AppProduct(
        id: 'everyday-comfort-sandal',
        name: 'DAILY COMFORT WALK SANDAL',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 4950,
        description:
            'A comfortable sandal built for errands, travel, and casual dressing in tropical weather with easy everyday wear.',
        imagePath: 'images/products/shoes/everyday-comfort-sandal.png',
        cardBackgroundColor: Color(0xFFE7E1D7),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFF7A6652),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF1ECE4),
            Color(0xFFCDBAA4),
          ],
        ),
        heroIcon: Icons.hiking_outlined,
        heroIconColor: Color(0xFF7F6A56),
        availableColors: [
          Color(0xFFB58F6D),
          Color(0xFF3B2A22),
        ],
        availableSizes: ['36', '37', '38', '39', '40', '41'],
      ),
      AppProduct(
        id: 'pleated-silk-trousers',
        name: 'SOFT FLOW PALAZZO TROUSER',
        audienceCategory: 'Women',
        productType: 'TROUSERS',
        price: 5950,
        description:
            'A flattering palazzo trouser with a soft flow and comfortable waistband, perfect for occasion wear and elevated daily outfits.',
        imagePath: 'images/products/women/pleated-silk-trousers.png',
        cardBackgroundColor: Color(0xFFF3F1EC),
        cardIcon: Icons.accessibility_new_outlined,
        cardIconColor: Color(0xFFC9C3BA),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7F5F0),
            Color(0xFFD4CDC2),
          ],
        ),
        heroIcon: Icons.accessibility_new_outlined,
        heroIconColor: Color(0xFFC9C3BA),
        availableColors: [
          Color(0xFFF6F0E7),
          Color(0xFF1B1B1B),
        ],
        availableSizes: ['30', '32', '34', '36'],
      ),
      AppProduct(
        id: 'cashmere-mock-neck',
        name: 'HANDLOOM TEXTURE KNIT TOP',
        audienceCategory: 'Women',
        productType: 'KNITWEAR',
        price: 4350,
        description:
            'A refined knit top with a soft hand feel and versatile shape, inspired by boutique handloom styling for modern wardrobes.',
        imagePath: 'images/products/women/cashmere-mock-neck.png',
        cardBackgroundColor: Color(0xFF102126),
        cardIcon: Icons.dry_cleaning_outlined,
        cardIconColor: Color(0xFFDCE5E8),
        heroGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF102126),
            Color(0xFF5E7278),
          ],
        ),
        heroIcon: Icons.accessibility_new,
        heroIconColor: Color(0xFFD9E3E6),
        availableColors: [
          Color(0xFF748E96),
          Color(0xFFE9E6E0),
        ],
        availableSizes: ['XS', 'S', 'M', 'L'],
      ),
      AppProduct(
        id: 'mini-tote-bag',
        name: 'MINI BATIK HAND CARRY BAG',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 5450,
        description:
            'A compact handbag with boutique batik styling, sized just right for everyday essentials and polished daywear.',
        imagePath: 'images/products/accessories/mini-tote-bag.png',
        cardBackgroundColor: Color(0xFFE7E5E2),
        cardIcon: Icons.shopping_bag_outlined,
        cardIconColor: Color(0xFF47413F),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE7E5E2),
            Color(0xFFC3BDB5),
          ],
        ),
        heroIcon: Icons.shopping_bag_outlined,
        heroIconColor: Color(0xFF534F4D),
        availableColors: [
          Color(0xFF2D2A28),
          Color(0xFFC5BCB0),
        ],
        availableSizes: ['ONE SIZE'],
      ),
      AppProduct(
        id: 'ladies-sling-bag',
        name: 'CITY ESSENTIAL SLING BAG',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 6250,
        description:
            'A practical sling bag with compact organization and a polished look, perfect for city errands and casual outings.',
        imagePath: 'images/products/accessories/ladies-sling-bag.png',
        cardBackgroundColor: Color(0xFFE6DED6),
        cardIcon: Icons.shopping_bag_outlined,
        cardIconColor: Color(0xFF5C4A40),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF0E9E2),
            Color(0xFFC4B0A1),
          ],
        ),
        heroIcon: Icons.shopping_bag_outlined,
        heroIconColor: Color(0xFF5D4A40),
        availableColors: [
          Color(0xFFB08364),
          Color(0xFF2D2421),
        ],
        availableSizes: ['ONE SIZE'],
      ),
      AppProduct(
        id: 'occasion-clutch',
        name: 'EVENING OCCASION CLUTCH',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 4850,
        description:
            'An elegant clutch designed for weddings, dinners, and festive celebrations with a sleek boutique finish.',
        imagePath: 'images/products/accessories/occasion-clutch.png',
        cardBackgroundColor: Color(0xFFF0E8E3),
        cardIcon: Icons.shopping_bag_outlined,
        cardIconColor: Color(0xFF82655B),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5EEEA),
            Color(0xFFD2B7AB),
          ],
        ),
        heroIcon: Icons.shopping_bag_outlined,
        heroIconColor: Color(0xFF85675D),
        availableColors: [
          Color(0xFFD6B3A1),
          Color(0xFF4C2F2A),
        ],
        availableSizes: ['ONE SIZE'],
      ),
      AppProduct(
        id: 'ladies-fashion-belt',
        name: 'CLASSIC LADIES WAIST BELT',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 2950,
        description:
            'A clean statement belt that adds shape and polish to dresses, tunics, and formal trousers.',
        imagePath: 'images/products/accessories/ladies-fashion-belt.png',
        cardBackgroundColor: Color(0xFFE5DED7),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF5E4E43),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEEE6E0),
            Color(0xFFC2AEA1),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFF655449),
        availableColors: [
          Color(0xFF6A4A39),
          Color(0xFFC9B3A5),
        ],
        availableSizes: ['S', 'M', 'L'],
      ),
      AppProduct(
        id: 'oversized-cotton-shirt',
        name: 'NEGOMBO RELAXED LINEN SHIRT',
        audienceCategory: 'Men',
        productType: 'SHIRTS',
        price: 4950,
        description:
            'A breathable linen shirt with a relaxed cut, ideal for tropical weather, casual Fridays, and smart weekend styling.',
        imagePath: 'images/products/men/oversized-cotton-shirt.png',
        cardBackgroundColor: Color(0xFFF2EADF),
        cardIcon: Icons.checkroom,
        cardIconColor: Color(0xFFD0B48B),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5EFE6),
            Color(0xFFD8C3A1),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFFD0B48B),
        availableColors: [
          Color(0xFFEADCCB),
          Color(0xFF111111),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
      ),
      AppProduct(
        id: 'nylon-shell-parka',
        name: 'MONSOON LIGHT TRAVEL JACKET',
        audienceCategory: 'Men',
        productType: 'OUTERWEAR',
        price: 8450,
        description:
            'A lightweight layering jacket made for travel, monsoon days, and easy everyday wear without feeling bulky.',
        imagePath: 'images/products/men/nylon-shell-parka.png',
        cardBackgroundColor: Color(0xFF2B2E31),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF62676C),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2B2E31),
            Color(0xFF7E8387),
          ],
        ),
        heroIcon: Icons.accessibility_new,
        heroIconColor: Color(0xFF858B90),
        availableColors: [
          Color(0xFF161A1E),
          Color(0xFF4F5559),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
      ),
      AppProduct(
        id: 'executive-fit-trouser',
        name: 'FORT EXECUTIVE TROUSER',
        audienceCategory: 'Men',
        productType: 'TROUSERS',
        price: 6250,
        description:
            'A smart formal trouser designed for office wear and event dressing, with a tailored fit that stays comfortable through long days.',
        imagePath: 'images/products/men/executive-fit-trouser.png',
        cardBackgroundColor: Color(0xFFE8E2D9),
        cardIcon: Icons.straighten_outlined,
        cardIconColor: Color(0xFF5F5044),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF0EAE2),
            Color(0xFFC8BAA8),
          ],
        ),
        heroIcon: Icons.accessibility_new_outlined,
        heroIconColor: Color(0xFF66564B),
        availableColors: [
          Color(0xFF2C2A28),
          Color(0xFF8F8378),
        ],
        availableSizes: ['30', '32', '34', '36', '38'],
      ),
      AppProduct(
        id: 'tropical-casual-polo',
        name: 'SOUTH COAST CASUAL POLO',
        audienceCategory: 'Men',
        productType: 'TOPS',
        price: 4250,
        description:
            'A lightweight polo made for warm-weather casual wear with a clean finish that works for workdays and weekends alike.',
        imagePath: 'images/products/men/tropical-casual-polo.png',
        cardBackgroundColor: Color(0xFFE2E8E3),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF4F6553),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEAF0EB),
            Color(0xFFAEBEAF),
          ],
        ),
        heroIcon: Icons.checkroom,
        heroIconColor: Color(0xFF516856),
        availableColors: [
          Color(0xFF314438),
          Color(0xFFDFE6DD),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
      ),
      AppProduct(
        id: 'batik-print-shirt',
        name: 'SIGNATURE BATIK PRINT SHIRT',
        audienceCategory: 'Men',
        productType: 'SHIRTS',
        price: 5450,
        description:
            'A statement batik print shirt with a modern silhouette, ideal for festive days, dinner outings, and boutique casual styling.',
        imagePath: 'images/products/men/batik-print-shirt.png',
        cardBackgroundColor: Color(0xFFF0E1D8),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF8C5946),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF6EBE5),
            Color(0xFFD3A88E),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFF905E4A),
        availableColors: [
          Color(0xFFC77F5D),
          Color(0xFF3B2B28),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
        badge: 'NEW',
      ),
      AppProduct(
        id: 'smart-fit-waistcoat',
        name: 'GALLE EVENING WAISTCOAT',
        audienceCategory: 'Men',
        productType: 'OUTERWEAR',
        price: 6850,
        description:
            'A polished waistcoat for weddings, office layering, and complete formal looks with a sharp structured finish.',
        imagePath: 'images/products/men/smart-fit-waistcoat.png',
        cardBackgroundColor: Color(0xFFE6E1DC),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF4D4946),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEFEAE5),
            Color(0xFFBEB6AE),
          ],
        ),
        heroIcon: Icons.accessibility_new,
        heroIconColor: Color(0xFF58514B),
        availableColors: [
          Color(0xFF2B2B2D),
          Color(0xFF8A837C),
        ],
        availableSizes: ['38', '40', '42', '44'],
      ),
      AppProduct(
        id: 'embroidered-lawn-top',
        name: 'EMBROIDERED DAYWEAR LAWN TOP',
        audienceCategory: 'Women',
        productType: 'TOPS',
        price: 4250,
        description:
            'A breathable lawn top with delicate embroidery, made for bright daytime looks and easy boutique styling.',
        imagePath: 'images/products/women/embroidered-lawn-top.png',
        cardBackgroundColor: Color(0xFFF2EDE7),
        cardIcon: Icons.dry_cleaning_outlined,
        cardIconColor: Color(0xFF8E7360),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7F3EF),
            Color(0xFFD8C6B8),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFF907562),
        availableColors: [
          Color(0xFFE9D8C8),
          Color(0xFF5D4035),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
      ),
      AppProduct(
        id: 'office-pencil-skirt',
        name: 'CITYLINE PENCIL SKIRT',
        audienceCategory: 'Women',
        productType: 'BOTTOMS',
        price: 4850,
        description:
            'A clean pencil skirt made for office looks and polished formal dressing with a flattering boutique fit.',
        imagePath: 'images/products/women/office-pencil-skirt.png',
        cardBackgroundColor: Color(0xFFE4E0DE),
        cardIcon: Icons.accessibility_new_outlined,
        cardIconColor: Color(0xFF655B58),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEDE9E7),
            Color(0xFFC1B6B0),
          ],
        ),
        heroIcon: Icons.accessibility_new_outlined,
        heroIconColor: Color(0xFF6A605B),
        availableColors: [
          Color(0xFF2E2A29),
          Color(0xFF8F827C),
        ],
        availableSizes: ['S', 'M', 'L'],
      ),
      AppProduct(
        id: 'festive-anarkali-dress',
        name: 'FESTIVE ANARKALI EDITION',
        audienceCategory: 'Women',
        productType: 'DRESSES',
        price: 12950,
        description:
            'A graceful festive anarkali designed for weddings, family functions, and boutique occasionwear styling.',
        imagePath: 'images/products/women/festive-anarkali-dress.png',
        cardBackgroundColor: Color(0xFFF1E2DB),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF8C594F),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7ECE7),
            Color(0xFFD8A899),
          ],
        ),
        heroIcon: Icons.accessibility_new,
        heroIconColor: Color(0xFF905E54),
        availableColors: [
          Color(0xFFB86A57),
          Color(0xFF6A2E2D),
        ],
        availableSizes: ['S', 'M', 'L', 'XL'],
        badge: 'NEW',
      ),
      AppProduct(
        id: 'soft-wrap-cardigan',
        name: 'SOFT DRAPE WRAP CARDIGAN',
        audienceCategory: 'Women',
        productType: 'KNITWEAR',
        price: 6250,
        description:
            'A soft wrap cardigan that layers beautifully over dresses, tops, and workwear for air-conditioned comfort.',
        imagePath: 'images/products/women/soft-wrap-cardigan.png',
        cardBackgroundColor: Color(0xFFE6E6E2),
        cardIcon: Icons.dry_cleaning_outlined,
        cardIconColor: Color(0xFF62655A),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFEFEFEA),
            Color(0xFFC4C5BA),
          ],
        ),
        heroIcon: Icons.checkroom,
        heroIconColor: Color(0xFF64685D),
        availableColors: [
          Color(0xFFB8B9AE),
          Color(0xFF4B4C45),
        ],
        availableSizes: ['S', 'M', 'L'],
      ),
      AppProduct(
        id: 'mens-loafer-classic',
        name: 'CLASSIC OFFICE LEATHER LOAFER',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 9250,
        description:
            'A smart leather loafer designed for office wear and polished smart casual outfits with easy slip-on comfort.',
        imagePath: 'images/products/shoes/mens-loafer-classic.png',
        cardBackgroundColor: Color(0xFFE9E2DA),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFF6A5142),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF0E9E1),
            Color(0xFFC7AE9A),
          ],
        ),
        heroIcon: Icons.hiking_outlined,
        heroIconColor: Color(0xFF6D5343),
        availableColors: [
          Color(0xFF5E3E30),
          Color(0xFF1F1A17),
        ],
        availableSizes: ['40', '41', '42', '43', '44'],
      ),
      AppProduct(
        id: 'bridal-glitter-sandal',
        name: 'BRIDAL SHIMMER SANDAL',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 9750,
        description:
            'A dressy sandal with elegant shine for weddings, receptions, and festive celebrations with boutique comfort.',
        imagePath: 'images/products/shoes/bridal-glitter-sandal.png',
        cardBackgroundColor: Color(0xFFF0E8E1),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFFA88663),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF6F0EB),
            Color(0xFFE1C7AC),
          ],
        ),
        heroIcon: Icons.accessibility_new_outlined,
        heroIconColor: Color(0xFFA78460),
        availableColors: [
          Color(0xFFD5B188),
          Color(0xFFEADFD1),
        ],
        availableSizes: ['36', '37', '38', '39', '40'],
      ),
      AppProduct(
        id: 'kids-sport-sneaker',
        name: 'ACTIVE KIDS SPORT SNEAKER',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 5250,
        description:
            'A lightweight everyday sneaker for active kids, school outings, and casual family days with easy comfort.',
        imagePath: 'images/products/shoes/kids-sport-sneaker.png',
        cardBackgroundColor: Color(0xFFE0E6EC),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFF50647A),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFE8EEF3),
            Color(0xFFB7C7D7),
          ],
        ),
        heroIcon: Icons.hiking_outlined,
        heroIconColor: Color(0xFF52667C),
        availableColors: [
          Color(0xFF4E6178),
          Color(0xFFEDF2F7),
        ],
        availableSizes: ['30', '31', '32', '33', '34', '35'],
      ),
      AppProduct(
        id: 'woven-slip-on',
        name: 'WOVEN RESORT SLIP-ON',
        audienceCategory: 'Shoes',
        productType: 'FOOTWEAR',
        price: 4450,
        description:
            'An easy woven slip-on built for casual wear, holiday trips, and tropical comfort without losing style.',
        imagePath: 'images/products/shoes/woven-slip-on.png',
        cardBackgroundColor: Color(0xFFECE4D8),
        cardIcon: Icons.hiking_outlined,
        cardIconColor: Color(0xFF8B6F4D),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF3ECE2),
            Color(0xFFD0B693),
          ],
        ),
        heroIcon: Icons.hiking_outlined,
        heroIconColor: Color(0xFF8A6F4F),
        availableColors: [
          Color(0xFFC39D70),
          Color(0xFF3B3028),
        ],
        availableSizes: ['39', '40', '41', '42', '43'],
      ),
      AppProduct(
        id: 'batik-scarf-wrap',
        name: 'BATIK PRINT SCARF WRAP',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 2450,
        description:
            'A printed scarf wrap that adds colour and boutique detail to tops, dresses, and soft workwear styling.',
        imagePath: 'images/products/accessories/batik-scarf-wrap.png',
        cardBackgroundColor: Color(0xFFF0E5DC),
        cardIcon: Icons.checkroom_outlined,
        cardIconColor: Color(0xFF8F644A),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF5ECE5),
            Color(0xFFD8B199),
          ],
        ),
        heroIcon: Icons.checkroom_outlined,
        heroIconColor: Color(0xFF8E654E),
        availableColors: [
          Color(0xFFBF8663),
          Color(0xFF5A372C),
        ],
        availableSizes: ['ONE SIZE'],
      ),
      AppProduct(
        id: 'statement-earring-set',
        name: 'FESTIVE STATEMENT EARRING SET',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 2750,
        description:
            'A party-ready earring set designed for weddings, festive nights, and dressing up simple outfits effortlessly.',
        imagePath:
            'images/products/accessories/statement-earring-set.png',
        cardBackgroundColor: Color(0xFFF1ECE6),
        cardIcon: Icons.stars_outlined,
        cardIconColor: Color(0xFFAA875D),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7F2EC),
            Color(0xFFE3CFB2),
          ],
        ),
        heroIcon: Icons.stars_outlined,
        heroIconColor: Color(0xFFAA875F),
        availableColors: [
          Color(0xFFD8BB93),
          Color(0xFFB28A56),
        ],
        availableSizes: ['ONE SIZE'],
      ),
      AppProduct(
        id: 'travel-weekender-bag',
        name: 'TRAVEL WEEKENDER DUFFLE',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 8450,
        description:
            'A spacious weekender bag made for short trips, work travel, and carrying essentials with a premium store look.',
        imagePath:
            'images/products/accessories/travel-weekender-bag.png',
        cardBackgroundColor: Color(0xFFE2DFDA),
        cardIcon: Icons.shopping_bag_outlined,
        cardIconColor: Color(0xFF5A5855),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFECEAE6),
            Color(0xFFBCB8B1),
          ],
        ),
        heroIcon: Icons.shopping_bag_outlined,
        heroIconColor: Color(0xFF5D5955),
        availableColors: [
          Color(0xFF2F3132),
          Color(0xFF8E8C88),
        ],
        availableSizes: ['ONE SIZE'],
      ),
      AppProduct(
        id: 'minimal-watch-set',
        name: 'MINIMAL GOLD WATCH SET',
        audienceCategory: 'Accessories',
        productType: 'ACCESSORIES',
        price: 11950,
        description:
            'A clean watch set with a boutique finish that elevates daily workwear and polished formal looks.',
        imagePath: 'images/products/accessories/minimal-watch-set.png',
        cardBackgroundColor: Color(0xFFE9E4DD),
        cardIcon: Icons.watch_outlined,
        cardIconColor: Color(0xFF7A644B),
        heroGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF0ECE5),
            Color(0xFFCBB99F),
          ],
        ),
        heroIcon: Icons.watch_outlined,
        heroIconColor: Color(0xFF7E674C),
        availableColors: [
          Color(0xFFB79369),
          Color(0xFF3B322A),
        ],
        availableSizes: ['ONE SIZE'],
      ),
    ];
  }
}
