import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/currency_formatter.dart';
import '../models/wishlist_item.dart';
import '../widgets/wishlist_bottom_utility_bar.dart';
import '../widgets/wishlist_product_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final items = store.wishlistProducts.map(_toWishlistItem).toList(growable: false);

        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.maybePop(context);
              },
              icon: const Icon(Icons.menu),
            ),
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.cart);
                },
                icon: const Icon(Icons.shopping_bag_outlined),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(6, 8, 6, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PERSONAL CURATION',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF666666),
                                letterSpacing: 1.8,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'WISHLIST',
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.black,
                                letterSpacing: -0.8,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 20,
                          height: 2,
                          color: const Color(0xFF8A8A8A),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  if (items.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              'Your saved pieces will appear here.',
                              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: const Color(0xFF6F6F6F),
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
                    for (int index = 0; index < items.length; index++) ...[
                      WishlistProductCard(
                        item: items[index],
                        onTap: () {
                          store.selectProduct(items[index].id);
                          Navigator.pushNamed(context, RouteNames.productDetails);
                        },
                      ),
                      if (index == 0) const WishlistBottomUtilityBar(),
                      if (index != items.length - 1) const SizedBox(height: 22),
                    ],
                    const SizedBox(height: 26),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          store.moveWishlistToCart();
                          Navigator.pushNamed(context, RouteNames.cart);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          textStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        child: const Text('MOVE ALL TO BAG'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  WishlistItem _toWishlistItem(AppProduct product) {
    return WishlistItem(
      id: product.id,
      name: product.name,
      category: product.productType,
      price: CurrencyFormatter.lkr(product.price),
      imagePath: product.imagePath,
      background: product.heroGradient,
      icon: product.heroIcon,
      iconColor: product.heroIconColor,
    );
  }
}
