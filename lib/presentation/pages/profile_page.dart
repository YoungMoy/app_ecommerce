import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/providers/user_provider.dart';
import '../../domain/models/user.dart';

class ProfilePage
    extends ConsumerWidget {
  const ProfilePage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final User user =
        ref.watch(
      mockUserProvider,
    );

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Profil'),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(
          16,
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage(
                user.avatarUrl ??
                    'assets/images/avatar_placeholder.png',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              user.name,
              style:
                  const TextStyle(
                fontSize: 22,
                fontWeight:
                    FontWeight.bold,
              ),
            ),
            Text(user.email),
            const SizedBox(
              height: 10,
            ),
            Text(
              user.phone ?? '',
            ),
            Text(
              user.address ?? '',
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context:
                      context,
                  builder: (_) =>
                      AlertDialog(
                    title:
                        const Text(
                      'Profil',
                    ),
                    content:
                        const Text(
                      'Édition du profil simulée.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Modifier',
              ),
            ),
          ],
        ),
      ),
    );
  }
}