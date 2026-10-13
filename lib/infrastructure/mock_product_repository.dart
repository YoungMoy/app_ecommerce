import 'dart:convert';

import 'package:flutter/services.dart';

import '../domain/models/product.dart';
import '../domain/repositories/product_repository.dart';

class MockProductRepository
    implements ProductRepository {
  @override
  Future<List<Product>>
      fetchProducts() async {
    final jsonString =
        await rootBundle.loadString(
      'assets/products.json',
    );

    final List<dynamic> data =
        json.decode(jsonString);

    return data
        .map(
          (item) => Product.fromJson(
            item as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  Future<Product> fetchProductById(
    String id,
  ) async {
    final products =
        await fetchProducts();

    return products.firstWhere(
      (product) => product.id == id,
      orElse: () {
        throw Exception(
          'Produit introuvable',
        );
      },
    );
  }
}