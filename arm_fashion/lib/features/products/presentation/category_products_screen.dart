import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/catalog_labels.dart';
import '../../../core/utils/currency_formatter.dart';
import '../models/category_product.dart';
import '../widgets/catalog_action_chip.dart';
import '../widgets/catalog_product_card.dart';

class CategoryProductsScreen extends StatefulWidget {
  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  int _visibleCount = 6;
  String _selectedProductType = 'All';
  String _selectedSortOption = 'Featured';

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        const audiences = CatalogLabels.audienceValues;
        final selectedAudience = store.catalogAudience;
        final selectedAudienceLabel = CatalogLabels.audience(selectedAudience);
        final allProducts = store.productsForAudience(selectedAudience);
        final productTypes = [
          'All',
          ...{
            ...allProducts.map((product) => product.productType),
          },
        ];

        if (!productTypes.contains(_selectedProductType)) {
          _selectedProductType = 'All';
        }

        final filteredProducts = allProducts.where((product) {
          return _selectedProductType == 'All' ||
              product.productType == _selectedProductType;
        }).toList(growable: false);
        final sortedProducts = _sortProducts(filteredProducts);
        final visibleProducts = sortedProducts.take(_visibleCount).toList(growable: false);

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
                onPressed: () => Navigator.pushNamed(context, RouteNames.cart),
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
                    padding: const EdgeInsets.fromLTRB(12, 6, 12, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COLLECTION',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF686868),
                                letterSpacing: 2.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          selectedAudienceLabel.toUpperCase(),
                          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                letterSpacing: -1,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _catalogDescription(selectedAudience),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF5C5C5C),
                                height: 1.45,
                              ),
                        ),
                        const SizedBox(height: 18),
                        SizedBox(
                          height: 36,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: audiences.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 18),
                            itemBuilder: (context, index) {
                              final audience = audiences[index];
                              final isSelected = audience == selectedAudience;
                              return GestureDetector(
                                onTap: () {
                                  store.setCatalogAudience(audience);
                                  setState(() {
                                    _visibleCount = 6;
                                    _selectedProductType = 'All';
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: isSelected ? Colors.black : Colors.transparent,
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    CatalogLabels.audience(audience).toUpperCase(),
                                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                          color: isSelected
                                              ? Colors.black
                                              : const Color(0xFF878787),
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w500,
                                          letterSpacing: 1.0,
                                        ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CatalogActionChip(
                              label: _selectedProductType == 'All'
                                  ? 'Filter'
                                  : _selectedProductType,
                              icon: Icons.tune,
                              onTap: () => _showFilterSheet(context, productTypes),
                            ),
                            const SizedBox(width: 10),
                            CatalogActionChip(
                              label: _selectedSortOption,
                              icon: Icons.swap_vert,
                              onTap: () => _showSortSheet(context),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        GridView.builder(
                          itemCount: visibleProducts.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 18,
                            childAspectRatio: 0.56,
                          ),
                          itemBuilder: (context, index) {
                            final product = _toCategoryProduct(visibleProducts[index]);
                            return CatalogProductCard(
                              product: product,
                              onTap: () {
                                store.selectProduct(product.id);
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.productDetails,
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                        if (_visibleCount < sortedProducts.length)
                          Center(
                            child: SizedBox(
                              width: 110,
                              child: FilledButton(
                                onPressed: () {
                                  setState(() {
                                    _visibleCount =
                                        (_visibleCount + 4).clamp(0, sortedProducts.length);
                                  });
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  shape: const RoundedRectangleBorder(),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium?.copyWith(
                                            letterSpacing: 1.8,
                                            fontWeight: FontWeight.w700,
                                          ),
                                ),
                                child: const Text('LOAD MORE'),
                              ),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'SHOWING ${visibleProducts.length} OF ${sortedProducts.length} ITEMS',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: const Color(0xFF6B6B6B),
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const _CategoryBottomBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  CategoryProduct _toCategoryProduct(AppProduct product) {
    return CategoryProduct(
      id: product.id,
      name: product.name,
      price: CurrencyFormatter.lkr(product.price),
      imagePath: product.imagePath,
      backgroundColor: product.cardBackgroundColor,
      icon: product.cardIcon,
      iconColor: product.cardIconColor,
      badgeText: product.badge,
    );
  }

  List<AppProduct> _sortProducts(List<AppProduct> products) {
    final sorted = [...products];

    switch (_selectedSortOption) {
      case 'Price Low':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price High':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Name A-Z':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'New Arrivals':
        sorted.sort((a, b) {
          final aScore = a.badge == 'NEW' ? 1 : 0;
          final bScore = b.badge == 'NEW' ? 1 : 0;
          return bScore.compareTo(aScore);
        });
        break;
      default:
        break;
    }

    return sorted;
  }

  Future<void> _showFilterSheet(
    BuildContext context,
    List<String> productTypes,
  ) async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFFF8F6F2),
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: productTypes
                .map(
                  (type) => ListTile(
                    title: Text(type),
                    trailing: type == _selectedProductType
                        ? const Icon(Icons.check, color: Colors.black)
                        : null,
                    onTap: () => Navigator.pop(context, type),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedProductType = selected;
        _visibleCount = 6;
      });
    }
  }

  Future<void> _showSortSheet(BuildContext context) async {
    const sortOptions = ['Featured', 'New Arrivals', 'Price Low', 'Price High', 'Name A-Z'];

    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFFF8F6F2),
      builder: (context) {
        return SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: sortOptions
                .map(
                  (option) => ListTile(
                    title: Text(option),
                    trailing: option == _selectedSortOption
                        ? const Icon(Icons.check, color: Colors.black)
                        : null,
                    onTap: () => Navigator.pop(context, option),
                  ),
                )
                .toList(),
          ),
        );
      },
    );

    if (selected != null) {
      setState(() {
        _selectedSortOption = selected;
        _visibleCount = 6;
      });
    }
  }

  String _catalogDescription(String audience) {
    return switch (audience) {
      'Women' =>
        'Boutique-ready silhouettes, occasionwear, and elevated daily styles inspired by Sri Lankan fashion retail.',
      'Shoes' =>
        'Office shoes, heels, sneakers, and comfort sandals curated for real everyday wear and dress-up moments.',
      'Accessories' =>
        'Handbags, belts, and finishing pieces designed to complete each look with practical boutique styling.',
      _ =>
        'Curated smart casual and formal menswear with tropical-friendly tailoring for office, events, and weekends.',
    };
  }
}

class _CategoryBottomBar extends StatelessWidget {
  const _CategoryBottomBar();

  @override
  Widget build(BuildContext context) {
    Widget buildItem({
      required IconData icon,
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      final color = isSelected ? Colors.black : const Color(0xFFB5B5B5);

      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 18, color: color),
                const SizedBox(height: 4),
                Text(
                  label.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: color,
                        fontSize: 8,
                        height: 1.0,
                        letterSpacing: 0.9,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE7E3DB)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            buildItem(
              icon: Icons.home_outlined,
              label: 'Home',
              isSelected: false,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteNames.mainShell,
                  (route) => false,
                );
              },
            ),
            buildItem(
              icon: Icons.search,
              label: 'Search',
              isSelected: true,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.search);
              },
            ),
            buildItem(
              icon: Icons.shopping_bag_outlined,
              label: 'Cart',
              isSelected: false,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.cart);
              },
            ),
            buildItem(
              icon: Icons.person_outline,
              label: 'Profile',
              isSelected: false,
              onTap: () {
                Navigator.pushNamed(context, RouteNames.profile);
              },
            ),
          ],
        ),
      ),
    );
  }
}
