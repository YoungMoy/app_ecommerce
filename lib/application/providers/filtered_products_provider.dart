import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/product.dart';
import 'filter_provider.dart';
import 'products_provider.dart';
import '../../application/providers/sort_provider.dart';

final filteredProductsProvider =
    Provider<List<Product>>((ref) {
  final products =
      ref.watch(productsProvider).value ?? [];

  final filter =
      ref.watch(filterProvider);

  final sort =
      ref.watch(sortProvider);

  List<Product> result =
      products.where((product) {
    switch (filter.type) {
      case ProductFilterType.all:
        return true;

      case ProductFilterType.category:
        return product.category
                .toLowerCase() ==
            (filter.value ?? '')
                .toLowerCase();

      case ProductFilterType.search:
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
      result.sort(
        (a, b) =>
            a.price.compareTo(b.price),
      );
      break;

    case ProductSort.priceDesc:
      result.sort(
        (a, b) =>
            b.price.compareTo(a.price),
      );
      break;

    case ProductSort.nameAsc:
      result.sort(
        (a, b) =>
            a.name.compareTo(b.name),
      );
      break;

    case ProductSort.nameDesc:
      result.sort(
        (a, b) =>
            b.name.compareTo(a.name),
      );
      break;

    case ProductSort.none:
      break;
  }

  return result;
});