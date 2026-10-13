import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/providers/favorites_provider.dart';
import '../../application/providers/products_provider.dart';

class FavoritesPage
    extends ConsumerWidget {
  const FavoritesPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final productsAsync =
        ref.watch(productsProvider);

    final favorites =
        ref.watch(favoritesProvider).value ??
            [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mes Favoris',
        ),
      ),
      body: productsAsync.when(
        data: (products) {
          final favoriteProducts =
              products
                  .where(
                    (product) =>
                        favorites.contains(
                      product.id,
                    ),
                  )
                  .toList();

          if (favoriteProducts.isEmpty) {
            return const Center(
              child: Text(
                'Aucun favori',
              ),
            );
          }

          return ListView.builder(
            itemCount:
                favoriteProducts.length,
            itemBuilder:
                (context, index) {
              final product =
                  favoriteProducts[index];

              return ListTile(
                leading: Image.asset(
                  product.imageUrl,
                  width: 60,
                ),
                title:
                    Text(product.name),
                subtitle: Text(
                  '${product.price.toStringAsFixed(0)} FCFA',
                ),
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
            error.toString(),
          ),
        ),
      ),
    );
  }
}