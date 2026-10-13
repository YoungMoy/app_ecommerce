import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/cart_provider.dart';
import '../../domain/models/cart_item.dart';

class CartPage extends ConsumerWidget {
  const CartPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final List<CartItem> cartItems =
        ref.watch(cartProvider);

    final total =
        cartItems.fold<double>(
      0,
      (sum, item) =>
          sum +
          item.product.price *
              item.quantity,
    );

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Mon Panier'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Votre panier est vide',
              ),
            )
          : ListView.builder(
              itemCount:
                  cartItems.length,
              itemBuilder:
                  (context, index) {
                final item =
                    cartItems[index];

                return ListTile(
                  leading:
                      const Icon(
                    Icons.shopping_bag,
                  ),
                  title: Text(
                    item.product.name,
                  ),
                  subtitle: Text(
                    '${item.quantity} × ${item.product.price.toStringAsFixed(0)} FCFA',
                  ),
                  trailing:
                      IconButton(
                    icon: const Icon(
                      Icons.delete,
                    ),
                    onPressed: () {
                      ref
                          .read(
                            cartProvider
                                .notifier,
                          )
                          .removeProduct(
                            item.product,
                          );
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar:
          cartItems.isEmpty
              ? null
              : Padding(
                  padding:
                      const EdgeInsets
                          .all(
                    16,
                  ),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      Text(
                        'Total : ${total.toStringAsFixed(0)} FCFA',
                        style:
                            const TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight
                                  .bold,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(
                                cartProvider
                                    .notifier,
                              )
                              .clearCart();

                          ScaffoldMessenger.of(
                                  context)
                              .showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Commande validée',
                              ),
                            ),
                          );
                        },
                        child:
                            const Text(
                          'Valider',
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}