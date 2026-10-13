import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/cart_provider.dart';
import '../../application/providers/favorites_provider.dart';
import '../../domain/models/product.dart';
import '../widgets/quantity_selector.dart';

class ProductDetailPage
    extends ConsumerStatefulWidget {
  final Product product;

  const ProductDetailPage({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductDetailPage>
      createState() =>
          _ProductDetailPageState();
}

class _ProductDetailPageState
    extends ConsumerState<ProductDetailPage> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final favorites =
        ref.watch(favoritesProvider).value ??
            [];

    final isFavorite =
        favorites.contains(
      widget.product.id,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.name,
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              ref
                  .read(
                    favoritesProvider
                        .notifier,
                  )
                  .toggleFavorite(
                    widget.product,
                  );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                widget.product.imageUrl,
                height: 250,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.product.name,
              style:
                  const TextStyle(
                fontSize: 24,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '${widget.product.price.toStringAsFixed(0)} FCFA',
              style:
                  const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.product.description,
            ),
            const SizedBox(height: 20),
            QuantitySelector(
              quantity: quantity,
              onIncrement: () {
                setState(() {
                  quantity++;
                });
              },
              onDecrement: () {
                if (quantity > 1) {
                  setState(() {
                    quantity--;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton.icon(
                icon: const Icon(
                  Icons.shopping_cart,
                ),
                label: const Text(
                  'Ajouter au panier',
                ),
                onPressed: () {
                  for (
                    int i = 0;
                    i < quantity;
                    i++
                  ) {
                    ref
                        .read(
                          cartProvider
                              .notifier,
                        )
                        .addProduct(
                          widget.product,
                        );
                  }

                  ScaffoldMessenger.of(
                          context)
                      .showSnackBar(
                    SnackBar(
                      content: Text(
                        '$quantity article(s) ajouté(s)',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}