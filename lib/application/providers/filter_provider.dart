import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProductFilterType {
  all,
  category,
  search,
}

class ProductFilter {
  final ProductFilterType type;
  final String? value;

  const ProductFilter({
    this.type = ProductFilterType.all,
    this.value,
  });

  ProductFilter copyWith({
    ProductFilterType? type,
    String? value,
  }) {
    return ProductFilter(
      type: type ?? this.type,
      value: value ?? this.value,
    );
  }
}

final filterProvider =
    StateProvider<ProductFilter>((ref) {
  return const ProductFilter();
});