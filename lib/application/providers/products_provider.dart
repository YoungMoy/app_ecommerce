import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../../infrastructure/mock_product_repository.dart';

final productRepositoryProvider =
    Provider<ProductRepository>((ref) {
  return MockProductRepository();
});

final productsProvider =
    FutureProvider<List<Product>>((ref) async {
  final repository =
      ref.watch(productRepositoryProvider);

  return repository.fetchProducts();
});

final productByIdProvider =
    FutureProvider.family<Product, String>((
  ref,
  id,
) async {
  final repository =
      ref.watch(productRepositoryProvider);

  return repository.fetchProductById(id);
});