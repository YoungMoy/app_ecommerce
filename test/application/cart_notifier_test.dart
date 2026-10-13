import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:app_ecommerce/application/providers/cart_provider.dart';
import 'package:app_ecommerce/domain/models/product.dart';

void main() {
  group('CartProvider', () {
    late ProviderContainer container;

    final product = Product(
      id: 'p1',
      name: 'HP',
      price: 1000,
      description: 'PC',
      imageUrl: '',
      category: 'Informatique',
    );

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('ajout produit', () {
      container
          .read(cartProvider.notifier)
          .addProduct(product);

      final cart = container.read(cartProvider);

      expect(cart.length, 1);
      expect(cart.first.quantity, 1);
    });

    test('augmentation quantité', () {
      final notifier =
          container.read(cartProvider.notifier);

      notifier.addProduct(product);
      notifier.addProduct(product);

      final cart = container.read(cartProvider);

      expect(cart.first.quantity, 2);
    });

    test('suppression produit', () {
      final notifier =
          container.read(cartProvider.notifier);

      notifier.addProduct(product);

      notifier.removeProduct(product);

      expect(
        container.read(cartProvider),
        isEmpty,
      );
    });

    test('vider panier', () {
      final notifier =
          container.read(cartProvider.notifier);

      notifier.addProduct(product);

      notifier.clearCart();

      expect(
        container.read(cartProvider),
        isEmpty,
      );
    });
  });
}