import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProductSort {
  none,
  priceAsc,
  priceDesc,
  nameAsc,
  nameDesc,
}

final sortProvider =
    StateProvider<ProductSort>((ref) {
  return ProductSort.none;
});