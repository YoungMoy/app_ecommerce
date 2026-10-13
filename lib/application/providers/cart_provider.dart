import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/cart_item.dart';
import '../notifiers/cart_notifier.dart';

final cartProvider =
    NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);