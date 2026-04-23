import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/currency_formatter.dart';
import '../models/cart_item.dart';
import '../widgets/cart_bottom_bar.dart';
import '../widgets/cart_item_card.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    this.embedded = false,
  });

  final bool embedded;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final items = store.cart
            .map((line) => _toCartItem(store, line))
            .toList(growable: false);

        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            automaticallyImplyLeading: !widget.embedded,
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: widget.embedded
                ? null
                : IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(Icons.menu),
                  ),
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.4,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'YOUR SELECTION',
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: const Color(0xFF666666),
                                    letterSpacing: 1.8,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Shopping Bag',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -0.8,
                              ),
                        ),
                        const SizedBox(height: 26),
                        if (items.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 42),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Your cart is empty.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: const Color(0xFF6B6B6B),
                                        ),
                                  ),
                                  const SizedBox(height: 18),
                                  FilledButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RouteNames.mainShell,
                                        (route) => false,
                                      );
                                    },
                                    style: FilledButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      foregroundColor: Colors.white,
                                      shape: const RoundedRectangleBorder(),
                                    ),
                                    child: const Text('CONTINUE SHOPPING'),
                                  ),
                                ],
                              ),
                            ),
                          )
                        else ...[
                          for (int i = 0; i < items.length; i++) ...[
                            CartItemCard(
                              item: items[i],
                              onTap: () {
                                store.selectProduct(store.cart[i].productId);
                                Navigator.pushNamed(
                                    context, RouteNames.productDetails);
                              },
                              onRemove: () =>
                                  store.removeCartLine(store.cart[i].id),
                              onDecrease: () => store.updateCartQuantity(
                                  store.cart[i].id, -1),
                              onIncrease: () =>
                                  store.updateCartQuantity(store.cart[i].id, 1),
                            ),
                            if (i != items.length - 1)
                              const SizedBox(height: 24),
                          ],
                          const SizedBox(height: 28),
                          Text(
                            'PROMO CODE',
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: const Color(0xFF2A2A2A),
                                  letterSpacing: 1.9,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _promoController,
                                  decoration: const InputDecoration(
                                    hintText: 'Enter code',
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 14,
                                    ),
                                    border: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFFD8D5CF)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 52,
                                child: FilledButton(
                                  onPressed: () {
                                    final message = store
                                        .applyPromoCode(_promoController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)),
                                    );
                                    if (message.contains('applied')) {
                                      _promoController.clear();
                                    }
                                  },
                                  style: FilledButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.white,
                                    shape: const RoundedRectangleBorder(),
                                  ),
                                  child: const Text('APPLY'),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _PromoChip(
                                label: 'WELCOME10',
                                onTap: () =>
                                    _promoController.text = 'WELCOME10',
                              ),
                              _PromoChip(
                                label: 'ARMVIP15',
                                onTap: () => _promoController.text = 'ARMVIP15',
                              ),
                              _PromoChip(
                                label: 'FESTIVE12',
                                onTap: () =>
                                    _promoController.text = 'FESTIVE12',
                              ),
                            ],
                          ),
                          if (store.activePromoCode != null) ...[
                            const SizedBox(height: 14),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              color: const Color(0xFFECE6DE),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${store.activePromoCode} applied. You saved ${CurrencyFormatter.lkr(store.cartDiscount)}.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                            color: const Color(0xFF3A342E),
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: store.clearPromoCode,
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: const Text('REMOVE'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          const Divider(color: Color(0xFFE2DED7), height: 1),
                          const SizedBox(height: 18),
                          _SummaryRow(
                            label: 'SUBTOTAL',
                            value: CurrencyFormatter.lkr(store.cartSubtotal),
                          ),
                          const SizedBox(height: 14),
                          if (store.cartDiscount > 0) ...[
                            _SummaryRow(
                              label: 'DISCOUNT',
                              value:
                                  '- ${CurrencyFormatter.lkr(store.cartDiscount)}',
                              valueColor: const Color(0xFF2C6A45),
                            ),
                            const SizedBox(height: 14),
                          ],
                          _SummaryRow(
                            label: 'SHIPPING',
                            value: store.cartShipping == 0
                                ? 'FREE'
                                : CurrencyFormatter.lkr(store.cartShipping),
                          ),
                          const SizedBox(height: 14),
                          _SummaryRow(
                            label: 'TAX',
                            value: CurrencyFormatter.lkr(store.cartTax),
                          ),
                          const SizedBox(height: 18),
                          const Divider(color: Color(0xFFE2DED7), height: 1),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                'TOTAL',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      color: const Color(0xFF222222),
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.8,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                CurrencyFormatter.lkr(store.cartTotal),
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      color: const Color(0xFF222222),
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Islandwide delivery and secure payments available at checkout.',
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF6B6B6B),
                                    ),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RouteNames.checkout);
                              },
                              style: FilledButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                      letterSpacing: 2.4,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                              child: const Text('PROCEED TO CHECKOUT'),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (!widget.embedded) const CartBottomBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  CartItem _toCartItem(AppStore store, CartLine line) {
    final product = store.productById(line.productId);
    return CartItem(
      id: line.id,
      name: product.name,
      size: line.selectedSize,
      color: _colorName(product.availableColors[line.selectedColorIndex]),
      quantity: line.quantity,
      price: CurrencyFormatter.lkr(product.price * line.quantity),
      imagePath: product.imagePath,
      background: product.cardBackgroundColor,
      icon: product.cardIcon,
      iconColor: product.cardIconColor,
    );
  }

  String _colorName(Color color) {
    if (color.computeLuminance() < 0.08) {
      return 'BLACK';
    }
    if (color.r > 0.70 && color.g > 0.67 && color.b > 0.63) {
      return 'SAND';
    }
    if (color.b > color.r && color.b > color.g) {
      return 'SLATE';
    }
    if (color.r > 0.47 && color.g > 0.31 && color.b < 0.36) {
      return 'BROWN';
    }
    return 'NEUTRAL';
  }
}

class _PromoChip extends StatelessWidget {
  const _PromoChip({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        color: Colors.white,
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF333333),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: const Color(0xFF7D7D7D),
                letterSpacing: 1.0,
                fontWeight: FontWeight.w500,
              ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: valueColor ?? const Color(0xFF3A3A3A),
                letterSpacing: 0.6,
                fontWeight: FontWeight.w700,
              ),
        ),
      ],
    );
  }
}
