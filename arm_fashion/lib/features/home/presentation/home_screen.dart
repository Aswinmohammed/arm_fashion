import 'dart:async';

import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/catalog_labels.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/app_product_image.dart';
import '../data/home_dummy_data.dart';
import '../models/home_product.dart';
import '../widgets/home_category_chip.dart';
import '../widgets/home_product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final selectedCategory =
            HomeDummyData.categories[_selectedCategoryIndex];
        final selectedCategoryLabel = CatalogLabels.audience(selectedCategory);
        final categoryProducts = store.productsForAudience(selectedCategory);
        final newArrivals = store
            .productsForAudience(selectedCategory)
            .take(4)
            .map(_toHomeProduct)
            .toList(growable: false);

        return Scaffold(
          backgroundColor: const Color(0xFFF8F6F2),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF8F6F2),
            surfaceTintColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            title: Text(
              'ARM FASHION',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.3,
                  ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, RouteNames.search);
                },
                icon: const Icon(Icons.search_outlined),
              ),
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
              padding: const EdgeInsets.fromLTRB(14, 6, 14, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HomeSearchBar(
                    onTap: () {
                      Navigator.pushNamed(context, RouteNames.search);
                    },
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    height: 34,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: HomeDummyData.categories.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 22),
                      itemBuilder: (context, index) {
                        return HomeCategoryChip(
                          label: CatalogLabels.audience(
                            HomeDummyData.categories[index],
                          ),
                          isSelected: index == _selectedCategoryIndex,
                          onTap: () {
                            setState(() {
                              _selectedCategoryIndex = index;
                            });
                            store.setCatalogAudience(
                                HomeDummyData.categories[index]);
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${categoryProducts.length} styles in $selectedCategoryLabel',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: const Color(0xFF6B6B6B),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 18),
                  _FeaturedBanner(
                    products: categoryProducts,
                    categoryLabel: selectedCategoryLabel,
                    onTap: () {
                      store.setCatalogAudience(selectedCategory);
                      Navigator.pushNamed(context, RouteNames.categoryProducts);
                    },
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Text(
                        'NEW ARRIVALS',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          store.setCatalogAudience(selectedCategory);
                          Navigator.pushNamed(
                              context, RouteNames.categoryProducts);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: const Color(0xFF666666),
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'VIEW ALL',
                          style:
                              Theme.of(context).textTheme.labelMedium?.copyWith(
                                    color: const Color(0xFF525252),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 1.1,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    itemCount: newArrivals.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.55,
                    ),
                    itemBuilder: (context, index) {
                      final product = newArrivals[index];
                      return HomeProductCard(
                        product: product,
                        onTap: () {
                          store.selectProduct(product.id);
                          Navigator.pushNamed(
                              context, RouteNames.productDetails);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  HomeProduct _toHomeProduct(AppProduct product) {
    return HomeProduct(
      id: product.id,
      name: product.name,
      price: CurrencyFormatter.lkr(product.price),
      label: product.productType,
      imagePath: product.imagePath,
      backgroundColor: product.cardBackgroundColor,
      accentColor: product.cardIconColor,
      icon: product.cardIcon,
      isFavorite: false,
    );
  }
}

class _HomeSearchBar extends StatelessWidget {
  const _HomeSearchBar({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFD8D5CF)),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.search,
              size: 18,
              color: Color(0xFF6F6F6F),
            ),
            const SizedBox(width: 8),
            Text(
              'SEARCH COLLECTIONS',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: const Color(0xFF6F6F6F),
                    letterSpacing: 1.0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeaturedBanner extends StatefulWidget {
  const _FeaturedBanner({
    required this.onTap,
    required this.products,
    required this.categoryLabel,
  });

  final VoidCallback onTap;
  final List<AppProduct> products;
  final String categoryLabel;

  @override
  State<_FeaturedBanner> createState() => _FeaturedBannerState();
}

class _FeaturedBannerState extends State<_FeaturedBanner> {
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _configureTimer();
  }

  @override
  void didUpdateWidget(covariant _FeaturedBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.products != widget.products) {
      _currentIndex = 0;
      _configureTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _configureTimer() {
    _timer?.cancel();
    if (widget.products.length < 2) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || widget.products.isEmpty) {
        return;
      }

      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.products.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentProduct = widget.products.isEmpty
        ? null
        : widget.products[_currentIndex % widget.products.length];

    return GestureDetector(
      onTap: widget.onTap,
      child: AspectRatio(
        aspectRatio: 0.84,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFF161816),
            border: Border.all(color: const Color(0xFF262825)),
          ),
          child: Stack(
            children: [
              if (currentProduct != null)
                Positioned.fill(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 700),
                    switchInCurve: Curves.easeOutCubic,
                    switchOutCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: SizedBox.expand(
                      key: ValueKey(currentProduct.id),
                      child: AppProductImage(
                        imagePath: currentProduct.imagePath,
                        fit: BoxFit.cover,
                        fallbackIcon: currentProduct.heroIcon,
                        fallbackIconColor: currentProduct.heroIconColor,
                        fallbackBackgroundColor: const Color(0xFF1B1D1B),
                        iconSize: 120,
                      ),
                    ),
                  ),
                ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withValues(alpha: 0.18),
                        Colors.black.withValues(alpha: 0.30),
                        Colors.black.withValues(alpha: 0.78),
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.categoryLabel.toUpperCase()} / FEATURED',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: Colors.white70,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'THE ARM\nCOLLECTIONS',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                height: 1.0,
                              ),
                    ),
                    if (currentProduct != null) ...[
                      const SizedBox(height: 10),
                      SizedBox(
                        width: 188,
                        child: Text(
                          currentProduct.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.88),
                                    height: 1.3,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      color: Colors.white,
                      child: Text(
                        'SHOP NOW',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.3,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
