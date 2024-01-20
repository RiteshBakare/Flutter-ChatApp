import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  CupertinoIcons.chat_bubble_2,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              const Text("C H A T    A P P"),
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Divider(
                  color: Colors.grey,
                  thickness: 2,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListTile(
                  leading: Icon(
                    CupertinoIcons.settings_solid,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, bottom: 30),
            child: ListTile(
              leading: Icon(
                CupertinoIcons.settings_solid,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: Text(
                "Log Out",
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              onTap: () {
                final AuthService authService = AuthService();
                authService.signOut();
              },
            ),
          ),
        ],
      ),
    );
  }
}
