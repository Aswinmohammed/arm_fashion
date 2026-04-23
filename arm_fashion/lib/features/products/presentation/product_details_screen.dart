import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/catalog_labels.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../core/widgets/app_product_image.dart';
import '../models/category_product.dart';
import '../models/product_detail.dart';
import '../widgets/product_color_selector.dart';
import '../widgets/product_info_row.dart';
import '../widgets/product_size_selector.dart';
import '../widgets/related_product_tile.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late int _selectedColorIndex;
  late String _selectedSize;
  bool _didSeedSelection = false;

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final product = _toDetailModel(store.selectedProduct);
        if (!_didSeedSelection) {
          _selectedColorIndex = product.selectedColorIndex;
          _selectedSize = product.selectedSize;
          _didSeedSelection = true;
        }
        final relatedProducts = store
            .relatedProductsFor(store.selectedProduct.id)
            .map(_toRelatedProduct)
            .toList(growable: false);

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
              icon: const Icon(Icons.arrow_back_ios_new, size: 18),
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 0.88,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: product.heroGradient,
                            ),
                            child: AppProductImage(
                              imagePath: product.imagePath,
                              fit: BoxFit.cover,
                              fallbackIcon: product.heroIcon,
                              fallbackIconColor: product.heroIconColor,
                              iconSize: 220,
                              padding: const EdgeInsets.all(18),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 12, 10, 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      product.subtitle,
                                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                            color: const Color(0xFF686868),
                                            letterSpacing: 1.6,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                  Text(
                                    product.price,
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                          color: const Color(0xFF252525),
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: 210,
                                child: Text(
                                  product.name,
                                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        height: 1.0,
                                      ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                product.description,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF5E5E5E),
                                      height: 1.55,
                                    ),
                              ),
                              const SizedBox(height: 18),
                              _ProductDetailHighlights(product: product),
                              const SizedBox(height: 18),
                              Text(
                                'COLOR',
                                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                      color: const Color(0xFF5C5C5C),
                                      letterSpacing: 1.4,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 10),
                              ProductColorSelector(
                                colors: product.availableColors,
                                selectedIndex: _selectedColorIndex,
                                onSelected: (index) {
                                  setState(() {
                                    _selectedColorIndex = index;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  Text(
                                    'SELECT SIZE',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: const Color(0xFF5C5C5C),
                                          letterSpacing: 1.4,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                  const Spacer(),
                                  Text(
                                    'SIZE GUIDE',
                                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                          color: const Color(0xFF6F6F6F),
                                          letterSpacing: 1.2,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              ProductSizeSelector(
                                sizes: product.availableSizes,
                                selectedSize: _selectedSize,
                                onSelected: (size) {
                                  setState(() {
                                    _selectedSize = size;
                                  });
                                },
                              ),
                              const SizedBox(height: 14),
                              const Divider(color: Color(0xFFE7E3DB), height: 1),
                              const ProductInfoRow(onTap: null, title: 'Composition & Care'),
                              const Divider(color: Color(0xFFE7E3DB), height: 1),
                              const ProductInfoRow(onTap: null, title: 'Shipping & Returns'),
                              const Divider(color: Color(0xFFE7E3DB), height: 1),
                              const ProductInfoRow(onTap: null, title: 'Complete The Look'),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  for (int i = 0; i < relatedProducts.length; i++) ...[
                                    RelatedProductTile(
                                      product: relatedProducts[i],
                                      onTap: () {
                                        store.selectProduct(relatedProducts[i].id);
                                        setState(() {
                                          _didSeedSelection = false;
                                        });
                                      },
                                    ),
                                    if (i != relatedProducts.length - 1)
                                      const SizedBox(width: 10),
                                  ],
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            store.toggleWishlist(store.selectedProduct.id);
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF767676),
                            side: const BorderSide(color: Color(0xFFE7E3DB)),
                            shape: const RoundedRectangleBorder(),
                            padding: const EdgeInsets.all(14),
                            minimumSize: const Size(46, 46),
                          ),
                          child: Icon(
                            store.isInWishlist(store.selectedProduct.id)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              store.addProductToCart(
                                store.selectedProduct.id,
                                selectedSize: _selectedSize,
                                selectedColorIndex: _selectedColorIndex,
                              );
                              Navigator.pushNamed(context, RouteNames.cart);
                            },
                            style: FilledButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              shape: const RoundedRectangleBorder(),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              textStyle:
                                  Theme.of(context).textTheme.labelMedium?.copyWith(
                                        letterSpacing: 1.8,
                                        fontWeight: FontWeight.w700,
                                      ),
                            ),
                            child: const Text('ADD TO CART'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  ProductDetail _toDetailModel(AppProduct product) {
    return ProductDetail(
      id: product.id,
      name: product.name,
      price: CurrencyFormatter.lkr(product.price),
      subtitle: product.subtitle,
      description: product.description,
      audienceCategory: product.audienceCategory,
      productType: product.productType,
      imagePath: product.imagePath,
      heroGradient: product.heroGradient,
      heroIcon: product.heroIcon,
      heroIconColor: product.heroIconColor,
      availableColors: product.availableColors,
      availableSizes: product.availableSizes,
      selectedColorIndex: 0,
      selectedSize: product.availableSizes.first,
    );
  }

  CategoryProduct _toRelatedProduct(AppProduct product) {
    return CategoryProduct(
      id: product.id,
      name: product.name,
      price: CurrencyFormatter.lkr(product.price),
      imagePath: product.imagePath,
      backgroundColor: product.cardBackgroundColor,
      icon: product.cardIcon,
      iconColor: product.cardIconColor,
    );
  }
}

class _ProductDetailHighlights extends StatelessWidget {
  const _ProductDetailHighlights({required this.product});

  final ProductDetail product;

  @override
  Widget build(BuildContext context) {
    final highlights = [
      (
        label: 'Category',
        value: CatalogLabels.audience(product.audienceCategory),
      ),
      (
        label: 'Type',
        value: product.productType,
      ),
      (
        label: 'Sizes',
        value: product.availableSizes.join(' / '),
      ),
      (
        label: 'Colours',
        value: '${product.availableColors.length} options',
      ),
      (
        label: 'Best For',
        value: _occasionText(product),
      ),
      (
        label: 'Store Note',
        value: 'Selected for ARM Fashion seasonal edit',
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE7E3DB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PRODUCT DETAILS',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: const Color(0xFF2F2F2F),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
          ),
          const SizedBox(height: 12),
          ...highlights.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 92,
                    child: Text(
                      item.label.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF767676),
                            letterSpacing: 0.9,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF494949),
                            height: 1.45,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  String _occasionText(ProductDetail product) {
    switch (product.audienceCategory) {
      case 'Men':
        return 'Office wear, smart casual edits, and event dressing';
      case 'Women':
        return 'Workwear, outings, occasionwear, and boutique styling';
      case 'Shoes':
        return 'Daily wear, events, and coordinated fashion looks';
      case 'Accessories':
        return 'Finishing touches for daywear, travel, and festive outfits';
      default:
        return 'Curated for versatile everyday styling';
    }
  }
}
