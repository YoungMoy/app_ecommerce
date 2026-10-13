import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../notifiers/favorites_notifier.dart';

final favoritesProvider =
    AsyncNotifierProvider<
        FavoritesNotifier,
        List<String>>(
  FavoritesNotifier.new,
);