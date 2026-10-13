import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/user.dart';

final mockUserProvider =
    Provider<User>((ref) {
  return const User(
    id: 'u1',
    name: 'John Doe',
    email: 'john.doe@example.com',
    phone: '+227 90 00 00 00',
    address: 'Niamey, Niger',
    avatarUrl:
        'assets/images/avatar_placeholder.png',
  );
});