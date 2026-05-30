import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:request_handling_app/screens/manager_end/request_list.dart';
import 'package:request_handling_app/screens/manager_end/user_profile.dart';
import '../providers/auth_provider.dart';

import '../screens/employee_end/receiver_profile.dart';
import '../screens/employee_end/receiver_request_list.dart';
import '../screens/auth/login_screen.dart';

class AppDrawer extends ConsumerWidget {
  final String role;
  const AppDrawer({super.key, required this.role});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final username = auth.username ?? "Guest";
    final gender = auth.gender ?? "male";

    final avatarPath =
        gender == "female" ? "assets/avatarwoman.webp" : "assets/avatarman.png";

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.blue),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(avatarPath),
            ),
            accountName: Text(
              username,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(role == "end_user" ? "Manager" : "Employee"),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle, color: Colors.blue),
            title: const Text("Profile"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => role == "end_user"
                      ? const UserProfileScreen()
                      : const ReceiverProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.list, color: Colors.blue),
            title: Text(
                role == "end_user" ? "List of all Tasks" : "Assigned Tasks"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => role == "end_user"
                      ? const EndUserRequestListScreen()
                      : const ReceiverRequestListScreen(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout"),
            onTap: () {
              ref.read(authProvider.notifier).logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (_) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
