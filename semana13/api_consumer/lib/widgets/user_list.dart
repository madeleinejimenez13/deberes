// lib/widgets/user_list.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class UserList extends StatelessWidget {
  final List<User> users;
  final bool isLoading;
  final String? error;
  final VoidCallback? onRetry;

  const UserList({
    super.key,
    required this.users,
    required this.isLoading,
    this.error,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 48),
            const SizedBox(height: 10),
            Text(
              error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      );
    }

    if (users.isEmpty) {
      return const Center(child: Text('No hay usuarios'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: user.avatar != null
                ? CircleAvatar(backgroundImage: NetworkImage(user.avatar!))
                : CircleAvatar(child: Text(user.id?.toString() ?? '?')),
            title: Text(user.displayName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.job != null) Text(user.job!, style: const TextStyle(fontWeight: FontWeight.w500)),
                if (user.email != null) Text(user.email!, style: const TextStyle(fontSize: 12)),
              ],
            ),
            trailing: const Icon(Icons.person, color: Colors.blue),
          ),
        );
      },
    );
  }
}