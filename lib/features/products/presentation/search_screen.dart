import 'package:flutter/material.dart';

import '../../../core/routes/route_names.dart';
import '../../../core/state/app_scope.dart';
import '../../../core/state/app_store.dart';
import '../../../core/utils/catalog_labels.dart';
import '../../../core/utils/currency_formatter.dart';
import '../data/search_dummy_data.dart';
import '../models/search_result_item.dart';
import '../widgets/search_result_card.dart';
import '../widgets/search_suggestion_chip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({
    super.key,
    this.embedded = false,
  });

  final bool embedded;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static const List<String> _audienceOptions = [
    'All',
    ...CatalogLabels.audienceValues,
  ];

  late final TextEditingController _queryController;
  late final List<String> _recentSearches;

  String _selectedAudience = 'All';
  String _selectedSortOption = 'Best Match';

  @override
  void initState() {
    super.initState();
    _queryController = TextEditingController(text: SearchDummyData.activeQuery);
    _recentSearches = [...SearchDummyData.recentSearches];
  }

  @override
  void dispose() {
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = AppScope.of(context);

    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final query = _queryController.text.trim();
        final allResults = store.searchProducts(query);
        final visibleProducts = _sortProducts(
          _filterProductsByAudience(allResults, _selectedAudience),
        );
        final results = visibleProducts
            .map(_toSearchResultItem)
            .toList(growable: false);
        final audienceCounts = {
          for (final audience in _audienceOptions)
            audience: audience == 'All'
                ? allResults.length
                : allResults
                    .where((product) => product.audienceCategory == audience)
                    .length,
        };

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
                    onPressed: () {
                      Navigator.maybePop(context);
                    },
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
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SearchField(
                          controller: _queryController,
                          onChanged: (_) {
                            setState(() {});
                          },
                          onSubmitted: _submitSearch,
                          onClear: () {
                            _queryController.clear();
                            setState(() {
                              _selectedAudience = 'All';
                              _selectedSortOption = 'Best Match';
                            });
                          },
                        ),
                        if (_recentSearches.isNotEmpty) ...[
                          const SizedBox(height: 18),
                          _SectionHeading(
                            title: 'RECENT SEARCHES',
                            actionLabel: 'CLEAR',
                            onAction: () {
                              setState(_recentSearches.clear);
                            },
                          ),
                          const SizedBox(height: 10),
                          Wrap(
                            spacing: 10,
                            runSpacing: 10,
                            children: _recentSearches
                                .map(
                                  (label) => SearchSuggestionChip(
                                    label: label,
                                    onTap: () => _applyQuery(label),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                        const SizedBox(height: 18),
                        const _SectionHeading(title: 'SUGGESTED'),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: SearchDummyData.suggestions
                              .map(
                                (label) => SearchSuggestionChip(
                                  label: label,
                                  onTap: () => _applyQuery(label),
                                ),
                              )
                              .toList(),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          'BROWSE BY DEPARTMENT',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                color: const Color(0xFF666666),
                                letterSpacing: 1.6,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 38,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _audienceOptions.length,
                            separatorBuilder: (_, __) => const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final audience = _audienceOptions[index];
                              return _AudienceChip(
                                label: audience == 'All'
                                    ? 'ALL'
                                    : CatalogLabels.audience(audience).toUpperCase(),
                                count: audienceCounts[audience] ?? 0,
                                isSelected: audience == _selectedAudience,
                                onTap: () {
                                  setState(() {
                                    _selectedAudience = audience;
                                  });
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 26),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'RESULTS (${results.length})',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: const Color(0xFF202020),
                                          fontWeight: FontWeight.w700,
                                        ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    query.isEmpty
                                        ? 'Trending pieces and fresh arrivals from the ARM catalog.'
                                        : 'Sorted by $_selectedSortOption for ${_selectedAudience == 'All' ? 'all departments' : CatalogLabels.audience(_selectedAudience)}.',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: const Color(0xFF727272),
                                          height: 1.4,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            TextButton(
                              onPressed: () => _showFilterSheet(context),
                              style: TextButton.styleFrom(
                                foregroundColor: const Color(0xFF8F8F8F),
                                padding: EdgeInsets.zero,
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: Text(
                                'FILTER',
                                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                      letterSpacing: 1.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        if (results.isEmpty)
                          _SearchEmptyState(
                            query: query,
                            onReset: () {
                              _queryController.clear();
                              setState(() {
                                _selectedAudience = 'All';
                                _selectedSortOption = 'Best Match';
                              });
                            },
                          )
                        else
                          GridView.builder(
                            itemCount: results.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 22,
                              childAspectRatio: 0.56,
                            ),
                            itemBuilder: (context, index) {
                              final item = results[index];
                              return SearchResultCard(
                                item: item,
                                onTap: () {
                                  _submitSearch(query);
                                  store.selectProduct(item.id);
                                  Navigator.pushNamed(
                                    context,
                                    RouteNames.productDetails,
                                  );
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
                if (!widget.embedded) const _SearchBottomBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  void _applyQuery(String value) {
    _queryController.text = value;
    _submitSearch(value);
  }

  void _submitSearch(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      setState(() {});
      return;
    }

    setState(() {
      _recentSearches.removeWhere(
        (entry) => entry.toLowerCase() == trimmed.toLowerCase(),
      );
      _recentSearches.insert(0, trimmed.toUpperCase());
      if (_recentSearches.length > 6) {
        _recentSearches.removeRange(6, _recentSearches.length);
      }
    });
  }

  List<AppProduct> _filterProductsByAudience(
    List<AppProduct> products,
    String audience,
  ) {
    if (audience == 'All') {
      return products;
    }

    return products
        .where((product) => product.audienceCategory == audience)
        .toList(growable: false);
  }

  List<AppProduct> _sortProducts(List<AppProduct> products) {
    final sorted = [...products];

    switch (_selectedSortOption) {
      case 'New In':
        sorted.sort((a, b) {
          final aIsNew = (a.badge ?? '').toUpperCase() == 'NEW' ? 1 : 0;
          final bIsNew = (b.badge ?? '').toUpperCase() == 'NEW' ? 1 : 0;
          final compare = bIsNew.compareTo(aIsNew);
          if (compare != 0) {
            return compare;
          }
          return b.price.compareTo(a.price);
        });
        break;
      case 'Price Low':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'Price High':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'Name A-Z':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Best Match':
      default:
        break;
    }

    return sorted;
  }

  Future<void> _showFilterSheet(BuildContext context) async {
    var stagedAudience = _selectedAudience;
    var stagedSort = _selectedSortOption;

    final result = await showModalBottomSheet<_SearchFilterSelection>(
      context: context,
      backgroundColor: const Color(0xFFF8F6F2),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SEARCH FILTERS',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.1,
                          ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'SORT BY',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF686868),
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _sortOptions
                          .map(
                            (option) => ChoiceChip(
                              label: Text(option.toUpperCase()),
                              selected: stagedSort == option,
                              onSelected: (_) {
                                setModalState(() {
                                  stagedSort = option;
                                });
                              },
                              backgroundColor: Colors.white,
                              selectedColor: Colors.black,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: stagedSort == option
                                        ? Colors.white
                                        : const Color(0xFF434343),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                              side: const BorderSide(color: Color(0xFFD8D5CF)),
                              shape: const RoundedRectangleBorder(),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'DEPARTMENT',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: const Color(0xFF686868),
                            letterSpacing: 1.4,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _audienceOptions
                          .map(
                            (audience) => ChoiceChip(
                              label: Text(
                                audience == 'All'
                                    ? 'ALL'
                                    : CatalogLabels.audience(audience).toUpperCase(),
                              ),
                              selected: stagedAudience == audience,
                              onSelected: (_) {
                                setModalState(() {
                                  stagedAudience = audience;
                                });
                              },
                              backgroundColor: Colors.white,
                              selectedColor: Colors.black,
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                    color: stagedAudience == audience
                                        ? Colors.white
                                        : const Color(0xFF434343),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8,
                                  ),
                              side: const BorderSide(color: Color(0xFFD8D5CF)),
                              shape: const RoundedRectangleBorder(),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              const _SearchFilterSelection(
                                audience: 'All',
                                sortOption: 'Best Match',
                              ),
                            );
                          },
                          child: const Text('RESET'),
                        ),
                        const Spacer(),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop(
                              context,
                              _SearchFilterSelection(
                                audience: stagedAudience,
                                sortOption: stagedSort,
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(),
                          ),
                          child: const Text('APPLY'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (result != null) {
      setState(() {
        _selectedAudience = result.audience;
        _selectedSortOption = result.sortOption;
      });
    }
  }

  SearchResultItem _toSearchResultItem(AppProduct product) {
    return SearchResultItem(
      id: product.id,
      name: product.name,
      category: product.productType,
      price: CurrencyFormatter.lkr(product.price),
      imagePath: product.imagePath,
      background: product.heroGradient,
      icon: product.heroIcon,
      iconColor: product.heroIconColor,
      badge: product.badge,
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: const Color(0xFF666666),
                letterSpacing: 1.6,
                fontWeight: FontWeight.w600,
              ),
        ),
        if (actionLabel != null) ...[
          const Spacer(),
          TextButton(
            onPressed: onAction,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF8F8F8F),
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              actionLabel!,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    letterSpacing: 1.0,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ],
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.controller,
    required this.onChanged,
    required this.onSubmitted,
    required this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD8D5CF)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.search,
            size: 18,
            color: Color(0xFF6E6E6E),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search collections, products, or occasions',
                hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: const Color(0xFF7C7C7C),
                      letterSpacing: 0.2,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: const Color(0xFF3A3A3A),
                    letterSpacing: 0.2,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          if (controller.text.isNotEmpty)
            IconButton(
              onPressed: onClear,
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(
                Icons.close,
                size: 18,
                color: Color(0xFF6C6C6C),
              ),
            ),
        ],
      ),
    );
  }
}

class _AudienceChip extends StatelessWidget {
  const _AudienceChip({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.white,
          border: Border.all(
            color: isSelected ? Colors.black : const Color(0xFFD8D5CF),
          ),
        ),
        child: Text(
          '$label ($count)',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: isSelected ? Colors.white : const Color(0xFF3B3B3B),
                letterSpacing: 0.8,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class _SearchEmptyState extends StatelessWidget {
  const _SearchEmptyState({
    required this.query,
    required this.onReset,
  });

  final String query;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 28),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE7E3DB)),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.search_off_outlined,
            size: 34,
            color: Color(0xFF8C8C8C),
          ),
          const SizedBox(height: 12),
          Text(
            query.isEmpty
                ? 'Start typing to search the live catalog.'
                : 'No pieces found for "$query".',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: const Color(0xFF2D2D2D),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try terms like MONOCHROME, LINEN, BATIK, OFFICE WEAR, or ACCESSORIES.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: const Color(0xFF777777),
                  height: 1.5,
                ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: onReset,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.black,
              side: const BorderSide(color: Color(0xFFD8D5CF)),
              shape: const RoundedRectangleBorder(),
            ),
            child: const Text('CLEAR SEARCH'),
          ),
        ],
      ),
    );
  }
}

class _SearchFilterSelection {
  const _SearchFilterSelection({
    required this.audience,
    required this.sortOption,
  });

  final String audience;
  final String sortOption;
}

const List<String> _sortOptions = [
  'Best Match',
  'New In',
  'Price Low',
  'Price High',
  'Name A-Z',
];

class _SearchBottomBar extends StatelessWidget {
  const _SearchBottomBar();

  @override
  Widget build(BuildContext context) {
    Widget buildItem({
      required IconData icon,
      required String label,
      required bool isSelected,
      required VoidCallback onTap,
    }) {
      final color = isSelected ? Colors.black : const Color(0xFFB7B7B7);

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
              onTap: () {},
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
