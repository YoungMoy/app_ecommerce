import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/product.dart';
import '../../infrastructure/local_favorites_storage.dart';

class FavoritesNotifier
    extends AsyncNotifier<List<String>> {
  late final LocalFavoritesStorage _storage;

  @override
  Future<List<String>> build() async {
    _storage = LocalFavoritesStorage();

    return await _storage.loadFavorites();
  }

  Future<void> toggleFavorite(
    Product product,
  ) async {
    final currentFavorites =
        state.value ?? [];

    final updatedFavorites =
        currentFavorites.contains(product.id)
            ? currentFavorites
                .where(
                  (id) => id != product.id,
                )
                .toList()
            : [
                ...currentFavorites,
                product.id,
              ];

    state = AsyncData(
      updatedFavorites,
    );

    await _storage.saveFavorites(
      updatedFavorites,
    );
  }

  Future<void> addFavorite(
    String productId,
  ) async {
    final currentFavorites =
        state.value ?? [];

    if (currentFavorites.contains(productId)) {
      return;
    }

    final updatedFavorites = [
      ...currentFavorites,
      productId,
    ];

    state = AsyncData(
      updatedFavorites,
    );

    await _storage.saveFavorites(
      updatedFavorites,
    );
  }

  Future<void> removeFavorite(
    String productId,
  ) async {
    final currentFavorites =
        state.value ?? [];

    final updatedFavorites =
        currentFavorites
            .where(
              (id) => id != productId,
            )
            .toList();

    state = AsyncData(
      updatedFavorites,
    );

    await _storage.saveFavorites(
      updatedFavorites,
    );
  }

  Future<void> clearFavorites() async {
    state = const AsyncData([]);

    await _storage.clearFavorites();
  }

  bool isFavorite(
    Product product,
  ) {
    return state.value
            ?.contains(product.id) ??
        false;
  }
}