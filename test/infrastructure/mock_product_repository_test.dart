import 'package:flutter_test/flutter_test.dart';

import 'package:app_ecommerce/domain/models/product.dart';

void main() {
  group(
    'Product',
    () {
      test(
        'fromJson crée un produit valide',
        () {
          final json = {
            'id': 'p1',
            'name': 'HP',
            'price': 1000,
            'description': 'PC',
            'imageUrl': 'img.png',
            'category': 'Info',
          };

          final product =
              Product.fromJson(
            json,
          );

          expect(product.id, 'p1');
          expect(product.name, 'HP');
          expect(product.price, 1000);
        },
      );
    },
  );
}