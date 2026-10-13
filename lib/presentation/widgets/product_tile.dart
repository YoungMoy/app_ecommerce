import 'package:flutter/material.dart';

import '../../domain/models/product.dart';
import '../pages/product_detail_page.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final bool isFavorite;
  final VoidCallback? onAddToCart;
  final VoidCallback? onToggleFavorite;

  const ProductTile({
    super.key,
    required this.product,
    required this.isFavorite,
    this.onAddToCart,
    this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      elevation: 3,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(
                product: product,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return const Icon(
                          Icons.image_not_supported,
                          size: 40,
                        );
                      },
                ),
              ),
              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style:
                          const TextStyle(
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      product.category,
                      style:
                          const TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${product.price.toStringAsFixed(0)} FCFA',
                      style:
                          const TextStyle(
                        color: Colors.green,
                        fontSize: 16,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  IconButton(
                    icon: Icon(
                      isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: isFavorite
                          ? Colors.red
                          : null,
                    ),
                    onPressed:
                        onToggleFavorite,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.shopping_cart,
                    ),
                    onPressed:
                        onAddToCart,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}