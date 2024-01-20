import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatServices chatServices = ChatServices();
  final AuthService authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text('H O M E'),
          centerTitle: true,
          elevation: 0,
        ),
        drawer: const MyDrawer(),
        body: _buildUserList());
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: chatServices.getUserStream(),
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("error: ${snapshot.error} "),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text("Loading..."),
          );
        }

        return ListView(
          children: snapshot.data!
              .map<Widget>((userData) => _buildUserListItem(userData, context))
              .toList(),
        );
      }),
    );
  }

  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                reciverEmail: userData["email"],
                reciverID: userData["uid"],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
