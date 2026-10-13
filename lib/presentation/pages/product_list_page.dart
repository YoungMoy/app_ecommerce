import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/cart_provider.dart';
import '../../application/providers/favorites_provider.dart';
import '../../application/providers/filter_provider.dart';
import '../../application/providers/products_provider.dart';
import '../../application/providers/sort_provider.dart';

import '../widgets/product_tile.dart';

class ProductListPage extends ConsumerWidget {
  const ProductListPage({super.key});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final productsAsync =
        ref.watch(productsProvider);

    final filter =
        ref.watch(filterProvider);

    final sort =
        ref.watch(sortProvider);

    final favorites =
        ref.watch(favoritesProvider).value ??
            [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Catalogue',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final query =
                  await showSearch<String?>(
                context: context,
                delegate:
                    _ProductSearchDelegate(),
              );

              if (query != null &&
                  query.isNotEmpty) {
                ref
                    .read(
                      filterProvider.notifier,
                    )
                    .state = ProductFilter(
                  type:
                      ProductFilterType.search,
                  value: query,
                );
              }
            },
          ),
          PopupMenuButton<ProductSort>(
            icon: const Icon(Icons.sort),
            onSelected: (value) {
              ref
                  .read(
                    sortProvider.notifier,
                  )
                  .state = value;
            },
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: ProductSort.none,
                child: Text('Aucun tri'),
              ),
              PopupMenuItem(
                value: ProductSort.priceAsc,
                child: Text('Prix croissant'),
              ),
              PopupMenuItem(
                value:
                    ProductSort.priceDesc,
                child:
                    Text('Prix décroissant'),
              ),
              PopupMenuItem(
                value: ProductSort.nameAsc,
                child: Text('Nom A-Z'),
              ),
              PopupMenuItem(
                value:
                    ProductSort.nameDesc,
                child: Text('Nom Z-A'),
              ),
            ],
          ),
        ],
      ),
      body: productsAsync.when(
        data: (products) {
          var visible =
              products.where((product) {
            switch (filter.type) {
              case ProductFilterType.all:
                return true;

              case ProductFilterType
                    .category:
                return product.category
                        .toLowerCase() ==
                    (filter.value ?? '')
                        .toLowerCase();

              case ProductFilterType
                    .search:
                final query =
                    (filter.value ?? '')
                        .toLowerCase();

                return product.name
                        .toLowerCase()
                        .contains(query) ||
                    product.description
                        .toLowerCase()
                        .contains(query);
            }
          }).toList();

          switch (sort) {
            case ProductSort.priceAsc:
              visible.sort(
                (a, b) => a.price
                    .compareTo(
                        b.price),
              );
              break;

            case ProductSort.priceDesc:
              visible.sort(
                (a, b) => b.price
                    .compareTo(
                        a.price),
              );
              break;

            case ProductSort.nameAsc:
              visible.sort(
                (a, b) =>
                    a.name.compareTo(
                        b.name),
              );
              break;

            case ProductSort.nameDesc:
              visible.sort(
                (a, b) =>
                    b.name.compareTo(
                        a.name),
              );
              break;

            case ProductSort.none:
              break;
          }

          if (visible.isEmpty) {
            return const Center(
              child: Text(
                'Aucun produit trouvé',
              ),
            );
          }

          return ListView.builder(
            itemCount: visible.length,
            itemBuilder: (
              context,
              index,
            ) {
              final product =
                  visible[index];

              return ProductTile(
                product: product,
                isFavorite:
                    favorites.contains(
                  product.id,
                ),
                onAddToCart: () {
                  ref
                      .read(
                        cartProvider
                            .notifier,
                      )
                      .addProduct(
                        product,
                      );

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        '${product.name} ajouté au panier',
                      ),
                    ),
                  );
                },
                onToggleFavorite: () {
                  ref
                      .read(
                        favoritesProvider
                            .notifier,
                      )
                      .toggleFavorite(
                        product,
                      );
                },
              );
            },
          );
        },
        loading: () =>
            const Center(
          child:
              CircularProgressIndicator(),
        ),
        error: (error, _) =>
            Center(
          child: Text(
            'Erreur : $error',
          ),
        ),
      ),
    );
  }
}

class _ProductSearchDelegate
    extends SearchDelegate<String?> {
  @override
  String get searchFieldLabel =>
      'Rechercher un produit';

  @override
  List<Widget> buildActions(
    BuildContext context,
  ) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon:
            const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(
    BuildContext context,
  ) {
    return IconButton(
      icon:
          const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    close(context, query);

    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(
    BuildContext context,
  ) {
    return const SizedBox.shrink();
  }
}